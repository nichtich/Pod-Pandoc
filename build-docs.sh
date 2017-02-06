#!/bin/bash
set -e

rm -f docs/*.rst

perl -Ilib script/pod2pandoc lib/ script/ docs/ \
    --ext rst --wiki -t rst --standalone

perl -pi -e 's!`([^`]+) <([^>]+)>`__!-e "docs/$2.rst" ? ":doc:`$1 <$2>`" : "`$1 <$2>`__"!e' docs/*.rst

cp META.json docs

echo "to build HTML from docs, run: make -C docs html"
