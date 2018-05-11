==========
pod2pandoc
==========

SYNOPSIS
========

::

      pod2pandoc [OPTIONS] {INPUT} [ [ -- ] PANDOC_ARGUMENTS ]

      pod2pandoc Module.pm -o Module.pdf
      pod2pandoc script.pl -t markdown
      pod2pandoc Module::Name -o Module-Name.html
      pod2pandoc lib/ wiki/ --ext .md --wiki --index Home -t markdown_github
      pod2pandoc lib/ docs/ --standalone

DESCRIPTION
===========

pod2pandoc converts "Plain Old Documentation" format (aka Pod, see
\ `perlpod <https://metacpan.org/pod/perlpod>`__) to the
\ `Pandoc <http://pandoc.org/>`__\  document model for further
processing to other document formats (HTML, Markdown, LaTeX, PDF, EPUB,
docx, ODT, man…).

By default or with input \ ``-``\  a document is read from STDIN.
Multiple input files are combined to one document and listed in document
metadata field \ ``file``. The result is printed in JSON format or
passed to Pandoc if additional options such as \ ``-t``\  or \ ``-o``\ 
are given.

To process a whole directory of \ ``.pm``\  and/or \ ``.pod``\  files,
specify an input directory as first input and an optional output
directory as second.

OPTIONS
=======

--help\|-h\|-?
    Print out usage information and exit.

--parse FORMATS
    Parse and include data sections. Use \ ``*``\  for all.

--podurl URL
    Base URL to Perl modules. Default: \ ``https://metacpan.org/pod/``.
    A false value such as \ ``0``\  or \ ``""``\  will disable linking
    to external modules.

--ext EXT
    Output file extension when processing a directory. Default:
    \ ``html``.

--index NAME
    Index file (e.g. \ ``index.html``) name when processing a directory.
    Can be disabled with \ ``0``.

--name
    Include \ ``NAME``\  section which is removed by default.

--wiki
    Create wikilinks when processing a directory.

--update
    Only process when input file is newer then output file.

--default-meta FILE
    Read default metadata from given file.

--quiet
    Don't emit warnings and status information.

…
    Additional options are passed through to pandoc executable.

SEE ALSO
========

This script is part of \ :doc:`Pod::Pandoc <Pod-Pandoc>`\  and implemented
in \ :doc:`App::pod2pandoc <App-pod2pandoc>`. Together with Pandoc document
converter it can be used as customizable replacement for specialized Pod
converter scripts such as
\ `pod2html <https://metacpan.org/pod/pod2html>`__,
\ `pod2projdocs <https://metacpan.org/pod/pod2projdocs>`__,
\ `pod2man <https://metacpan.org/pod/pod2man>`__,
\ `pod2readme <https://metacpan.org/pod/pod2readme>`__,
\ `pod2usage <https://metacpan.org/pod/pod2usage>`__,
\ `pod2latex <https://metacpan.org/pod/pod2latex>`__,
\ `pod2markdown <https://metacpan.org/pod/pod2markdown>`__,
\ `pod2text <https://metacpan.org/pod/pod2text>`__, and
\ `pod2projdocs <https://metacpan.org/pod/pod2projdocs>`__.
