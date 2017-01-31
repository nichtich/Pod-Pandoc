# NAME

Pod::Pandoc - process Plain Old Documentation format with Pandoc

# STATUS

[![Build Status](https://travis-ci.org/nichtich/Pod-Pandoc.svg)](https://travis-ci.org/nichtich/Pod-Pandoc)
[![Coverage Status](https://coveralls.io/repos/nichtich/Pod-Pandoc/badge.svg)](https://coveralls.io/r/nichtich/Pod-Pandoc)
[![Kwalitee Score](http://cpants.cpanauthors.org/dist/Pod-Pandoc.png)](http://cpants.cpanauthors.org/dist/Pod-Pandoc)
[![Code Climate Issue Count](https://codeclimate.com/github/nichtich/Pod-Pandoc/badges/issue_count.svg)](https://codeclimate.com/github/nichtich/Pod-Pandoc)

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
