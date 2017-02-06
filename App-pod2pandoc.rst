===============
App::pod2pandoc
===============

NAME
====

App::pod2pandoc - implements pod2pandoc command line script

SYNOPSIS
========

::

      use App::pod2pandoc;

      # pod2pandoc command line script
      my ($input, $opt, @args) = parse_arguments(@ARGV); 
      pod2pandoc($input, $opt, @args);

      # parse a Perl/Pod file and print its JSON serialization
      pod2pandoc( ['example.pl'], {} );

      # parse a Perl/Pod file and convert to HTML with a template
      pod2pandoc( ['example.pl'], {}, '--template', 'template.html' );

      # process directory of Perl modules
      pod2pandoc( [ lib => 'doc'], { ext => 'html' }, '--standalone' );

DESCRIPTION
===========

This module implements the command line script
\ `pod2pandoc <pod2pandoc>`__.

FUNCTIONS
=========

pod2pandoc( \\@input, [ \\%options, ] \\@arguments )
----------------------------------------------------

Processed input files with given \ `pod2pandoc <pod2pandoc>`__\  options
(``data-sections``, \ ``podurl``, \ ``ext``, \ ``wiki``, \ ``meta``,
\ ``update``, and \ ``quiet``) . Additional arguments are passed to
\ ``pandoc``\  executable via module
\ `Pandoc <https://metacpan.org/pod/Pandoc>`__.

Input can be either files and/or module names or directories to
recursively search for \ ``.pm``\  and \ ``.pod``\  files. If no input
is specified, Pod is read from STDIN. When processing directories, the
last input directory is used as output directory.

This function is exported by default.

parse\_arguments( @argv )
-------------------------

Parses options and input arguments from given command line arguments.
May terminate the program with message, for instance with argument
\ ``--help``.

SEE ALSO
========

This module is part of \ `Pod::Pandoc <Pod-Pandoc>`__\  and based on the
modules \ `Pod::Simple::Pandoc <Pod-Simple-Pandoc>`__,
\ `Pod::Pandoc::Modules <Pod-Pandoc-Modules>`__,
\ `Pandoc::Element <https://metacpan.org/pod/Pandoc::Element>`__\  and
\ `Pandoc <https://metacpan.org/pod/Pandoc>`__.
