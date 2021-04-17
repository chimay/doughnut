" vim: ft=vim fdm=indent:

" Reshaping buffers

" Write commands

fun! wheel#shape#reorder_write (level)
	" Define reorder autocommands
	setlocal buftype=acwrite
	let autocommand = "autocmd BufWriteCmd <buffer> call wheel#cuboctahedron#reorder ('"
	let autocommand .= a:level . "')"
	augroup wheel
		autocmd!
		exe autocommand
	augroup END
endfun

fun! wheel#shape#reorganize_write ()
	" Define reorganize autocommands
	setlocal buftype=acwrite
	let autocommand = "autocmd BufWriteCmd <buffer> call wheel#cuboctahedron#reorganize ()"
	augroup wheel
		autocmd!
		exe autocommand
	augroup END
endfun

fun! wheel#shape#reorg_tabwins_write ()
	" Define reorg_tabwins autocommands
	setlocal buftype=acwrite
	let autocommand = "autocmd BufWriteCmd <buffer> call wheel#cuboctahedron#reorg_tabwins ()"
	augroup wheel
		autocmd!
		exe autocommand
	augroup END
endfun

fun! wheel#shape#grep_write ()
	" Define grep autocommands
	set buftype=acwrite
	let autocommand = "autocmd BufWriteCmd <buffer> call wheel#vector#write_quickfix ()"
	augroup wheel
		autocmd!
		exe autocommand
	augroup END
endfun

" Reorder

fun! wheel#shape#reorder (level)
	" Reorder level elements in a buffer
	let level = a:level
	let lines = wheel#perspective#switch (level)
	call wheel#vortex#update ()
	call wheel#mandala#open ('reorder/' . level)
	call wheel#mandala#common_maps ()
	call wheel#shape#reorder_write (level)
	if ! empty(lines)
		call wheel#mandala#fill(lines, 'delete')
		silent global /^$/ delete
		setlocal nomodified
	else
		echomsg 'Wheel mandala reorder : empty or incomplete' level
	endif
	" reload
	let b:wheel_reload = "wheel#shape#reorder('" . level . "')"
endfun

" Reorganize

fun! wheel#shape#reorganize ()
	" Reorganize the wheel tree
	let lines = wheel#perspective#reorganize ()
	call wheel#vortex#update ()
	call wheel#mandala#open ('reorganize')
	call wheel#mandala#common_maps ()
	call wheel#shape#reorganize_write ()
	call wheel#mandala#folding_options ()
	call wheel#mandala#fill(lines, 'delete')
	silent global /^$/ delete
	setlocal nomodified
	setlocal nocursorline
	" reload
	let b:wheel_reload = 'wheel#shape#reorganize'
endfun

" Reorganize tabs

fun! wheel#shape#reorg_tabwins ()
	" Reorganize tabs & windows
	let lines = wheel#perspective#tabwins_tree ()
	call wheel#vortex#update ()
	call wheel#mandala#open ('reorg/tabwins')
	call wheel#mandala#common_maps ()
	call wheel#shape#reorg_tabwins_write ()
	call wheel#mandala#folding_options ('tabwins_folding_text')
	call wheel#mandala#fill(lines, 'delete')
	silent global /^$/ delete
	setlocal nomodified
	setlocal nocursorline
	" reload
	let b:wheel_reload = 'wheel#shape#reorg_tabwins'
endfun

" Grep

fun! wheel#shape#grep (...)
	" Reorder level elements in a buffer
	if a:0 > 0
		let pattern = a:1
	else
		" called from context menu,
		" original pattern is at the top of the stack
		let settings = wheel#layer#top_field ('settings')
		let pattern = settings.pattern
	endif
	if a:0 > 1
		let sieve = a:2
	else
		let settings = wheel#layer#top_field ('settings')
		let sieve = settings.sieve
	endif
	let bool = wheel#vector#grep (pattern, sieve)
	if bool
		let lines = wheel#perspective#grep ()
		call wheel#vortex#update ()
		" new buffer
		call wheel#mandala#open ('grep/edit')
		call wheel#mandala#common_maps ()
		call wheel#shape#grep_write ()
		call wheel#mandala#fill (lines, 'delete')
		silent global /^$/ delete
		setlocal nomodified
		setlocal nocursorline
		" copy of original lines
		let b:wheel_lines = copy(lines)
		" reload
		let b:wheel_reload = "wheel#shape#grep('" . pattern . "','" . sieve . "')"
		" info
		echomsg 'adding or removing lines is not supported.'
	endif
	return bool
endfun
