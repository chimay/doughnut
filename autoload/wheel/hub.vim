" vim: ft=vim fdm=indent:

" Script vars

if ! exists('s:fold_markers')
	let s:fold_markers = wheel#crystal#fetch('fold/markers')
	let s:fold_markers = join(s:fold_markers, ',')
	lockvar s:fold_markers
endif

if ! exists('s:level_1')
	let s:level_1 = wheel#crystal#fetch('fold/one')
	lockvar s:level_1
endif

if ! exists('s:menu_list')
	let s:menu_list = wheel#crystal#fetch('menu/list')
	lockvar s:menu_list
endif

" Maps

fun! wheel#hub#menu_maps (dictname)
	" Define local maps for menus
	let dictname = 'menu/' . a:dictname
	let settings = {'linefun' : dictname, 'close' : 1, 'travel' : 1}
	call wheel#layer#overlay (settings)
	let b:wheel_settings = settings
endfun

fun! wheel#hub#meta_maps (dictname)
	" Define local maps for meta menu
	let dictname = 'menu/' . a:dictname
	let settings = {'linefun' : dictname, 'close' : 0, 'travel' : 0}
	call wheel#layer#overlay (settings)
	let b:wheel_settings = settings
	return
endfun

" Folding

fun! wheel#hub#folding_options ()
	" Folding options for menu
	setlocal foldenable
	setlocal foldminlines=1
	setlocal foldlevel=0
	setlocal foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
	setlocal foldclose=
	setlocal foldmethod=marker
	let &foldmarker = s:fold_markers
	setlocal foldcolumn=2
	setlocal foldtext=wheel#hub#folding_text()
endfun

fun! wheel#hub#folding_text ()
	" Folding text for menu
	let numlines = v:foldend - v:foldstart
	let line = getline(v:foldstart)
	if v:foldlevel == 1
		let level = 'submenu'
	else
		let level = 'none'
	endif
	let marker = split(&foldmarker, ',')[0]
	let pattern = '\m' . marker . '[12]'
	let repl = ':: ' . level
	let line = substitute(line, pattern, repl, '')
	let text = line . ' :: ' . numlines . ' lines ' . v:folddashes
	return text
endfun

" Menus

fun! wheel#hub#menu (dictname)
	" Menu in wheel buffer
	let dictname = a:dictname
	let string = 'wheel-menu-' . dictname
	call wheel#mandala#open (string)
	call wheel#mandala#template ()
endfun

fun! wheel#hub#submenu (dictname)
	" Submenu
	let dictname = 'menu/' . a:dictname
	let settings = {'linefun' : dictname, 'close' : 1, 'travel' : 1}
	call wheel#layer#staircase (settings)
endfun

fun! wheel#hub#main ()
	" Main hub menu in wheel buffer
	call wheel#hub#menu('main')
	call wheel#hub#menu_maps ('main')
	nunmap <buffer> <space>
	call wheel#hub#folding_options ()
	let dict = wheel#crystal#fetch('menu/main')
	let menu = sort(keys(dict))
	let menu = []
	for elem in s:menu_list
		let header = elem . s:level_1
		let submenu = wheel#crystal#fetch('menu/' . elem)
		let submenu = sort(keys(submenu))
		call add(menu, header)
		call extend(menu, submenu)
	endfor
	call wheel#mandala#fill(menu)
endfun

fun! wheel#hub#meta ()
	" Meta hub menu in wheel buffer
	call wheel#hub#menu('meta')
	call wheel#hub#meta_maps('meta')
	let dict = wheel#crystal#fetch('menu/meta')
	let menu = sort(keys(dict))
	call wheel#mandala#fill(menu)
endfun
