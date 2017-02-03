#!/bin/bash
#
# This script is based on a similar script by Domenic Denicola:
# https://gist.github.com/domenic/ec8b0fc8ab45f39403dd
#
set -e

# print error and exit
function die { echo "$1" >&2; exit 1; }
function quit { echo "$1"; exit 0; }

[ "$#" -ne 3 ] && die "Usage: $0 name/repo branch directory"

GITHUB_REPO=$1
BRANCH=$2
BUILD_DIR=$3

REPO_HTTP=https://github.com/${GITHUB_REPO}.git
REPO_SSH=git@github.com:${GITHUB_REPO}.git
BUILD_SCRIPT=build-${BUILD_DIR}.sh

# skip pull requests 
[ "${TRAVIS_PULL_REQUEST:-false}" != "false" ] && exit

# skip other branches 
[ "${TRAVIS_BRANCH:-master}" != "master" ] && exit


echo "Deploying to ${REPO_SSH} branch ${BRANCH} build in ${BUILD_DIR}..."

# make sure build script is executable
[ -x "$BUILD_SCRIPT" ] || die "missing executable build script ${BUILD_SCRIPT}"

# clone or update existing docs repository
if [ -d ${BUILD_DIR} ]; then
    git -C ${BUILD_DIR} pull origin ${BRANCH}
else    
    git clone -b ${BRANCH} ${REPO_HTTP} ${BUILD_DIR}
    git -C ${BUILD_DIR} remote set-url origin ${REPO_SSH}
fi

# show what's currently in there
git -C ${BUILD_DIR} ls-files

# build documentation
./$BUILD_SCRIPT

# quit unless there are changes to the documentation
set +e
git -C ${BUILD_DIR} diff --quiet --exit-code && quit "nothing to commit"
set -e

# stage all changes (new, modified, deleted files) 
git -C ${BUILD_DIR} add --all
git -C ${BUILD_DIR} status --short


# stop unless actually on travis
[ "${TRAVIS}" != "true" ] && quit "skip commit unless on travis"

# make sure we have an encrypted deploy key. Get one like this:
#
# Generate a SSH key into file 'deploy_key' as described at:
# https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/
#
# Upload public key to your repository and enable push access
# https://github.com/${GITHUB_REPO}/settings/keys
#
# Encrypt private key
# $ travis encrypt-file

DEPLOY_KEY=deploy_key

# Add `deploy_key.enc` to the repository
[ -e "${DEPLOY_KEY}.enc" ] || die "missing ${DEPLOY_KEY}.enc"

# make sure we have the encryption label to decrypt key on travis
[ -z "${ENCRYPTION_LABEL}" ] && die "missing \$ENCRYPTION_LABEL"


# commit staged changes
VERSION=`git rev-parse --short HEAD`
git -C ${BUILD_DIR} config user.name "Travis CI"
git -C ${BUILD_DIR} config user.email "travis@example.org"
git -C ${BUILD_DIR} commit -m "Update ${VERSION}" 

# push changes with credentials from deploy key
ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}
openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in ${DEPLOY_KEY}.enc -out ${DEPLOY_KEY} -d
chmod 600 ${DEPLOY_KEY}
eval `ssh-agent -s`
ssh-add ${DEPLOY_KEY}

# engage!
git -C ${BUILD_DIR} push origin ${BRANCH}

quit "...done!"
