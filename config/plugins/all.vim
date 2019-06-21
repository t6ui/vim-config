
" Plugin Settings
"---------------------------------------------------------
if dein#tap('vim-which-key')
  nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
  nnoremap <silent> <localleader> :<c-u>WhichKey ';'<CR>
endif

if dein#tap('vim-rooter')
	nnoremap <Leader>, :<c-u>Rooter<CR>
endif

if dein#tap('vim-preview')
  nnoremap <silent>S :PreviewTag<cr>
  " nnoremap <silent>X :PreviewClose<cr>
  " noremap <silent><tab>; :PreviewGoto edit<cr>
  " noremap <silent><tab>: :PreviewGoto tabe<cr>
  " nnoremap _ :<c-u>PreviewScroll -1<cr>
  " nnoremap + :<c-u>PreviewScroll +1<cr>
  nnoremap <C-p> :<c-u>PreviewScroll -1<cr>
  nnoremap <C-n> :<c-u>PreviewScroll +1<cr>
  nnoremap <C-s> :PreviewSignature!<cr>
  inoremap <C-s> <c-\><c-o>:PreviewSignature!<cr>
  autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
  autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
endif

if dein#tap('vim-startify')
  " noremap <Leader>ss :<c-u>SSave<cr>
  " noremap <Leader>sl :<c-u>SLoad<cr>
endif

if dein#tap('denite.nvim')
	nnoremap <silent><LocalLeader>r :<C-u>Denite -resume -refresh -no-start-filter<CR>
	nnoremap <silent><LocalLeader>f :<C-u>Denite file/rec<CR>
	nnoremap <silent><LocalLeader>b :<C-u>Denite buffer file/old -default-action=switch<CR>
	nnoremap <silent><LocalLeader>d :<C-u>Denite directory_rec -default-action=cd<CR>
	nnoremap <silent><LocalLeader>v :<C-u>Denite neoyank -buffer-name=register<CR>
	xnoremap <silent><LocalLeader>v :<C-u>Denite neoyank -buffer-name=register -default-action=replace<CR>
	nnoremap <silent><LocalLeader>l :<C-u>Denite location_list -buffer-name=list<CR>
	nnoremap <silent><LocalLeader>q :<C-u>Denite quickfix -buffer-name=list<CR>
	nnoremap <silent><LocalLeader>n :<C-u>Denite dein<CR>
	nnoremap <silent><LocalLeader>g :<C-u>Denite grep -buffer-name=search<CR>
	nnoremap <silent><LocalLeader>j :<C-u>Denite jump change file/point -buffer-name=jump<CR>
	nnoremap <silent><LocalLeader>u :<C-u>Denite junkfile:new junkfile<CR>
	nnoremap <silent><LocalLeader>o :<C-u>Denite outline<CR>
	nnoremap <silent><LocalLeader>s :<C-u>Denite session -buffer-name=list<CR>
	nnoremap <silent><LocalLeader>t :<C-u>Denite -buffer-name=tag tag:include<CR>
	nnoremap <silent><LocalLeader>p :<C-u>Denite jump -buffer-name=jump<CR>
	nnoremap <silent><LocalLeader>h :<C-u>Denite help<CR>
	nnoremap <silent><LocalLeader>m :<C-u>Denite file/rec -buffer-name=memo -path=~/docs/books<CR>
	" nnoremap <silent><LocalLeader>m :<C-u>Denite mpc -buffer-name=mpc<CR>
	nnoremap <silent><LocalLeader>z :<C-u>Denite z<CR>
	nnoremap <silent><LocalLeader>/ :<C-u>Denite line -start-filter<CR>
	nnoremap <silent><LocalLeader>* :<C-u>DeniteCursorWord line<CR>
	nnoremap <silent><LocalLeader>; :<C-u>Denite command command_history<CR>

	" chemzqm/denite-git
	nnoremap <silent> <Leader>gl :<C-u>Denite gitlog:all -buffer-name=git<CR>
	nnoremap <silent> <Leader>gs :<C-u>Denite gitstatus -buffer-name=git<CR>
	nnoremap <silent> <Leader>gc :<C-u>Denite gitbranch -buffer-name=git<CR>

	" Open Denite with word under cursor or selection
	nnoremap <silent> <Leader>gt :DeniteCursorWord tag:include -buffer-name=tag -immediately<CR>
	nnoremap <silent> <Leader>gf :DeniteCursorWord file/rec<CR>
	nnoremap <silent> <Leader>gg :DeniteCursorWord grep -buffer-name=search<CR>
	vnoremap <silent> <Leader>gg
		\ :<C-u>call <SID>get_selection('/')<CR>
		\ :execute 'Denite -buffer-name=search grep:::'.@/<CR><CR>
	" Denite grep:::`expand('<cword>')`

	function! s:get_selection(cmdtype)
		let temp = @s
		normal! gv"sy
		let @/ = substitute(escape(@s, '\'.a:cmdtype), '\n', '\\n', 'g')
		let @s = temp
	endfunction "}}}
endif

if dein#tap('vim-denite-z')
	command! -nargs=+ -complete=file Z
		\ call denite#start([{'name': 'z', 'args': [<q-args>], {'immediately': 1}}])
endif

if dein#tap('defx.nvim')
	nnoremap <silent> <LocalLeader>e
		\ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>
	nnoremap <silent> <LocalLeader>E
		\ :<C-u>Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`<CR>
endif

if dein#tap('nerdtree')
	let g:NERDTreeMapOpenSplit = ',v'
	let g:NERDTreeMapOpenVSplit = ',g'
	let g:NERDTreeMapOpenInTab = ',t'
	let g:NERDTreeMapOpenInTabSilent = ',T'
	let g:NERDTreeMapUpdirKeepOpen = '<BS>'
	let g:NERDTreeMapOpenRecursively = 't'
	let g:NERDTreeMapCloseChildren = 'T'
	let g:NERDTreeMapToggleHidden = '.'

	" nnoremap <silent> <Leadee>e :<C-u>let NERDTreeWinPos=0 \| NERDTreeToggle<CR>
	" nnoremap <silent> <LocalLeader>a :<C-u>let NERDTreeWinPos=0 \| NERDTreeFind<CR>
	" nnoremap <silent> <LocalLeader>E :<C-u>let NERDTreeWinPos=1 \| NERDTreeToggle<CR>
	" nnoremap <silent> <LocalLeader>A :<C-u>let NERDTreeWinPos=1 \| NERDTreeFind<CR>
endif

if dein#tap('neosnippet.vim')
	imap <expr><C-o> neosnippet#expandable_or_jumpable()
		\ ? "\<Plug>(neosnippet_expand_or_jump)" : "\<ESC>o"
	xmap <silent><C-s> <Plug>(neosnippet_register_oneshot_snippet)
	smap <silent>L     <Plug>(neosnippet_jump_or_expand)
	xmap <silent>L     <Plug>(neosnippet_expand_target)
endif

if dein#tap('emmet-vim')
	autocmd MyAutoCmd FileType html,css,jsx,javascript,javascript.jsx
		\ EmmetInstall
		\ | imap <buffer> <C-Return> <Plug>(emmet-expand-abbr)
endif

if dein#tap('vim-operator-surround')
	map <silent>,a <Plug>(operator-surround-append)
	map <silent>,d <Plug>(operator-surround-delete)
	map <silent>,r <Plug>(operator-surround-replace)
	nmap <silent>,aa <Plug>(operator-surround-append)<Plug>(textobj-multiblock-i)
	nmap <silent>,dd <Plug>(operator-surround-delete)<Plug>(textobj-multiblock-a)
	nmap <silent>,rr <Plug>(operator-surround-replace)<Plug>(textobj-multiblock-a)
endif

if dein#tap('vim-niceblock')
	xmap I  <Plug>(niceblock-I)
	xmap A  <Plug>(niceblock-A)
endif

if dein#tap('accelerated-jk')
	nmap <silent>j <Plug>(accelerated_jk_gj)
	nmap <silent>k <Plug>(accelerated_jk_gk)
endif

if dein#tap('vim-edgemotion')
	map gj <Plug>(edgemotion-j)
	map gk <Plug>(edgemotion-k)
	xmap gj <Plug>(edgemotion-j)
	xmap gk <Plug>(edgemotion-k)
endif

if dein#tap('vim-bookmarks')
	" nnoremap ma :<C-u>cgetexpr bm#location_list()<CR>
	"	\ :<C-u>Denite quickfix -buffer-name=list<CR>
	nmap ma <Plug>BookmarkShowAll
	nmap mn <Plug>BookmarkNext
	nmap mp <Plug>BookmarkPrev
	nmap mt <Plug>BookmarkToggle
	nmap mi <Plug>BookmarkAnnotate
endif

if dein#tap('vim-quickhl')
	nmap <Leader>m  <Plug>(quickhl-manual-this)
	xmap <Leader>m  <Plug>(quickhl-manual-this)
	nmap <Leader>M  <Plug>(quickhl-manual-reset)
	xmap <Leader>M  <Plug>(quickhl-manual-reset)
	nmap yom        <Plug>(quickhl-manual-toggle)
endif

if dein#tap('vim-sidemenu')
	nnoremap <LocalLeader>l <Plug>(sidemenu)
	xnoremap <LocalLeader>l <Plug>(sidemenu-visual)
endif

if dein#tap('vim-indent-guides')
	nnoremap <silent>yog :<C-u>IndentGuidesToggle<CR>
endif

if dein#tap('auto-git-diff')
	autocmd MyAutoCmd FileType gitrebase
		\  nmap <buffer><CR>  <Plug>(auto_git_diff_scroll_manual_update)
		\| nmap <buffer><C-n> <Plug>(auto_git_diff_scroll_down_page)
		\| nmap <buffer><C-p> <Plug>(auto_git_diff_scroll_up_page)
		\| nmap <buffer><C-d> <Plug>(auto_git_diff_scroll_down_half)
		\| nmap <buffer><C-u> <Plug>(auto_git_diff_scroll_up_half)
endif

if dein#tap('committia.vim')
	let g:committia_hooks = {}
	function! g:committia_hooks.edit_open(info)
		imap <buffer><C-d> <Plug>(committia-scroll-diff-down-half)
		imap <buffer><C-u> <Plug>(committia-scroll-diff-up-half)

		setlocal winminheight=1 winheight=1
		resize 10
		startinsert
	endfunction
endif

if dein#tap('python_match.vim')
	nmap <buffer> {{ [%
	nmap <buffer> }} ]%
endif

if dein#tap('goyo.vim')
	nnoremap <LocalLeader>G :Goyo<CR>
endif

if dein#tap('vimwiki')
  "global mappings
  nmap <LocalLeader>ww <Plug>VimwikiIndex
  nmap <LocalLeader>wt <Plug>VimwikiTabIndex
  nmap <LocalLeader>ws <Plug>VimwikiUISelect
  nmap <LocalLeader>wi <Plug>VimwikiDiaryIndex
  nmap <LocalLeader>w<LocalLeader>w <Plug>VimwikiMakeDiaryNote
  nmap <LocalLeader>w<LocalLeader>t <Plug>VimwikiTabMakeDiaryNote
  nmap <LocalLeader>w<LocalLeader>y <Plug>VimwikiMakeYesterdayDiaryNote
  nmap <LocalLeader>w<LocalLeader>m <Plug>VimwikiMakeTomorrowDiaryNote
  "local mappings
  nmap <LocalLeader>wh <Plug>Vimwiki2HTML
  nmap <LocalLeader>whh <Plug>Vimwiki2HTMLBrowse
  nmap <LocalLeader>w<LocalLeader>i <Plug>VimwikiDiaryGenerateLinks
  nmap <LocalLeader>wd <Plug>VimwikiDeleteLink
  nmap <LocalLeader>wr <Plug>VimwikiRenameLink
endif

if dein#tap('vim-choosewin')
	nmap <silent> <Leader>- <Plug>(choosewin)
	nnoremap <silent> <Leader>_ :<C-u>ChooseWinSwapStay<CR>
endif

if dein#tap('vim-bbye')
	nnoremap <silent> <Leader>q :<C-u>Bdelete<CR>
	nnoremap <silent> <Leader>Q :<C-u>:bufdo :Bdelete<CR>
endif

if dein#tap('jedi-vim')
	let g:jedi#completions_command = ''
	let g:jedi#documentation_command = 'K'
	let g:jedi#goto_command = '<C-]>'
	let g:jedi#goto_assignments_command = '<leader>g'
	let g:jedi#rename_command = '<Leader>r'
	let g:jedi#usages_command = '<Leader>n'
endif

if dein#tap('vim-easygit')
	" nnoremap <silent> <leader>gd :Gdiff<CR>
	" nnoremap <silent> <leader>gD :GdiffThis<CR>
	" nnoremap <silent> <leader>gc :Gcommit<CR>
	" nnoremap <silent> <leader>gb :Gblame<CR>
	" nnoremap <silent> <leader>gs :Gstatus<CR>
	" nnoremap <silent> <leader>gp :Gpush<CR>
endif

if dein#tap('vim-altr')
	nmap <Leader>bf  <Plug>(altr-forward)
	nmap <Leader>bb  <Plug>(altr-back)
endif

if dein#tap('open-browser.vim')
	nmap gx <Plug>(openbrowser-smart-search)
	vmap gx <Plug>(openbrowser-smart-search)
endif

if dein#tap('tabular')
	" looks at the current line and the lines above and below it and aligns all the
	" equals signs; useful for when we have several lines of declarations
	nnoremap <Leader>z= :Tabularize /=<CR>
	vnoremap <Leader>z= :Tabularize /=<CR>
	nnoremap <Leader>z: :Tabularize /:\zs<CR>
	vnoremap <Leader>z: :Tabularize /:\zs<CR>
	nnoremap <Leader>z/ :Tabularize /\/\//l2c1l0<CR>
	vnoremap <Leader>z/ :Tabularize /\/\//l2c1l0<CR>
	nnoremap <Leader>z, :Tabularize /,/l0r1<CR>
	vnoremap <Leader>z, :Tabularize /,/l0r1<CR>

	" trigger the :Tabular command when you type '|' that you want to align.
	inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

	function! s:align()
		let p = '^\s*|\s.*\s|\s*$'
		if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
			let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
			let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
			Tabularize/|/l1
			normal! 0
			call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
		endif
	endfunction
endif

if dein#tap('undotree')
	nnoremap <Leader>u :UndotreeToggle<CR>
endif

if dein#tap('vim-online-thesaurus')
	nnoremap <silent> <LocalLeader>K :<C-u>OnlineThesaurusCurrentWord<CR>
endif

if dein#tap('vim-asterisk')
	map *   <Plug>(asterisk-*)zzzv
	map g*  <Plug>(asterisk-g*)zzzv
	map #   <Plug>(asterisk-#)zzzv
	map g#  <Plug>(asterisk-g#)zzzv

	map z*  <Plug>(asterisk-z*)
	map gz* <Plug>(asterisk-gz*)
	map z#  <Plug>(asterisk-z#)
	map gz# <Plug>(asterisk-gz#)
endif

if dein#tap('vim-expand-region')
	xmap v <Plug>(expand_region_expand)
	xmap V <Plug>(expand_region_shrink)
endif

if dein#tap('sideways.vim')
	nnoremap <silent> m" :SidewaysJumpLeft<CR>
	nnoremap <silent> m' :SidewaysJumpRight<CR>
	omap <silent> a, <Plug>SidewaysArgumentTextobjA
	xmap <silent> a, <Plug>SidewaysArgumentTextobjA
	omap <silent> i, <Plug>SidewaysArgumentTextobjI
	xmap <silent> i, <Plug>SidewaysArgumentTextobjI
endif

if dein#tap('splitjoin.vim')
	let g:splitjoin_join_mapping = ''
	let g:splitjoin_split_mapping = ''
	nmap <Leader>\\ :SplitjoinJoin<CR>
	nmap <Leader>\ :SplitjoinSplit<CR>
endif

if dein#tap('linediff.vim')
	vnoremap <Leader>df :Linediff<CR>
	vnoremap <Leader>da :LinediffAdd<CR>
	nnoremap <Leader>ds :<C-u>LinediffShow<CR>
	nnoremap <Leader>dr :<C-u>LinediffReset<CR>
endif

if dein#tap('caw.vim')
	function! InitCaw() abort
		if ! &l:modifiable
			silent! nunmap <buffer> gc
			silent! xunmap <buffer> gc
			silent! nunmap <buffer> gcc
			silent! xunmap <buffer> gcc
		else
			nmap <buffer> gc <Plug>(caw:prefix)
			xmap <buffer> gc <Plug>(caw:prefix)
			nmap <buffer> gcc <Plug>(caw:hatpos:toggle)
			xmap <buffer> gcc <Plug>(caw:hatpos:toggle)
		endif
	endfunction
	autocmd MyAutoCmd FileType * call InitCaw()
	call InitCaw()
endif

if dein#tap('vim-easymotion')
	map s <Plug>(easymotion-s2)
	" map sf <Plug>(easymotion-overwin-f2)
	" map sj <Plug>(easymotion-j)
	" map sk <Plug>(easymotion-k)
	map f <Plug>(easymotion-fl)
	map F <Plug>(easymotion-Fl)
	map t <Plug>(easymotion-tl)
	map T <Plug>(easymotion-Tl)
	map L <Plug>(easymotion-next)
	map H <Plug>(easymotion-prev)
endif

if dein#tap('vim-textobj-multiblock')
	omap <silent> ab <Plug>(textobj-multiblock-a)
	omap <silent> ib <Plug>(textobj-multiblock-i)
	xmap <silent> ab <Plug>(textobj-multiblock-a)
	xmap <silent> ib <Plug>(textobj-multiblock-i)
endif

if dein#tap('vim-textobj-function')
	omap <silent> af <Plug>(textobj-function-a)
	omap <silent> if <Plug>(textobj-function-i)
	xmap <silent> af <Plug>(textobj-function-a)
	xmap <silent> if <Plug>(textobj-function-i)
endif

if dein#tap('vim-markdown')
	autocmd FileType markdown let b:sleuth_automatic=0
	" autocmd FileType markdown set conceallevel=0
	autocmd FileType markdown normal zR
endif

if dein#tap('vim-grepper')
  " Define an Abbreviation to Expand :grep to :GrepperGrep
  function! s:SetupCommandAlias(input, output)
    exec 'cabbrev <expr> '.a:input
      \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:input.'")'
      \ .'? ("'.a:output.'") : ("'.a:input.'"))'
  endfunction

  call s:SetupCommandAlias("grep", "Grepper")
  nnoremap <Leader>ff :Grepper -buffer<CR>
  nnoremap <Leader>fb :Grepper -buffers<CR>
  nnoremap <Leader>fB :Grepper -buffers -cword -noprompt<CR>
  nnoremap <Leader>fd :Grepper<CR>
  nnoremap <leader>fD :Grepper -cword -noprompt<CR>

  " Operator mode
  noremap S <plug>(GrepperOperator)
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
" vim: set ts=2 sw=2 tw=80 noet :
