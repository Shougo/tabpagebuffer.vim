"=============================================================================
" FILE: tabpagebuffer.vim
" AUTHOR:  Shougo Matsushita <Shougo dot Matsu at gmail dot com>
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

if exists('g:loaded_tabpagebuffer')
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

augroup tabpagebuffer
  autocmd!
  autocmd BufEnter,BufWinEnter,BufFilePost *
        \ call s:append(expand('<amatch>'))
augroup END

let g:loaded_tabpagebuffer = 1

function! s:append(path) "{{{
  if bufnr('%') != expand('<abuf>')
    return
  endif

  if !exists('t:tabpagebuffer')
    let t:tabpagebuffer = {}
  endif

  " Append the current buffer.
  if exists('*gettabvar')
    " Delete same buffer in other tab pages.
    let bufnr = bufnr('%')
    for tabnr in range(1, tabpagenr('$'))
      let buffer_dict = gettabvar(tabnr, 'tabpagebuffer')
      if type(buffer_dict) == type({}) && has_key(buffer_dict, bufnr)
        call remove(buffer_dict, bufnr)
      endif
      unlet buffer_dict
    endfor
  endif

  let t:tabpagebuffer[bufnr] = 1
endfunction"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" __END__
" vim: foldmethod=marker
