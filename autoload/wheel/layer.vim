" vim: ft=vim fdm=indent:

" Layers stack on wheel buffers

" Stack

fun! wheel#layer#push ()
	" Push buffer content to the stack
	" Save modified local maps
	if ! exists('b:wheel_stack')
		let b:wheel_stack = {}
		let b:wheel_stack.full = []
		let b:wheel_stack.current = []
		let b:wheel_stack.positions = []
		let b:wheel_stack.selected = []
		let b:wheel_stack.settings = []
		let b:wheel_stack.mappings = []
	endif
	let stack = b:wheel_stack
	" Full content, without filtering
	let full = stack.full
	if ! exists('b:wheel_lines') || empty(b:wheel_lines)
		let lines = getline(2, '$')
	else
		let lines = b:wheel_lines
	endif
	call insert(full, lines)
	" Current content
	let current = stack.current
	let now = getline(1, '$')
	call insert(current, now)
	" Position
	let positions = stack.positions
	call insert(positions, getcurpos())
	" Selected lines
	let selected = stack.selected
	if ! exists('b:wheel_selected')
		let b:wheel_selected = []
	endif
	call insert(selected, b:wheel_selected)
	" Buffer settings
	let settings = stack.settings
	if exists('b:wheel_settings')
		call insert(settings, b:wheel_settings)
	else
		call insert(settings, {})
	endif
	" Map stack
	let mappings = stack.mappings
	let enter = maparg('<enter>', 'n')
	let g_enter = maparg('g<enter>', 'n')
	let space = maparg('<space>', 'n')
	let tab = maparg('<tab>', 'n')
	let mapdict = {
				\ 'enter': enter,
				\ 'g_enter': g_enter,
				\ 'space' : space,
				\ 'tab' : tab,
				\}
	call insert(mappings, mapdict)
	" Reset buffer variables
	" Fresh filter and so on
	call wheel#void#lighten('buffer')
endfun

fun! wheel#layer#pop ()
	" Pop buffer content from the stack
	" Restore modified local maps
	if ! exists('b:wheel_stack')
		return
	endif
	let stack = b:wheel_stack
	" Full content, without filtering
	let full = stack.full
	if empty(full) || empty(full[0])
		return
	endif
	let b:wheel_lines = wheel#chain#pop (full)
	" Current content
	let current = stack.current
	let now = wheel#chain#pop (current)
	call wheel#mandala#replace (now, 'delete')
	" Restore cursor position
	let positions = stack.positions
	let pos = wheel#chain#pop (positions)
	call wheel#gear#restore_cursor (pos)
	" Restore settings
	let settings = stack.settings
	let b:wheel_settings = wheel#chain#pop (settings)
	" Restore mappings
	let mappings = stack.mappings
	if ! empty(mappings)
		let mapdict = wheel#chain#pop (mappings)
		if ! empty(mapdict.enter)
			exe 'nnoremap <buffer> <cr> ' . mapdict.enter
		endif
		if ! empty(mapdict.g_enter)
			exe 'nnoremap <buffer> g<cr> ' . mapdict.g_enter
		endif
		if ! empty(mapdict.space)
			exe 'nnoremap <buffer> <space> ' . mapdict.space
		endif
		if ! empty(mapdict.tab)
			exe 'nnoremap <buffer> <tab> ' . mapdict.tab
		endif
	endif
	" Restore selection
	let selected = stack.selected
	let b:wheel_selected = wheel#chain#pop(selected)
endfun
