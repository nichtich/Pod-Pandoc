====================
Pod::Pandoc::Modules
====================

NAME
====

Pod::Pandoc::Modules - set of parsed documentation of Perl modules

SYNOPSIS
========

::

      use Pod::Simple::Pandoc;

      my $modules = Pod::Simple::Pandoc->new->parse_modules('lib');
      $modules->serialize( { target => 'doc' }, '--template' => '...' ] ); # TODO

DESCRIPTION
===========

Module to serialize Pod from a set of parsed Perl or Pod files. Can be
configured via templates, document rewriting etc. and used with many
output formats (html, markdown, and rst to be embedded in static site
generators such as Jekyll).

See \ :doc:`Pod::Simple::Pandoc <Pod-Simple-Pandoc>`\  for how to create
instances of this module.

METHODS
=======

add( $name => $doc )
--------------------

Add a module given as
\ `Pandoc::Document <https://metacpan.org/pod/Pandoc::Document>`__\ 
unless a module of same \ ``$name``\  already exists. As an exception a
parsed \ `.pod <https://metacpan.org/pod/.pod>`__\  file will override
existing entries. The document title is set to the module name if
missing.

serialize ( [ $dir ] [, \\%options ] [, @args ] )
-------------------------------------------------

Serialize a set of modules into a given directory.

This method is experimental and may change!

dir
    Output directory.

ext
    Output file extension. Set to the value of \ ``format``\  by
    default.

index
    Index filename (with or without extension). Set to \ ``index``\  by
    default. Use a false value to disable index generation.

wiki
    Don't create subdirectories and use wiki links for references
    between files. instead.

update
    Generate target files even if source files have not been updated.

quiet
    Don't emit warnings and status information.

index ( %options )
------------------

Create and return an index document as
\ `Pandoc::Document <https://metacpan.org/pod/Pandoc::Document>`__.

SEE ALSO
========

This module is part of \ :doc:`Pod::Pandoc <Pod-Pandoc>`.
