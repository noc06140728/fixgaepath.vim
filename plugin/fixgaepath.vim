"=============================================================================
" Vim global plugin for fixing dev_appserver's system path on GAE/Py
" Last Change: 01 May 2013.
" Maintainer: Masahiro Namba <qt.noc06140728@gmail.com>
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================

if exists('g:loaded_fixgaepath')
  finish
endif
let g:loaded_fixgaepath = 1

let s:save_cpo = &cpo
set cpo&vim

if !hasmapto('<Plug>FixgaepathFixpath')
  map <unique> <Leader>g <Plug>FixgaepathFixpath
endif
noremap <unique> <script> <Plug>FixgaepathFixpath :call <SID>fix_path()<CR>

function! s:fix_path() 
python << EOF
import sys, os, vim

sdk_path = os.environ.get('GAE_SDK_PATH')

if sdk_path:
    sys.path.insert(0, sdk_path)
    import dev_appserver
    dev_appserver.fix_sys_path()
    sys.path.insert(0, os.getcwd())
    vim.command('let result = 0')
else:
    vim.command('let result = -1')
EOF
    if result == 0
        echomsg 'Added GAE_SDK_PATH to search path of internal python.'
    else
        echohl WarningMsg | echomsg 'Please set the environment variable GAE_SDK_PATH.' | echohl None
    endif
endfunction

if !exists(':FixGaePath')
  command FixGaePath :call s:fix_path()
endif

let &cpo = s:save_cpo
unlet s:save_cpo

