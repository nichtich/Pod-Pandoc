===========
Pod::Pandoc
===========

NAME
====

Pod::Pandoc - process Plain Old Documentation format with Pandoc

.. raw:: markdown

   # STATUS

   [![Build Status](https://travis-ci.org/nichtich/Pod-Pandoc.svg)](https://travis-ci.org/nichtich/Pod-Pandoc)
   [![Coverage Status](https://coveralls.io/repos/nichtich/Pod-Pandoc/badge.svg)](https://coveralls.io/r/nichtich/Pod-Pandoc)
   [![Kwalitee Score](http://cpants.cpanauthors.org/dist/Pod-Pandoc.png)](http://cpants.cpanauthors.org/dist/Pod-Pandoc)
   [![Code Climate Issue Count](https://codeclimate.com/github/nichtich/Pod-Pandoc/badges/issue_count.svg)](https://codeclimate.com/github/nichtich/Pod-Pandoc)
   [![Documentation Status](https://readthedocs.org/projects/pod-pandoc/badge/?version=latest)](http://pod-pandoc.readthedocs.io/?badge=latest)

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
processing with Pandoc.

OUTLINE
=======

-  `pod2pandoc <pod2pandoc>`__\  is a command line script to convert Pod
   to any format supported by Pandoc
-  `App::pod2pandoc <App-pod2pandoc>`__\  provides functionality of
   \ `pod2pandoc <pod2pandoc>`__\  to be used in Perl code
-  `Pod::Simple::Pandoc <Pod-Simple-Pandoc>`__\  can parse Pod to the
   abstract document model of Pandoc
-  `Pod::Pandoc::Modules <Pod-Pandoc-Modules>`__\  holds a set of Pod
   documents of Perl modules

EXAMPLES
========

GitHub wiki and Sphinx documentation are automatically build on each
commit to the \ ``master``\  branch (see script \ ``deploy.sh``).

GitHub wiki
-----------

The \ `GitHub wiki of this
project <https://github.com/nichtich/Pod-Pandoc/wiki>`__\  is
automatically populated with its module documentation. Wiki pages are
created with \ `pod2pandoc <pod2pandoc>`__\  as following (see script
\ ``update-wiki.sh``:

::

      pod2pandoc lib/ script/ wiki/ --ext md --index Home --wiki -t markdown_github

Sphinx and Read The Docs
------------------------

The \ `Sphinx documentation generator <https://sphinx-doc.org/>`__\ 
recommends documents in reStructureText format. It further requires a
configuration file \ ``conf.py``\  and some links need to be adjusted
because Pandoc does not support wikilinks in rst output format (see
script \ ``update-docs.sh``:

::

      pod2pandoc lib/ script/ docs/ --index 0 --ext rst --wiki -t rst --standalone
      perl -pi -e 's/`([^`]+) <([^>]+)>`__/-e "$2.rst" ? ":doc:`$1 <$2>`" : "`$1 <$2>`__"/e' docs/*.rst
      make -C docs html

The result is published automatically at \ http://pod-pandoc.rtfd.io/.

REQUIREMENTS
============

Installation of this module does not require Pandoc but it is required
to make actual use of it. See \ http://pandoc.org/installing.html\  for
installation.

SEE ALSO
========

This module is basde on the wrapper module
\ `Pandoc <https://metacpan.org/pod/Pandoc>`__\  to execute pandoc from
Perl and on the module
\ `Pandoc::Elements <https://metacpan.org/pod/Pandoc::Elements>`__\  for
pandoc document processing.

This module makes obsolete several specialized \ ``Pod::Simple::...``\ 
modules such as
\ `Pod::Simple::HTML <https://metacpan.org/pod/Pod::Simple::HTML>`__,
\ `Pod::Simple::XHTML <https://metacpan.org/pod/Pod::Simple::XHTML>`__,
\ `Pod::Simple::LaTeX <https://metacpan.org/pod/Pod::Simple::LaTeX>`__,
\ `Pod::Simple::RTF <https://metacpan.org/pod/Pod::Simple::RTF>`__\ 
\ `Pod::Simple::Text <https://metacpan.org/pod/Pod::Simple::Text>`__,
\ `Pod::Simple::Wiki <https://metacpan.org/pod/Pod::Simple::Wiki>`__,
\ `Pod::WordML <https://metacpan.org/pod/Pod::WordML>`__,
\ `Pod::Perldoc::ToToc <https://metacpan.org/pod/Pod::Perldoc::ToToc>`__\ 
etc. It also covers batch conversion such as
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

.. toctree::
   :hidden:
   :glob:

   *
