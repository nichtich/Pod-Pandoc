# NAME

Pod::Pandoc - process Plain Old Documentation format with Pandoc

# STATUS

[![Build Status](https://travis-ci.org/nichtich/Pod-Pandoc.svg)](https://travis-ci.org/nichtich/Pod-Pandoc)
[![Coverage Status](https://coveralls.io/repos/nichtich/Pod-Pandoc/badge.svg)](https://coveralls.io/r/nichtich/Pod-Pandoc)
[![Kwalitee Score](http://cpants.cpanauthors.org/dist/Pod-Pandoc.png)](http://cpants.cpanauthors.org/dist/Pod-Pandoc)
[![Code Climate Issue Count](https://codeclimate.com/github/nichtich/Pod-Pandoc/badges/issue_count.svg)](https://codeclimate.com/github/nichtich/Pod-Pandoc)
[![Documentation Status](https://readthedocs.org/projects/pod-pandoc/badge/?version=latest)](http://pod-pandoc.readthedocs.io/?badge=latest)

# DESCRIPTION

The Plain Old Documentation format (Pod) is a markup language used to document
Perl code (see [perlpod](https://metacpan.org/pod/perlpod) for reference). Several Perl modules exist to process
and convert Pod into other formats.

Pod::Pandoc is an attempt to unify and extend Pod converting based on the
[Pandoc](http://pandoc.org/) document converter. Pandoc supports more document
formats in a more detailled and uniform way than any set of Perl modules will
ever do. For this reason Pod::Pandoc provides methods to convert Pod to the
Pandoc document model for further processing with Pandoc:

- [pod2pandoc](https://metacpan.org/pod/pod2pandoc) is a command line script to convert Pod to any format supported
by Pandoc
- [App::pod2pandoc](https://metacpan.org/pod/App::pod2pandoc) provides functionality of [pod2pandoc](https://metacpan.org/pod/pod2pandoc) to be used in Perl code
- [Pod::Simple::Pandoc](https://metacpan.org/pod/Pod::Simple::Pandoc) can parse Pod to the abstract document model of Pandoc
- [Pod::Pandoc::Modules](https://metacpan.org/pod/Pod::Pandoc::Modules) holds a set of Pod documents of Perl modules

# EXAMPLES

The [GitHub wiki of this project](https://github.com/nichtich/Pod-Pandoc/wiki)
is filled with wiki pages based on the documentation of each Perl module. The
wiki pages are created with [pod2pandoc](https://metacpan.org/pod/pod2pandoc) as following:

    pod2pandoc lib/ script/ wiki/ --ext md --index Home --wiki -t markdown_github

The documentation can be published in a similar way via GitHub pages (after
enabling this feature in your repository setting):

    pod2pandoc lib/ script/ docs --ext md --wiki -t markdown_github

For generation of documentation with Sphinx we need reStructureText format. The
index file and a configuration file `conf.py` need to be created manually.
Links between files further need to be adjusted because Pandoc does not support
wikilinks in rst output format:

    pod2pandoc lib/ script/ docs/ --index 0 --ext rst --wiki -t rst --standalone
    cd docs
    perl -pi -e 's/`([^`]+) <([^>]+)>`__/-e "$2.rst" ? ":doc:`$1 <$2>`" : "`$1 <$2>`__"/e' *.rst
    cat toctree >> Pod-Pandoc.rst
    make html

The result is published at [http://pod-pandoc.readthedocs.io/](http://pod-pandoc.readthedocs.io/).

# REQUIREMENTS

Installation of this module does not require Pandoc but it is required to make
actual use of it. See [http://pandoc.org/installing.html](http://pandoc.org/installing.html) for installation.

# SEE ALSO

This modules makes obsolete several specialized `Pod::Simple::...` modules
such as [Pod::Simple::HTML](https://metacpan.org/pod/Pod::Simple::HTML), [Pod::Simple::XHTML](https://metacpan.org/pod/Pod::Simple::XHTML), [Pod::Simple::LaTeX](https://metacpan.org/pod/Pod::Simple::LaTeX),
[Pod::Simple::RTF](https://metacpan.org/pod/Pod::Simple::RTF) [Pod::Simple::Text](https://metacpan.org/pod/Pod::Simple::Text), [Pod::Simple::Wiki](https://metacpan.org/pod/Pod::Simple::Wiki), [Pod::WordML](https://metacpan.org/pod/Pod::WordML),
[Pod::Perldoc::ToToc](https://metacpan.org/pod/Pod::Perldoc::ToToc) etc.

It also covers batch conversion such as [Pod::Simple::HTMLBatch](https://metacpan.org/pod/Pod::Simple::HTMLBatch),
[Pod::ProjectDocs](https://metacpan.org/pod/Pod::ProjectDocs), [Pod::POM::Web](https://metacpan.org/pod/Pod::POM::Web), and [Pod::HtmlTree](https://metacpan.org/pod/Pod::HtmlTree).

# AUTHOR

Jakob Voß <jakob.voss@gbv.de>

# COPYRIGHT AND LICENSE

Copyright 2017- Jakob Voß

GNU General Public License, Version 2
