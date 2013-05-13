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

let s:plugin_path = expand('<sfile>:p:h')

function! s:fix_path() 
  if !exists('g:fixgaepath_sdk_path')
    echohl WarningMsg
    echomsg 'Global-variable "g:fixgaepath_sdk_path" not found.'
    echohl None
    return
  endif

  exe 'pyfile ' . s:plugin_path . '/fixgaepath.py'
  python import vim

  if !exists('s:fixed_gae_sdk_path')
    python fix_gae_sdk_path(vim.eval('g:fixgaepath_sdk_path'))
    let s:fixed_gae_sdk_path = 1
  endif

  python fix_gae_project_path(vim.eval('expand("%:p:h")'))

  echomsg 'Added a search path to the SDK for GAE into the internal python.'
endfunction

if !exists(':FixGaePath')
  command FixGaePath :call s:fix_path()
endif

let &cpo = s:save_cpo
unlet s:save_cpo

