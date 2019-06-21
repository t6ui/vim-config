" Key-mappings
"---------------------------------------------------------

" Global niceties {{{

" Fix keybind name for Ctrl+Spacebar
map <Nul> <C-Space>
map! <Nul> <C-Space>

" Start an external command with a single bang
nnoremap ! :!

vnoremap . :normal .<CR>

" Fixing the & Command
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '
"}}}

" File {{{
nnoremap <silent> q :<C-u>close<CR>
autocmd MyAutoCmd FileType man nnoremap <silent><buffer> q :<C-u>:quit<CR>

command BufferEmpty :<C-u>call <SID>BufferEmpty()<CR>

" Fast saving
nnoremap <silent><Leader>w :<C-u>update<CR>
vnoremap <silent><Leader>w :<C-u><Esc>update<CR>

" Save a file with sudo
" http://forrst.com/posts/Use_w_to_sudo_write_a_file_with_Vim-uAN
cmap W!! w !sudo tee % >/dev/null

" }}}

" Edit {{{

" Macros
nnoremap Q q
nnoremap gQ @q

nnoremap x "_x
nnoremap Y y$

" Start new line from any cursor position
inoremap <S-Return> <C-o>o

" Drag current line/s vertically and auto-indent
nnoremap <silent><C-S-Down> :m .+1<CR>==
nnoremap <silent><C-S-Up> :m .-2<CR>==
inoremap <silent><C-S-Down> <Esc>:m .+1<CR>==gi
inoremap <silent><C-S-Up> <Esc>:m .-2<CR>==gi
vnoremap <silent><C-S-Down> :m '>+1<CR>gv=gv
vnoremap <silent><C-S-Up> :m '<-2<CR>gv=gv

" Select last paste
nnoremap <expr> gp '`['.strpart(getregtype(), 0, 1).'`]'

" Duplicate lines
nnoremap <Leader>dd m`YP``
vnoremap <Leader>dd YPgv

" Duplicate paragraph
nnoremap <leader>dp yap<S-}>p
" Align paragraph
" nnoremap <leader>ap =ip

" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv|

" Use tab for indenting
xnoremap <Tab> >gv|
xnoremap <S-Tab> <gv
nmap >>  >>_
nmap <<  <<_

" Remove spaces at the end of lines
nnoremap <silent> d<Space> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

" }}}

" View {{{
nnoremap zl z5l
nnoremap zh z5h

" Improve scroll, credits: https://github.com/Shougo
nnoremap <expr> zz (winline() == (winheight(0)+1) / 2) ?
	\ 'zt' : (winline() == 1) ? 'zb' : 'zz'
noremap <expr> <C-f> max([winheight(0) - 2, 1])
	\ ."\<C-d>".(line('w$') >= line('$') ? "L" : "M")
noremap <expr> <C-b> max([winheight(0) - 2, 1])
	\ ."\<C-u>".(line('w0') <= 1 ? "H" : "M")
noremap <expr> <C-e> (line("w$") >= line('$') ? "j" : "3\<C-e>")
noremap <expr> <C-y> (line("w0") <= 1         ? "k" : "3\<C-y>")

" fold
" nnoremap <CR> za
" nnoremap <S-Return> zMza

" Disable arrow movement, resize splits instead.
nnoremap <Down>  :resize -10<CR>
nnoremap <Up>    :resize +10<CR>
nnoremap <Left>  :vertical resize -10<CR>
nnoremap <Right> :vertical resize +10<CR>

" Window control
" <C-w>z close preview window
nnoremap <silent><Leader>+ :vert resize<CR>:resize<CR>:normal! ze<CR>
nnoremap <silent><Leader>= <C-w>=

" Use <C-L> to clear the highlighting of :set hlsearch.
" if maparg('<C-L>', 'n') ==# ''
"   nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
" endif

" }}}

" Search {{{
" this makes vim's regex engine "not stupid"
" see :h magic
nnoremap / /\v
vnoremap / /\v

" Keep search matches in the middle of the window.
" zz centers the screen on the cursor, zv unfolds any fold if the cursor
" suddenly appears inside a fold.
nnoremap n nzvzz
nnoremap N Nzvzz

" Quick substitute within selected area
xnoremap sg :s//g<Left><Left>

" C-r: Easier search and replace
xnoremap <C-r> :<C-u>call <SID>get_selection('/')<CR>:%s/\V<C-R>=@/<CR>//gc<Left><Left><Left>

if executable('rg')
  " set grepprg=rg\ -H\ --no-heading\ --vimgrep\ --smart-case\ --hidden' . (has('win32') ? ' $* .' : '')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ag')
  " Which has the same effect but not report every match on the line.
  " set grepprg = 'ag --nogroup --nocolor --column --hidden --ignore tags'
  set grepprg=ag\ --vimgrep\ $*
  set grepformat='%f:%l:%c:%m,%f:%l:%m'
endif

command -nargs=+ -complete=file -bar Ack silent! grep! <args>|cwindow|redraw!
nnoremap <Leader>a :Ack<SPACE>
" nnoremap <Leader>A :lgrep! "\b<C-R><C-W>\b"<CR>:lopen<CR>

" Grep in current buffer
nnoremap <Leader>/ :lvimgrep! //j % \| lopen<C-Left><C-Left><C-Left><Left><Left><Left>
nnoremap <Leader>* :execute 'noautocmd lvimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/j % \| lopen'<CR>
vnoremap <Leader>* :<C-u>call <SID>get_selection('/')<CR>:execute 'noautocmd lvimgrep /' . @/ . '/j % \| lopen'<CR>

" Grep in current work directory
" nnoremap <Leader>a :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/j ** \| cw'<CR>
" vnoremap <Leader>a :<C-u>call <SID>get_selection('/')<CR>:execute 'noautocmd vimgrep /' . @/ . '/j ** \| cw'<CR>

" Replaced by vim-asterisk
" xnoremap * :<C-u>call <SID>get_selection('/')<CR>/<C-R>=@/<CR><CR>
" xnoremap # :<C-u>call <SID>get_selection('/')<CR>?<C-R>=@/<CR><CR>

" Returns visually selected text
function! s:get_selection(cmdtype) "{{{
	let temp = @s
	normal! gv"sy
	let @/ = substitute(escape(@s, '\'.a:cmdtype), '\n', '\\n', 'g')
	let @s = temp
endfunction "}}}
" }}}

" Go {{{
" Release keymappings prefixes, evict entirely for use of plug-ins.
nnoremap ,H H
nnoremap ,L L
nnoremap ,M M

nnoremap M $

nnoremap <c-i>  <c-i>zvzz
nnoremap <c-o>  <c-o>zvzz

" Center the screen when jumping through the changelist
nnoremap g; g;zz
nnoremap g, g,zz

" Use backspace key for matchit.vim
nmap <BS> %
xmap <BS> %

" preview-window *definition-search
" nnoremap <C-]> g<C-]>
" nnoremap <LocalLeader>] <C-w>g}
" nnoremap g[ :pop<cr>
" nnoremap g] :tag<cr>

" }}}

" Window & Tabs {{{
nnoremap <silent> <LocalLeader>s  :<C-u>split<CR>
nnoremap <silent> <LocalLeader>v  :<C-u>vsplit<CR>
nnoremap <silent> <LocalLeader>n  :<C-u>tabnew<CR>

" Split current buffer, go to previous window and previous buffer
nnoremap <silent> <LocalLeader>S :split<CR>:wincmd p<CR>:e#<CR>
nnoremap <silent> <LocalLeader>V :vsplit<CR>:wincmd p<CR>:e#<CR>

" Tabs
nnoremap <silent> <C-Tab> :<C-u>tabnext<CR>
nnoremap <silent> <C-S-Tab> <C-u>tabprevious<CR>
nnoremap <silent> g0 :<C-u>tabfirst<CR>
nnoremap <silent> g$ :<C-u>tablast<CR>
" Uses g:lasttab set on TabLeave in MyAutoCmd
let g:lasttab = 1
nmap <silent> gr :execute 'tabn '.g:lasttab<CR>

" nnoremap <silent> <A-h> :call Tab_MoveLeft()<cr>
" nnoremap <silent> <A-l> :call Tab_MoveRight()<cr>

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

" nnoremap <silent><LocalLeader>1 :tabn 1<cr>
" nnoremap <silent><LocalLeader>2 :tabn 2<cr>
" nnoremap <silent><LocalLeader>3 :tabn 3<cr>
" nnoremap <silent><LocalLeader>4 :tabn 4<cr>
" nnoremap <silent><LocalLeader>5 :tabn 5<cr>
" nnoremap <silent><LocalLeader>6 :tabn 6<cr>
" nnoremap <silent><LocalLeader>7 :tabn 7<cr>
" nnoremap <silent><LocalLeader>8 :tabn 8<cr>
" nnoremap <silent><LocalLeader>9 :tabn 9<cr>

function! WipeHiddenBuffers()
	let tpbl=[]
	call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
	for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
		silent execute 'bwipeout' buf
	endfor
endfunction

function! s:BufferEmpty()
	let l:current = bufnr('%')
	if ! getbufvar(l:current, '&modified')
		enew
		silent! execute 'bdelete '.l:current
	endif
endfunction

function! s:SweepBuffers()
	let bufs = range(1, bufnr('$'))
	let hidden = filter(bufs, 'buflisted(v:val) && !bufloaded(v:val)')
	if ! empty(hidden)
		execute 'silent bdelete' join(hidden)
	endif
endfunction

" OpenChangedFiles COMMAND
" Open a split for each dirty file in git
function! OpenChangedFiles()
	only " Close all windows, unless they're modified
	let status =
		\ system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
	let filenames = split(status, "\n")
	exec 'edit ' . filenames[0]
	for filename in filenames[1:]
		exec 'sp ' . filename
	endfor
endfunction

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
" }}}

" Help {{{

if has('mac')
	" Open the macOS dictionary on current word
	nmap <Leader>? :!open dict://<cword><CR><CR>

	" Use Marked for real-time Markdown preview
	if executable('/Applications/Marked 2.app/Contents/MacOS/Marked 2')
		autocmd MyAutoCmd FileType markdown
			\ nmap <buffer><Leader>P :silent !open -a Marked\ 2.app '%:p'<CR>
	endif

	" Use Dash on Mac, for context help
	if executable('/Applications/Dash.app/Contents/MacOS/Dash')
		autocmd MyAutoCmd FileType yaml.ansible,php,css,less,html,markdown
			\ nmap <silent><buffer> K :!open -g dash://"<C-R>=split(&ft, '\.')[0]<CR>:<cword>"&<CR><CR>
		autocmd MyAutoCmd FileType javascript,javascript.jsx,sql,ruby,conf,sh
			\ nmap <silent><buffer> K :!open -g dash://"<cword>"&<CR><CR>
	endif

" Use Zeal on Linux for context help
elseif executable('zeal')
	autocmd MyAutoCmd FileType yaml.ansible,php,css,less,html,markdown
		\ nmap <silent><buffer> K :!zeal --query "<C-R>=split(&ft, '\.')[0]<CR>:<cword>"&<CR><CR>
	autocmd MyAutoCmd FileType javascript,javascript.jsx,sql,ruby,conf,sh
		\ nmap <silent><buffer> K :!zeal --query "<cword>"&<CR><CR>
endif

" }}}

" Rsi {{{
" rsi.vim: Readline style insertion

cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <C-K> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>
cnoremap <C-X><C-A> <C-a>
cnoremap <C-_> <C-K>
" cnoremap <C-Y> <C-R>*
" cnoremap <C-G> <C-C>

" Switch history search pairs
cnoremap <C-P>  <Up>
cnoremap <C-N>  <Down>
cnoremap <Up>   <C-P>
cnoremap <Down> <C-N>

inoremap <C-A> <C-O>^
inoremap <expr> <C-E> col('.')>strlen(getline('.'))<bar><bar>pumvisible()?"\<Lt>C-E>":"\<Lt>End>"
inoremap <expr> <C-B> getline('.')=~'^\s*$'&&col('.')>strlen(getline('.'))?"0\<Lt>C-D>\<Lt>Esc>kJs":"\<Lt>Left>"
inoremap <expr> <C-F> col('.')>strlen(getline('.'))?"\<Lt>C-F>":"\<Lt>Right>"
inoremap <expr> <C-D> col('.')>strlen(getline('.'))?"\<Lt>C-D>":"\<Lt>Del>"
inoremap <C-K> <C-O>D
inoremap <C-X><C-A> <C-A>
inoremap <C-_> <c-K>
inoremap <C-^> <C-O><C-^>

" }}}

" Misc {{{
" Display diff from last save
command! DiffOrig vert new | setlocal bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" Append modeline to EOF
command AppendModeline :<C-u>call <SID>append_modeline()<CR>

" Append modeline after last line in buffer
" See: http://vim.wikia.com/wiki/Modeline_magic
function! s:append_modeline() "{{{
	let l:modeline = printf(' vim: set ts=%d sw=%d tw=%d %set :',
				\ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
	let l:modeline = substitute(&commentstring, '%s', l:modeline, '')
	call append(line('$'), l:modeline)
endfunction "}}}

" http://vimcasts.org/episodes/the-edit-command/
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" When pressing <leader>cd switch to the directory of the open buffer
nnoremap <Leader>. :lcd %:p:h<CR>:pwd<CR>

" Yank buffer's path to X11 clipboard
nnoremap <Leader>1 :let @+=expand("%:p:h")<CR>:echo 'copy directory path'<CR>
nnoremap <Leader>2 :let @+=expand("%:t")<CR>:echo 'copy filename'<CR>
nnoremap <Leader>3 :let @+=expand("%:p")<CR>:echo 'copy full path'<CR>
nnoremap <Leader>4 :let @+=expand("%")<CR>:echo 'copy relative path'<CR>

" Show highlight names under cursor
nmap <silent> gh :echo 'hi<'.synIDattr(synID(line('.'), col('.'), 1), 'name')
	\.'> trans<'.synIDattr(synID(line('.'), col('.'), 0), 'name').'> lo<'
	\.synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name').'>'<CR>

" Source line and selection in vim
vnoremap <Leader>S y:execute @@<CR>:echo 'Sourced selection.'<CR>
nnoremap <Leader>S ^vg_y:execute @@<CR>:echo 'Sourced line.'<CR>

" Background dark/light toggle and contrasts
nnoremap <silent> yob :<C-u>call <SID>toggle_background()<CR>
" nmap <silent> <Leader>tc :<c-u>call <SID>toggle_contrast(-v:count1)<cr>
" nmap <silent> <Leader>tC :<c-u>call <SID>toggle_contrast(+v:count1)<cr>

function! s:toggle_background() " {{{
	if ! exists('g:colors_name')
		echomsg 'No colorscheme set'
		return
	endif
	let l:scheme = g:colors_name

	if l:scheme =~# 'dark' || l:scheme =~# 'light'
		" Rotate between different theme backgrounds
		execute 'colorscheme' (l:scheme =~# 'dark'
					\ ? substitute(l:scheme, 'dark', 'light', '')
					\ : substitute(l:scheme, 'light', 'dark', ''))
	else
		execute 'set background='.(&background ==# 'dark' ? 'light' : 'dark')
		if ! exists('g:colors_name')
			execute 'colorscheme' l:scheme
			echomsg 'The colorscheme `'.l:scheme
				\ .'` doesn''t have background variants!'
		else
			echo 'Set colorscheme to '.&background.' mode'
		endif
	endif
endfunction "}}}"
function! s:toggle_contrast(delta) " {{{
	let l:scheme = ''
	if g:colors_name =~# 'solarized8'
		let l:schemes = map(['_low', '_flat', '', '_high'],
			\ '"solarized8_".(&background).v:val')
		let l:contrast = ((a:delta + index(l:schemes, g:colors_name)) % 4 + 4) % 4
		let l:scheme = l:schemes[l:contrast]
	endif
	if l:scheme !=# ''
		execute 'colorscheme' l:scheme
	endif
endfunction " }}}

" }}}

" vim: set ts=2 sw=2 tw=80 noet :
