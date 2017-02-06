# -*- coding: utf-8 -*-

from __future__ import unicode_literals
import json
import sphinx_rtd_theme
import datetime

# -- General configuration ------------------------------------------------

# If your documentation needs a minimal Sphinx version, state it here.
# needs_sphinx = '1.0'

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = []

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

source_suffix = '.rst'

# Get general information about the project from META.json

with open('META.json') as meta:
    meta = json.load(meta)

master_doc = meta['name']
project = meta['name']

# TODO get actual date and copyright holder?
copyright = '%s, %s' % (datetime.datetime.now().year, meta['author'])

author = meta['author']

# The short X.Y version.
version = meta['version']
# The full version, including alpha/beta/rc tags.
release = meta['version']

language = None

exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']

# The name of the Pygments (syntax highlighting) style to use.
pygments_style = 'sphinx'

highlight_language = 'perl'

# If true, `todo` and `todoList` produce output, else they produce nothing.
todo_include_todos = False

# -- Options for HTML output ----------------------------------------------

html_theme = "sphinx_rtd_theme"
html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]
html_theme_options = { }

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['_static']


# -- Options for HTMLHelp output ------------------------------------------

# Output file base name for HTML help builder.
# TODO: create from meta
htmlhelp_basename = 'PodPandocdoc'


# -- Options for LaTeX output ---------------------------------------------

latex_elements = {
    # The paper size ('letterpaper' or 'a4paper').
    #
    # 'papersize': 'letterpaper',
    
    # The font size ('10pt', '11pt' or '12pt').
    #
    # 'pointsize': '10pt',

    # Additional stuff for the LaTeX preamble.
    #
    # 'preamble': '',

    # Latex figure (float) alignment
    #
    # 'figure_align': 'htbp',
}

# Grouping the document tree into LaTeX files. List of tuples
# (source start file, target name, title,
#  author, documentclass [howto, manual, or own class]).
# TODO: create from meta
latex_documents = [
    (master_doc, 'PodPandoc.tex', u'Pod::Pandoc Documentation',
     u'Jakob Voß', 'manual'),
]


# -- Options for manual page output ---------------------------------------

# One entry per manual page. List of tuples
# (source start file, name, description, authors, manual section).
# TODO: create from meta
man_pages = [
    (master_doc, 'podpandoc', u'Pod::Pandoc Documentation',
     [author], 1)
]


# -- Options for Texinfo output -------------------------------------------

# Grouping the document tree into Texinfo files. List of tuples
# (source start file, target name, title, author,
#  dir menu entry, description, category)
# TODO: create from meta
texinfo_documents = [
    (master_doc, 'PodPandoc', u'Pod::Pandoc Documentation',
     author, 'PodPandoc', 'One line description of project.',
     'Miscellaneous'),
]



