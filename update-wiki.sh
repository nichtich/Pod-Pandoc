#!/bin/bash
#
# This script is based on a similar script by Domenic Denicola:
# https://gist.github.com/domenic/ec8b0fc8ab45f39403dd
#
set -e

GITHUB_NAME=nichtich
GITHUB_REPO=Pod-Pandoc

# skip pull requests 
[ "${TRAVIS_PULL_REQUEST:-false}" != "false" ] && exit

# skip other branches 
[ "${TRAVIS_BRANCH:-master}" != "master" ] && exit

WIKI_REPO_HTTP=https://github.com/${GITHUB_NAME}/${GITHUB_REPO}.wiki.git
WIKI_REPO_SSH=git@github.com:${GITHUB_NAME}/${GITHUB_REPO}.wiki.git

# clone or update existing wiki repository
if [ -d wiki ]; then
    git -C wiki pull origin master
else    
    git clone ${WIKI_REPO_HTTP} wiki
    git -C wiki remote set-url origin ${WIKI_REPO_SSH}
fi
git -C wiki ls-files

# build wiki pages
rm -f wiki/*.md
perl -Ilib script/pod2pandoc lib/ script/ wiki/ --ext md --index Home --wiki -t markdown_github

# quit unless there are changes to the wiki
git -C wiki diff --quiet --exit-code && exit

# stage all changes (new, modified, deleted files) 
git -C wiki add --all
git -C wiki status --short

# stop unless actually on travis
[ "${TRAVIS}" != "true" ] && exit

VERSION=`git rev-parse --short HEAD`

# commit staged changes
git -C wiki config user.name "Travis CI"
git -C wiki config user.email "travis@example.org"
git -C wiki commit -m "Update ${VERSION}" 

# Generate a SSH key into file 'deploy_key' as described at:
# https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/
#
# Upload public key to your repository and enable push access
# https://github.com/${GITHUB_NAME}/${GITHUB_REPO}/settings/keys
#
# Encrypt private key
# $ travis encrypt-file
#
# Add `deploy_key.enc` to the repository

ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}
openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in deploy_key.enc -out deploy_key -d
chmod 600 deploy_key
eval `ssh-agent -s`
ssh-add deploy_key

# Now that we're all set up, we can push.
git -C wiki push origin master

