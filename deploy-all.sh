#!/bin/bash

# build and deploy GitHub wiki
./deploy.sh nichtich/Pod-Pandoc.wiki master wiki

# build and deploy Sphinx documentation
# requires a primary commit to gh-pages branch with Sphinx conf.py and Makefile
./deploy.sh nichtich/Pod-Pandoc gh-pages docs
