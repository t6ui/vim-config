
" Neomake
" ---------
let g:neomake_open_list = 0
let g:neomake_verbose = 1

if ! empty(g:python3_host_prog)
	let g:neomake_python_python_exe = g:python3_host_prog
endif

" YAML / ANSIBLE
let g:neomake_yaml_enabled_makers = ['yamllint']
let g:neomake_ansible_enabled_makers = ['yamllint']
let g:neomake_ansible_yamllint_maker = neomake#makers#ft#yaml#yamllint()

" SHELL
let g:neomake_shellcheck_args = ['-fgcc']

" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
