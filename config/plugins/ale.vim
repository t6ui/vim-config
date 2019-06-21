" 如果没有 gcc 只有 clang 时（FreeBSD）
if executable('gcc') == 0 && executable('clang')
	let g:ale_linters.c += ['clang']
	let g:ale_linters.cpp += ['clang']
endif

" Mappings in the style of unimpaired-next
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)

let g:ale_linters.text = ['textlint', 'write-good', 'languagetool']

" gcc主要检查有无语法错误，cppcheck主要给出一些编码建议，和对危险写法的警告。
let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

" 计算当前 vim-init 的子路径，lintcfg函数调用
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
function! s:path(path)
	let path = expand(s:home . '/' . a:path )
	return substitute(path, '\\', '/', 'g')
endfunc

" 获取 pylint, flake8 的配置文件，在 vim-init/tools/conf 下面
function s:lintcfg(name)
	let conf = s:path('tools/conf/')
	let path1 = conf . a:name
	let path2 = expand('~/.vim/linter/'. a:name)
	if filereadable(path2)
		return path2
	endif
	return shellescape(filereadable(path2)? path2 : path1)
endfunc

" 设置 flake8/pylint 的参数
let g:ale_python_flake8_options = '--conf='.s:lintcfg('flake8.conf')
let g:ale_python_pylint_options = '--rcfile='.s:lintcfg('pylint.conf')
let g:ale_python_pylint_options .= ' --disable=W'

" 在 linux/mac 下降低语法检查程序的进程优先级（不要卡到前台进程）
" if s:windows == 0 && has('win32unix') == 0
	let g:ale_command_wrapper = 'nice -n5'
" endif

" 允许 airline 集成
let g:airline#extensions#ale#enabled = 1

" 设定延迟和提示信息
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
" let g:ale_sign_column_always = 1

" 设定检测的时机：normal 模式文字改变，或者离开 insert模式
" 禁用默认 INSERT 模式下改变文字也触发的设置，太频繁外，还会让补全窗闪烁
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 1 " default
let g:ale_lint_on_enter = 1 " default
let g:ale_lint_on_filetype_changed = 1 " default
