===================
Pod::Simple::Pandoc
===================

NAME
====

Pod::Simple::Pandoc - convert Pod to Pandoc document model

SYNOPSIS
========

::

      use Pod::Simple::Pandoc;

      my $parser = Pod::Simple::Pandoc->new( %options );
      my $doc    = $parser->parse_file( $filename );

      # result is a Pandoc::Document object
      my $json = $doc->to_json;
      my $markdown = $doc->to_pandoc( -t => 'markdown' );
      $doc->to_pandoc(qw( -o doc.html --standalone ));

DESCRIPTION
===========

This module converts Pod format
(`perlpod <https://metacpan.org/pod/perlpod>`__) to the document model
used by \ `Pandoc <http://pandoc.org/>`__. The result can be accessed
with methods of
\ `Pandoc::Elements <https://metacpan.org/pod/Pandoc::Elements>`__\  and
further processed with Pandoc to convert it to other document formats
(HTML, Markdown, LaTeX, PDF, EPUB, docx, ODT, man…).

See \ :doc:`pod2pandoc <pod2pandoc>`\  and
\ :doc:`App::pod2pandoc <App-pod2pandoc>`\  for a command line script and a
simplified API to this module.

OPTIONS
=======

parse
    Parse Pod \ `data sections <#data-sections>`__\  with
    \ `Pandoc <https://metacpan.org/pod/Pandoc>`__\  and merge them into
    the document instead of passing them as \ ``RawBlock``. Use
    \ ``*``\  to parse all formats supported by pandoc as input format.
    Expects an array reference otherwise.

podurl
    Base URL to link Perl module names to. Set to
    \ https://metacpan.org/pod/\  by default.

METHODS
=======

parse\_file( $filename \| \*INPUT )
-----------------------------------

Reads Pod from file or filehandle and convert it to a
\ `Pandoc::Document <https://metacpan.org/pod/Pandoc::Document>`__. The
filename is put into document metadata field \ ``file``\  and the module
name. The NAME section, if given, is additionally split into metadata
fields \ ``title``\  and \ ``subtitle``.

parse\_module( $module )
------------------------

Reads Pod from a module given by name such as \ ``"Pod::Pandoc"``.

parse\_string( $string )
------------------------

Reads Pod from string and convert it to a
\ `Pandoc::Document <https://metacpan.org/pod/Pandoc::Document>`__. Also
sets metadata fields \ ``title``\  and \ ``subtitle``.

parse\_dir( $directory )
------------------------

Recursively looks for \ ``.pm``\  and \ ``.pod``\  files in a given
directory and parses them. Returns a hash reference with filenames
mapped to
\ `Pandoc::Document <https://metacpan.org/pod/Pandoc::Document>`__\ 
objects. Each document is enriched with metadata fields \ ``base``\ 
(relative path from each file to the base directory) in addition to
\ ``file``, \ ``title``, and \ ``subtitle``.

parse\_modules( $directory, [ quiet => 0\|1 ] )
-----------------------------------------------

Same as method \ ``parse_dir``\  but returns a
\ `Pod::Simple::Pandoc::Modules <https://metacpan.org/pod/Pod::Simple::Pandoc::Modules>`__\ 
instance that maps module names to
\ `Pandoc::Document <https://metacpan.org/pod/Pandoc::Document>`__\ 
instances. The source directory can also be specified with option
\ ``source``. Option \ ``quiet``\  disables warnings for skipped files.

parse\_and\_merge( @files\_or\_modules )
----------------------------------------

Reads Pod from files or modules given by name and merges them into one
\ `Pandoc::Document <https://metacpan.org/pod/Pandoc::Document>`__\  by
concatenation.

MAPPING
=======

Pod elements are mapped to Pandoc elements as following:

Formatting codes
----------------

`Formatting
codes <https://metacpan.org/pod/perlpod#Formatting Codes>`__\  for
\ *italic text*\  (``I<...>``), \ **bold text**\  (``B<...>``), and
\ ``code``\  (``C<...>``) are mapped to Emphasized text (``Emph``),
strongly emphasized text (``Strong``), and inline code (``Code``).
Formatting code for \ ``filenames``\  (``F<...>``) are mapped to inline
code with class \ ``filename``\  (```...`{.filename}``\  in Pandoc
Markdown). Formatting codes inside code and filenames (e.g.
\ ``code with bold``\  or \ ``http://example.org/``\  as filename) are
stripped to unformatted code. Character escapes (``E<...>``) and
\ ``S<...>``\  are directly mapped to Unicode characters. The special
formatting code \ ``X<...>``\  is ignored.

Links
-----

Some examples of links of different kinds:

http://example.org/

:doc:`pod2pandoc <pod2pandoc>`

`pod2pandoc <pod2pandoc#OPTIONS>`__

`perl(1) <http://linux.die.net/man/1/perl>`__

`"ENVIRONMENT" in crontab(5) <http://linux.die.net/man/5/crontab>`__

`hell itself! <http://linux.die.net/man/5/crontab>`__

Link text can contain formatting codes:

:doc:`pod2pandoc <pod2pandoc>`

Internal links are not supported yet:

`"MAPPING" <#mapping>`__

`mapping from PoD to Pandoc <#mapping>`__

Titles \ *may contain formatting \ ``codes``*!
----------------------------------------------

Lists
-----

#. Numbered lists are
#. converted to \ ``NumberedList``\  and

   -  Bulleted lists are
   -  converted to

      ``BulletList``

Definition
Lists
are
    *also*\  supported.

=over/=back
-----------

    An \ ``=over``\ …\ ``=back``\  region containing no \ ``=item``\  is
    mapped to \ ``BlockQuote``.

Verbatim sections
-----------------

::

      verbatim sections are mapped
        to code blocks

Data sections
-------------

Data sections are passed as \ ``RawBlock``. \ ``HTML``, \ ``LaTeX``,
\ ``TeX``, and \ ``tex``\  are recognized as alias for \ ``html``\  and
\ ``tex``.

Option \ ``parse``\  can be used to parse data sections with pandoc
executable and merge them into the result document.

.. raw:: markdown

   ### Examples

.. raw:: html

   <p>
     HTML is passed through

     as <i>you can see here</i>.
   </p>

.. raw:: html

   <div>HTML is automatically enclosed in
     <code>&ltdiv>...&lt/div></code> if needed.</div>

.. raw:: tex

   \LaTeX\ is passed through as you can see here.

.. raw:: tex

   \LaTeX\ sections should start and end so Pandoc can recognize them.

SEE ALSO
========

This module is based on
\ `Pod::Simple <https://metacpan.org/pod/Pod::Simple>`__\ 
(`Pod::Simple::SimpleTree <https://metacpan.org/pod/Pod::Simple::SimpleTree>`__).
It makes obsolete several specialized \ ``Pod::Simple::...``\  modules
such as
\ `Pod::Simple::HTML <https://metacpan.org/pod/Pod::Simple::HTML>`__,
\ `Pod::Simple::XHTML <https://metacpan.org/pod/Pod::Simple::XHTML>`__,
\ `Pod::Simple::LaTeX <https://metacpan.org/pod/Pod::Simple::LaTeX>`__,
\ `Pod::Simple::RTF <https://metacpan.org/pod/Pod::Simple::RTF>`__\ 
\ `Pod::Simple::Text <https://metacpan.org/pod/Pod::Simple::Text>`__,
\ `Pod::Simple::Wiki <https://metacpan.org/pod/Pod::Simple::Wiki>`__,
\ `Pod::WordML <https://metacpan.org/pod/Pod::WordML>`__,
\ `Pod::Perldoc::ToToc <https://metacpan.org/pod/Pod::Perldoc::ToToc>`__\ 
etc.
