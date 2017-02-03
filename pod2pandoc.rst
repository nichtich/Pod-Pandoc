==========
pod2pandoc
==========

NAME
====

pod2pandoc - convert Pod to Pandoc document model

SYNOPSIS
========

::

      pod2pandoc [OPTIONS] {INPUT} [ [ -- ] PANDOC_ARGUMENTS ]
      pod2pandoc [OPTIONS] {INPUT} | pandoc -f json [ PANDOC_ARGUMENTS ]

      pod2pandoc Module.pm -o Module.pdf
      pod2pandoc script.pl -t markdown
      pod2pandoc Module::Name -o ModuleName.html
      pod2pandoc lib/ wiki/ --ext .md --wiki --index Home -t markdown_github
      pod2pandoc lib/ docs/ --standalone

DESCRIPTION
===========

pod2pandoc converts POD format documentation
(`perlpod <https://metacpan.org/pod/perlpod>`__) to the
\ `Pandoc <http://pandoc.org/>`__\  document model so it can be
processed to other formats (HTML, Markdown, LaTeX, PDF, EPUB, docx, ODT,
man, ICML…). By default or with input \ ``-``\  a document is read from
STDIN. Multiple input files are combined to one document and listed in
document metadata field \ ``file``. The result is printed in JSON format
or passed to Pandoc if additional options such as \ ``-t``\  or
\ ``-o``\  are given.

To process a whole directory of \ ``.pm``\  and/or \ ``.pod``\  files,
specify an input directory as first input and an optional output
directory as second.

OPTIONS
=======

--help\|-h\|-?
    Print out usage information and exit

--data-sections
    Parse and include data sections (e.g. \ ``=for markdown``)

--podurl URL
    Base URL to Perl modules. Default: \ ``https://metacpan.org/pod/``

--ext EXT
    Output file extension when processing a directory. Default:
    \ ``html``

--index NAME
    Index file name when processing a directory. Disable with \ ``0``

--wiki
    Create wikilinks and flat files when processing a directory

--update
    Only process when input file is newer then output file

--quiet
    Don't emit warnings and status information

…
    All other options are passed through to pandoc

SEE ALSO
========

This script is part of \ `Pod::Pandoc <Pod-Pandoc>`__\  and implemented
in \ `App::pod2pandoc <App-pod2pandoc>`__. Together with Pandoc document
converter it can be used as customizable replacement for specialized Pod
converter scripts such as
\ `pod2html <https://metacpan.org/pod/pod2html>`__,
\ `pod2projdocs <https://metacpan.org/pod/pod2projdocs>`__,
\ `pod2man <https://metacpan.org/pod/pod2man>`__,
\ `pod2readme <https://metacpan.org/pod/pod2readme>`__,
\ `pod2usage <https://metacpan.org/pod/pod2usage>`__,
\ `pod2latex <https://metacpan.org/pod/pod2latex>`__,
\ `pod2markdown <https://metacpan.org/pod/pod2markdown>`__, and
\ `pod2text <https://metacpan.org/pod/pod2text>`__.
