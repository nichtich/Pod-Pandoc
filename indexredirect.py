# -*- coding: utf-8 -*-
"""
    sphinx.ext.indexredirect
    ~~~~~~~~~~~~~~~~~~~~~~~~

    To publish HTML docs with a master document (``master_doc``) other than
    ``index`` create an ``index.html`` that redirects to the master document.

    :copyright: Copyright 2017- by Jakob Voss
    :license: BSD, see LICENSE for details.
"""

import os
import sphinx

html = """
<!DOCTYPE HTML>
<html lang="en-US">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="refresh" content="1; url=%s.html">
        <script type="text/javascript">
            window.location.href = "%s.html"
        </script>
        <title>Page Redirection</title>
    </head>
    <body>
        If you are not redirected automatically,
        follow <a href="%s.html">this link</a>.
    </body>
</html>
"""

def create_index_redirect(app, env):
    if app.builder.format == 'html':
        master_doc = env.config.master_doc
        if master_doc != 'index':
            path = os.path.join(app.builder.outdir, 'index.html')
            index = open(path, 'wt')
	    index.write(html % tuple([master_doc] * 3))
	    index.close()


def setup(app):
    app.connect('env-updated', create_index_redirect)
    return {'version': sphinx.__display_version__, 'parallel_read_safe': True}
