" vim: ft=vim fdm=indent:

" Helpers

fun! wheel#gear#circular_plus (index, length)
	return (a:index + 1) % a:length
endfun

fun! wheel#gear#circular_minus (index, length)
	let index = (a:index - 1) % a:length
	if index < 0
		let index += a:length
	endif
	return index
endfun

fun! wheel#gear#project_root (markers)
	" Change local directory to root of project
	" where current buffer belongs
	if type(a:markers) == v:t_string
		let markers = [a:markers]
	elseif type(a:markers) == v:t_list
		let markers = a:markers
	else
		echomsg 'Wheel Project root : argument must be either a string or a list.'
	endif
	let dir = expand('%:p:h')
	exe 'lcd ' . dir
	let found = 0
	while 1
		for mark in markers
			if filereadable(mark) || isdirectory(mark)
				let found = 1
				break
			endif
		endfor
		if found || dir == '/'
			break
		endif
		lcd ..
		let dir = getcwd()
	endwhile
endfun

fun! wheel#gear#filter (wordlist, index, value)
	" Whether value matches all words of wordlist
	" index is not used, it’s just for compatibility with filter()
	let length = strchars(a:value)
	let prelast = strcharpart(a:value, length - 2, 1)
	" Keep surrounding folds
	if prelast == '>'
		return 1
	endif
	" Words
	let match = 1
	for word in a:wordlist
		let pattern = '.*' . word . '.*'
		if a:value !~ pattern
			let match = 0
			break
		endif
	endfor
	return match
endfun
