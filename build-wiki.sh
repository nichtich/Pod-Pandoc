#!/bin/bash

rm -f wiki/*.md
perl -Ilib script/pod2pandoc lib/ script/ wiki/ \
    --ext md --index Home --wiki -t markdown_github
