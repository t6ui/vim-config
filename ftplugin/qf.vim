" Snippets from vim-qf
" Credits: https://github.com/romainl/vim-qf

if exists('b:did_ftplugin')
	finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

let b:undo_ftplugin = 'setl fo< com< rnu< nu< bl<'

setlocal winminheight=1 winheight=3
setlocal nowrap
setlocal norelativenumber number
setlocal linebreak
setlocal nolist
setlocal cursorline
setlocal nobuflisted

wincmd J

" https://github.com/mileszs/ack.vim/blob/master/doc/ack.txt
nnoremap <buffer> t   <C-w><CR><C-w>T
nnoremap <buffer> T   <C-w><CR><C-w>TgT<C-W>j
nnoremap <buffer> o    <CR>
" nnoremap <buffer> O    <CR><C-w><C-w>:ccl<CR>
nnoremap <buffer> go   <CR><C-W>j
nnoremap <buffer> s   <C-W><CR><C-W>K
nnoremap <buffer> S   <C-W><CR><C-W>K<C-W>b
nnoremap <buffer> v   <C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t
nnoremap <buffer> V   <C-W><CR><C-W>H<C-W>b<C-W>J
" nnoremap <silent><buffer> p  :call <SID>preview_file()<CR>
nnoremap <silent><buffer> q  :pclose!<CR>:quit<CR>

let b:qf_isLoc = ! empty(getloclist(0))
if b:qf_isLoc == 1
	nnoremap <buffer> O <CR>:lclose<CR>
else
	nnoremap <buffer> O <CR>:cclose<CR>
endif

function! s:preview_file()
	let winwidth = &columns
	let cur_list = b:qf_isLoc == 1 ? getloclist('.') : getqflist()
	let cur_line = getline(line('.'))
	let cur_file = fnameescape(substitute(cur_line, '|.*$', '', ''))
	if cur_line =~# '|\d\+'
		let cur_pos  = substitute(cur_line, '^\(.\{-}|\)\(\d\+\)\(.*\)', '\2', '')
		execute 'vertical pedit! +'.cur_pos.' '.cur_file
	else
		execute 'vertical pedit! '.cur_file
	endif
	wincmd P
	execute 'vert resize '.(winwidth / 2)
	wincmd p
endfunction

let &cpoptions = s:save_cpo
