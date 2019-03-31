" Plugin Settings
"---------------------------------------------------------

if dein#tap('vim-startify')
  noremap <Leader>se :<c-u>SSave<cr>
  noremap <Leader>os :<c-u>SLoad<cr>
  " noremap <leader>ss :<c-u>tabnew<cr>:Startify<cr>
  " noremap <leader>sd :<c-u>SDelete<cr>
  " noremap <leader>sc :<c-u>SClose<cr>
endif

" Define an Abbreviation to Expand :grep to :GrepperGrep
function! s:SetupCommandAlias(input, output)
  exec 'cabbrev <expr> '.a:input
    \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:input.'")'
    \ .'? ("'.a:output.'") : ("'.a:input.'"))'
endfunction

function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

if dein#tap('vim-grepper')
  call s:SetupCommandAlias("grep", "Grepper")
  nnoremap <Leader>ss :Grepper -buffer<CR>
  nnoremap <Leader>sS :Grepper -buffer -cword -noprompt<CR>
  nnoremap <Leader>sb :Grepper -buffers<CR>
  nnoremap <Leader>sB :Grepper -buffers -cword -noprompt<CR>
  nnoremap <Leader>sd :Grepper<CR>
  nnoremap <leader>sD :Grepper -cword -noprompt<CR>

  " Operator mode
  noremap S <plug>(GrepperOperator)

  " Grep in current buffer by vimgrep
  nnoremap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/j % \| cw'<CR>
  xnoremap <leader>* :<C-u>call <SID>VSetSearch()<CR>:execute 'noautocmd vimgrep /' . @/ . '/j % \| cw'<CR>
  " Grep in current work directory by vimgrep
  " nnoremap <leader><leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/j ** \| cw'<CR>
  " vnoremap <leader><leader>* :<C-u>call <SID>VSetSearch()<CR>:execute 'noautocmd vimgrep /' . @/ . '/j ** \| cw'<CR>

  " This is implemented by vim-asterisk
  " xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
  " xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
endif

if dein#tap('deol.nvim')
  function! s:openDeol()
    exe 'topleft split'
    let lines = &lines * 30 / 100
    exe 'resize ' . lines
    Deol
  endfunc

  nnoremap <silent> <Leader>' :<C-u>call <SID>openDeol()<cr>
endif

" Tabs
nnoremap <silent> <A-h> :call Tab_MoveLeft()<cr>
nnoremap <silent> <A-l> :call Tab_MoveRight()<cr>

function! Tab_MoveLeft()
  let l:tabnr = tabpagenr() - 2
  if l:tabnr >= 0
    exec 'tabmove '.l:tabnr
  endif
endfunc

function! Tab_MoveRight()
  let l:tabnr = tabpagenr() + 1
  if l:tabnr <= tabpagenr('$')
    exec 'tabmove '.l:tabnr
  endif
endfunc

nnoremap <silent><Leader>1 :tabn 1<cr>
nnoremap <silent><Leader>2 :tabn 2<cr>
nnoremap <silent><Leader>3 :tabn 3<cr>
nnoremap <silent><Leader>4 :tabn 4<cr>
nnoremap <silent><Leader>5 :tabn 5<cr>
nnoremap <silent><Leader>6 :tabn 6<cr>
nnoremap <silent><Leader>7 :tabn 7<cr>
nnoremap <silent><Leader>8 :tabn 8<cr>
nnoremap <silent><Leader>9 :tabn 9<cr>

" keymap to switch tab in both gui and terminal (need config)
if has('gui_running')
  " <m-1> is equal to <A-1>
  noremap <silent><m-1> :tabn 1<cr>
  noremap <silent><m-2> :tabn 2<cr>
  noremap <silent><m-3> :tabn 3<cr>
  noremap <silent><m-4> :tabn 4<cr>
  noremap <silent><m-5> :tabn 5<cr>
  noremap <silent><m-6> :tabn 6<cr>
  noremap <silent><m-7> :tabn 7<cr>
  noremap <silent><m-8> :tabn 8<cr>
  noremap <silent><m-9> :tabn 9<cr>
  noremap <silent><m-0> :tabn 10<cr>
  inoremap <silent><m-1> <ESC>:tabn 1<cr>
  inoremap <silent><m-2> <ESC>:tabn 2<cr>
  inoremap <silent><m-3> <ESC>:tabn 3<cr>
  inoremap <silent><m-4> <ESC>:tabn 4<cr>
  inoremap <silent><m-5> <ESC>:tabn 5<cr>
  inoremap <silent><m-6> <ESC>:tabn 6<cr>
  inoremap <silent><m-7> <ESC>:tabn 7<cr>
  inoremap <silent><m-8> <ESC>:tabn 8<cr>
  inoremap <silent><m-9> <ESC>:tabn 9<cr>
  inoremap <silent><m-0> <ESC>:tabn 10<cr>
  noremap <silent><m-o> :browse tabnew<cr>
  inoremap <silent><m-o> <ESC>:browse tabnew<cr>
endif

" cmd+N to switch tab quickly in macvim
if has("gui_macvim")
  set macmeta
  noremap <silent><d-1> :tabn 1<cr>
  noremap <silent><d-2> :tabn 2<cr>
  noremap <silent><d-3> :tabn 3<cr>
  noremap <silent><d-4> :tabn 4<cr>
  noremap <silent><d-5> :tabn 5<cr>
  noremap <silent><d-6> :tabn 6<cr>
  noremap <silent><d-7> :tabn 7<cr>
  noremap <silent><d-8> :tabn 8<cr>
  noremap <silent><d-9> :tabn 9<cr>
  noremap <silent><d-0> :tabn 10<cr>
  inoremap <silent><d-1> <ESC>:tabn 1<cr>
  inoremap <silent><d-2> <ESC>:tabn 2<cr>
  inoremap <silent><d-3> <ESC>:tabn 3<cr>
  inoremap <silent><d-4> <ESC>:tabn 4<cr>
  inoremap <silent><d-5> <ESC>:tabn 5<cr>
  inoremap <silent><d-6> <ESC>:tabn 6<cr>
  inoremap <silent><d-7> <ESC>:tabn 7<cr>
  inoremap <silent><d-8> <ESC>:tabn 8<cr>
  inoremap <silent><d-9> <ESC>:tabn 9<cr>
  inoremap <silent><d-0> <ESC>:tabn 10<cr>
  noremap <silent><d-o> :browse tabnew<cr>
  inoremap <silent><d-o> <ESC>:browse tabnew<cr>
endif

" Display diff from last save
command! DiffOrig vert new | setlocal bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" http://vimcasts.org/episodes/the-edit-command/
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Use <C-L> to clear the highlighting of :set hlsearch.
" if maparg('<C-L>', 'n') ==# ''
"   nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
" endif


" Global niceties {{{
" ---------------
vnoremap . :normal .<CR>

" preview-window *definition-search
nnoremap <C-]> g<C-]>
nnoremap [window]] <C-w>g}
nnoremap g[ :pop<cr>
nnoremap g] :tag<cr>

" Fixing the & Command
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" insert mode as emacs
" inoremap <C-h> <C-o>h
" inoremap <C-l> <C-o>l
" inoremap <C-j> <C-o>j
" inoremap <C-k> <C-o>k
" inoremap <c-a> <home>
" inoremap <c-e> <end>
" inoremap <c-d> <del>
" inoremap <c-_> <c-k>
" inoremap <C-^> <C-o><C-^>
" cnoremap <C-y> <C-r>*
" cnoremap <C-g> <C-c>

" }}}

" vim: set ts=2 sw=2 tw=80 noet :

