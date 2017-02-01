===========
Pod::Pandoc
===========

NAME
====

Pod::Pandoc - process Plain Old Documentation format with Pandoc

DESCRIPTION
===========

The Plain Old Documentation format (Pod) is a markup language used to
document Perl code (see
\ `perlpod <https://metacpan.org/pod/perlpod>`__\  for reference).
Several Perl modules exist to process and convert Pod into other
formats.

Pod::Pandoc is an attempt to unify and extend Pod converting based on
the \ `Pandoc <http://pandoc.org/>`__\  document converter. Pandoc
supports more document formats in a more detailled and uniform way than
any set of Perl modules will ever do. For this reason Pod::Pandoc
provides methods to convert Pod to the Pandoc document model for further
processing with Pandoc:

-  :doc:`pod2pandoc <pod2pandoc>`\  is a command line script to convert Pod
   to any format supported by Pandoc
-  :doc:`App::pod2pandoc <App-pod2pandoc>`\  provides functionality of
   \ :doc:`pod2pandoc <pod2pandoc>`\  to be used in Perl code
-  :doc:`Pod::Simple::Pandoc <Pod-Simple-Pandoc>`\  can parse Pod to the
   abstract document model of Pandoc
-  :doc:`Pod::Pandoc::Modules <Pod-Pandoc-Modules>`\  holds a set of Pod
   documents of Perl modules

EXAMPLES
========

The \ `GitHub wiki of this
project <https://github.com/nichtich/Pod-Pandoc/wiki>`__\  is filled
with wiki pages based on the documentation of each Perl module. The wiki
pages are created with \ :doc:`pod2pandoc <pod2pandoc>`\  as following:

::

      pod2pandoc lib/ script/ wiki/ --ext md --index Home --wiki -t markdown_github

The documentation can be published in a similar way via GitHub pages
(after enabling this feature in your repository setting):

::

      pod2pandoc lib/ script/ docs --ext md --wiki -t markdown_github

For generation of documentation with Sphinx we need reStructureText
format. The index file and a configuration file \ ``conf.py``\  need to
be created manually. Links between files further need to be adjusted
because Pandoc does not support wikilinks in rst output format:

::

      pod2pandoc lib/ script/ docs/ --index 0 --ext rst --wiki -t rst --standalone
      cd docs
      perl -pi -e 's/`([^`]+) <([^>]+)>`__/-e "$2.rst" ? ":doc:`$1 <$2>`" : "`$1 <$2>`__"/e' *.rst
      make html

The result is published at \ http://pod-pandoc.readthedocs.io/.

REQUIREMENTS
============

Installation of this module does not require Pandoc but it is required
to make actual use of it. See \ http://pandoc.org/installing.html\  for
installation.

SEE ALSO
========

This modules makes obsolete several specialized \ ``Pod::Simple::...``\ 
modules such as
\ `Pod::Simple::HTML <https://metacpan.org/pod/Pod::Simple::HTML>`__,
\ `Pod::Simple::XHTML <https://metacpan.org/pod/Pod::Simple::XHTML>`__,
\ `Pod::Simple::LaTeX <https://metacpan.org/pod/Pod::Simple::LaTeX>`__,
\ `Pod::Simple::RTF <https://metacpan.org/pod/Pod::Simple::RTF>`__\ 
\ `Pod::Simple::Text <https://metacpan.org/pod/Pod::Simple::Text>`__,
\ `Pod::Simple::Wiki <https://metacpan.org/pod/Pod::Simple::Wiki>`__,
\ `Pod::WordML <https://metacpan.org/pod/Pod::WordML>`__,
\ `Pod::Perldoc::ToToc <https://metacpan.org/pod/Pod::Perldoc::ToToc>`__\ 
etc.

It also covers batch conversion such as
\ `Pod::Simple::HTMLBatch <https://metacpan.org/pod/Pod::Simple::HTMLBatch>`__,
\ `Pod::ProjectDocs <https://metacpan.org/pod/Pod::ProjectDocs>`__,
\ `Pod::POM::Web <https://metacpan.org/pod/Pod::POM::Web>`__, and
\ `Pod::HtmlTree <https://metacpan.org/pod/Pod::HtmlTree>`__.

AUTHOR
======

Jakob Voß <jakob.voss@gbv.de>

COPYRIGHT AND LICENSE
=====================

Copyright 2017- Jakob Voß

GNU General Public License, Version 2

