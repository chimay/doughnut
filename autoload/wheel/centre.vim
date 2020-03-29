" vim: ft=vim fdm=indent:

" Command, Mappings

fun! wheel#centre#commands ()
	" Define commands
	" Status
	com! WheelDashboard :call wheel#status#dashboard()
	com! WheelPrint :call wheel#status#print()
endfun

fun! wheel#centre#mappings ()
	" Define mappings
	if g:wheel_config.mappings > 0
		" Tree : add
		exe 'nnoremap ' . g:wheel_config.prefix . 'a :call wheel#tree#add_here()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . '<c-a> :call wheel#tree#add_circle()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . 'A :call wheel#tree#add_torus()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . 'f :call wheel#tree#add_file()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . 'b :call wheel#tree#add_buffer()<cr>'
		" Vortex : move to elements
		exe 'nnoremap ' . g:wheel_config.prefix . '<left> :call wheel#vortex#prev_location()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . '<right> :call wheel#vortex#next_location()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . '<c-left> :call wheel#vortex#prev_circle()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . '<c-right> :call wheel#vortex#next_circle()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . '<s-left> :call wheel#vortex#prev_torus()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . '<s-right> :call wheel#vortex#next_torus()<cr>'
		" Disc : load / save wheel
		exe 'nnoremap ' . g:wheel_config.prefix . 'r :call wheel#disc#read_all()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . 'w :call wheel#disc#write_all()<cr>'
	endif
	if g:wheel_config.mappings > 1
		" Tree : rename, delete
		exe 'nnoremap ' . g:wheel_config.prefix . 'n :call wheel#tree#rename_location()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . '<c-n> :call wheel#tree#rename_circle()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . 'N :call wheel#tree#rename_torus()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . 'd :call wheel#tree#delete_location()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . '<c-d> :call wheel#tree#delete_circle()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . 'D :call wheel#tree#delete_torus()<cr>'
		" Vortex : move to elements
		exe 'nnoremap ' . g:wheel_config.prefix . '<cr> :call wheel#vortex#switch_location()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . '<c-cr> :call wheel#vortex#switch_circle()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . '<s-cr> :call wheel#vortex#switch_torus()<cr>'
		" Pendulum : history
		exe 'nnoremap ' . g:wheel_config.prefix . '<tab> :call wheel#pendulum#newer()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . '<backspace> :call wheel#pendulum#older()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . '^ :call wheel#pendulum#alternate()<cr>'
		" Mandala : menu in buffer
		exe 'nnoremap ' . g:wheel_config.prefix . '<space> :call wheel#mandala#locations()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . '<c-space> :call wheel#mandala#circles()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . '<s-space> :call wheel#mandala#toruses()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . 's :call wheel#mandala#helix()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . '<c-s> :call wheel#mandala#grid()<cr>'
		exe 'nnoremap ' . g:wheel_config.prefix . 'h :call wheel#mandala#history()<cr>'
	endif
	if g:wheel_config.mappings > 10
		" Tree
		nnoremap <D-Insert>   :call wheel#tree#add_here()<cr>
		nnoremap <D-Del>      :call wheel#tree#delete_location()<cr>
		" Vortex
		nnoremap <C-PageUp>   :call wheel#vortex#prev_location()<cr>
		nnoremap <C-PageDown> :call wheel#vortex#next_location()<cr>
		nnoremap <C-Home>     :call wheel#vortex#prev_circle()<cr>
		nnoremap <C-End>      :call wheel#vortex#next_circle()<cr>
		nnoremap <S-Home>     :call wheel#vortex#prev_torus()<cr>
		nnoremap <S-End>      :call wheel#vortex#next_torus()<cr>
		nnoremap <D-Space>    :call wheel#vortex#switch_location()<cr>
		nnoremap <D-=>        :call wheel#vortex#switch_circle()<cr>
		nnoremap <D-*>        :call wheel#vortex#switch_torus()<cr>
		" Pendulum
		nnoremap <S-PageUp>     :call wheel#pendulum#newer()<cr>
		nnoremap <S-PageDown>   :call wheel#pendulum#older()<cr>
		nnoremap <C-^>          :call wheel#pendulum#alternate()<cr>
		" Mandala
		nnoremap <Space>      :call wheel#mandala#locations()<cr>
		nnoremap <C-Space>    :call wheel#mandala#circles()<cr>
		nnoremap <S-Space>    :call wheel#mandala#toruses()<cr>
	endif
endfun
