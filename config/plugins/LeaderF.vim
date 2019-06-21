let g:Lf_StlColorscheme = 'powerline'
let g:Lf_HideHelp = 1
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_RootMarkers = ['.lfroot', '.root', '.git', '.hg', '.svn']
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = $VARPATH

let g:Lf_ShortcutF = '<LocalLeader>f'
let g:Lf_ShortcutB = '<LocalLeader>b'
noremap <LocalLeader>m :<C-U>LeaderfMru<CR>
noremap <LocalLeader>F :<C-U>LeaderfFunction!<CR>
noremap <LocalLeader>t :<C-U>LeaderfBufTag!<CR>
noremap <LocalLeader>T :<C-U>LeaderfTag<CR>
noremap <LocalLeader>l :<C-U>LeaderfLine<CR>
noremap <LocalLeader>: :<C-U>LeaderfHistoryCmd<CR>
noremap <LocalLeader>/ :<C-U>LeaderfHistorySearch<CR>
noremap <LocalLeader>h :<C-U>LeaderfHelp<CR>
noremap <LocalLeader><space> :<C-U>LeaderfSelf<CR>

function! Leaderf_close()
	echo 'Leaderf_close'
	for i in range(1, winnr('$'))
		let l:bnum = winbufnr(i)
		if getbufvar(bnum, '&buftype') == 'leaderf'
			echo l:bnum
			silent! execute 'bdelete '.l:bnum
			return
		endif
	endfor
endfunction

nnoremap <silent> <LocalLeader>q :call Leaderf_close()<cr>

" Leaderf rg
" ----------
" search regex in current buffer
noremap <LocalLeader>j :<C-U><C-R>=printf("Leaderf! rg --nowrap --current-buffer --stayOpen -e ")<CR>
noremap <LocalLeader>J :<C-U><C-R>=printf("Leaderf! rg --nowrap --append --current-buffer --stayOpen -e ")<CR>
nnoremap <LocalLeader>k :<C-U><C-R>=printf("Leaderf! rg --nowrap -F --current-buffer --stayOpen -e %s ", expand("<cword>"))<CR><CR>
xnoremap <LocalLeader>k :<C-U><C-R>=printf("Leaderf! rg --nowrap -F --current-buffer --stayOpen -e %s ", leaderf#Rg#visual())<CR><CR>
nnoremap <LocalLeader>K :<C-U><C-R>=printf("Leaderf! rg --nowrap --append -F --current-buffer --stayOpen -e %s ", expand("<cword>"))<CR><CR>
xnoremap <LocalLeader>K :<C-U><C-R>=printf("Leaderf! rg --nowrap --append -F --current-buffer --stayOpen -e %s ", leaderf#Rg#visual())<CR><CR>

" search regex in the directory
noremap <LocalLeader>g :<C-U><C-R>=printf("Leaderf! rg --nowrap -e ")<CR>
noremap <LocalLeader>G :<C-U><C-R>=printf("Leaderf! rg --nowrap --append -e ")<CR>
nnoremap <LocalLeader>a :<C-U><C-R>=printf("Leaderf! rg --nowrap -F -e %s", expand("<cword>"))<CR><CR>
xnoremap <LocalLeader>a :<C-U><C-R>=printf("Leaderf! rg --nowrap -F -e %s ", leaderf#Rg#visual())<CR><CR>
nnoremap <LocalLeader>A :<C-U><C-R>=printf("Leaderf! rg --nowrap --append -F -e %s ", expand("<cword>"))<CR><CR>
xnoremap <LocalLeader>A :<C-U><C-R>=printf("Leaderf! rg --nowrap --append -F -e %s ", leaderf#Rg#visual())<CR><CR>

noremap <LocalLeader>r :<C-U>Leaderf! rg --stayOpen --recall<CR>

" noremap <LocalLeader>rc :<C-U><C-R>=printf("Leaderf! rg -e %s -g *.{h,cpp}", expand("<cword>"))<CR>
" noremap <LocalLeader>rj :<C-U><C-R>=printf("Leaderf! rg -e %s -t cpp -t java", expand("<cword>"))<CR>
" noremap <LocalLeader>rcH :<C-U><C-R>=printf("Leaderf! rg -e %s -t cpp -g !*.hpp", expand("<cword>"))<CR>

" Leaderf gtags
" ----------
if executable('gtags-cscope') && executable('gtags')
	let g:Lf_GtagsAutoGenerate = 1
	let g:Lf_Gtagslabel = 'native-pygments'
	noremap <LocalLeader><LocalLeader>r :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
	noremap <LocalLeader><LocalLeader>d :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
	noremap <LocalLeader><LocalLeader>g :<C-U><C-R>=printf("Leaderf! gtags --by-context --auto-jump")<CR><CR>
	noremap <LocalLeader><LocalLeader>o :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
	noremap <LocalLeader><LocalLeader>j :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
	noremap <LocalLeader><LocalLeader>k :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
endif


