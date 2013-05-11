#=============================================================================
# Vim global plugin for fixing dev_appserver's system path on GAE/Py
# Last Change: 01 May 2013.
# Maintainer: Masahiro Namba <qt.noc06140728@gmail.com>
# License: MIT license  {{{
#     Permission is hereby granted, free of charge, to any person obtaining
#     a copy of this software and associated documentation files (the
#     "Software"), to deal in the Software without restriction, including
#     without limitation the rights to use, copy, modify, merge, publish,
#     distribute, sublicense, and/or sell copies of the Software, and to
#     permit persons to whom the Software is furnished to do so, subject to
#     the following conditions:
#
#     The above copyright notice and this permission notice shall be included
#     in all copies or substantial portions of the Software.
#
#     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
#     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
#     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
#     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
#     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
#     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# }}}
#=============================================================================

import sys, os

def fix_gae_sdk_path(sdk_path):
    sys.path.insert(0, sdk_path)
    import dev_appserver
    dev_appserver.fix_sys_path()

def fix_gae_project_path(leaf_path):
    project_path = search_gae_project(leaf_path)
    if project_path:
        sys.path.insert(0, project_path)

def search_gae_project(leaf_path):
    if os.path.exists(os.path.join(leaf_path, 'app.yaml')):
        return leaf_path
    else:
        if leaf_path == '/':
            return None
        else:
            leaf_path, dummy = os.path.split(leaf_path)
            return search_gae_project(leaf_path)
