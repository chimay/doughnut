" vim: ft=vim fdm=indent:

" Internal Variables made crystal clear

" Wheel levels

if ! exists('s:referen_levels')
	if exists(':const')
		const s:referen_levels = ['wheel', 'torus', 'circle', 'location']
	else
		let s:referen_levels = ['wheel', 'torus', 'circle', 'location']
		lockvar s:referen_levels
	endif
endif

if ! exists('s:referen_coordin')
	let s:referen_coordin = ['torus', 'circle', 'location']
	lockvar s:referen_coordin
endif

if ! exists('s:referen_list_keys')
	let s:referen_list_keys =
				\{
				\ 'wheel' : 'toruses',
				\ 'torus' : 'circles',
				\ 'circle' : 'locations',
				\ }
	lockvar s:referen_list_keys
endif

" Golden ratio

if ! exists('s:golden_ratio')
	let s:golden_ratio = (1 + sqrt(5)) / 2
	lockvar s:golden_ratio
endif

" Strings

if ! exists('s:separator_field')
	let s:separator_field = ' | '
	lockvar s:separator_field
endif

if ! exists('s:separator_level')
	let s:separator_level = ' > '
	lockvar s:separator_level
endif

if ! exists('s:selected_mark')
	let s:selected_mark = '* '
	lockvar s:selected_mark
endif

if ! exists('s:selected_pattern')
	let s:selected_pattern = '\m^\* '
	lockvar s:selected_pattern
endif

" Folds

if ! exists('s:fold_markers')
	let s:fold_markers = ['>', '<']
	lockvar s:fold_markers
endif

if ! exists('s:fold_one')
	let s:fold_one = ' ' . s:fold_markers[0] . '1'
	lockvar s:fold_one
endif

if ! exists('s:fold_two')
	let s:fold_two = ' ' . s:fold_markers[0] . '2'
	lockvar s:fold_two
endif

" Menus

if ! exists('s:menu_add')
	let s:menu_add = {
				\ 'add a new torus' : 'wheel#tree#add_torus',
				\ 'add a new circle' : 'wheel#tree#add_circle',
				\ 'add here as new location' : 'wheel#tree#add_here',
				\ 'add a new file' : 'wheel#tree#add_file',
				\ 'add a new buffer' : 'wheel#tree#add_buffer',
				\}
	lockvar s:menu_add
endif

if ! exists('s:menu_rename')
	let s:menu_rename = {
				\ 'rename torus' : "wheel#tree#rename('torus')",
				\ 'rename circle' : "wheel#tree#rename('circle')",
				\ 'rename location' : "wheel#tree#rename('location')",
				\ 'rename file' : 'wheel#tree#rename_file',
				\}
	lockvar s:menu_rename
endif

if ! exists('s:menu_delete')
	let s:menu_delete = {
				\ 'delete torus' : "wheel#tree#delete('torus')",
				\ 'delete circle' : "wheel#tree#delete('circle')",
				\ 'delete location' : "wheel#tree#delete('location')",
				\}
	lockvar s:menu_delete
endif

if ! exists('s:menu_disc')
	let s:menu_disc = {
				\ 'save wheel' : 'wheel#disc#write_all()',
				\ 'load wheel' : 'wheel#disc#read_all()',
				\}
	lockvar s:menu_disc
endif

if ! exists('s:menu_navigation')
	let s:menu_navigation = {
				\ 'go to torus' : "wheel#sailing#switch('torus')",
				\ 'go to circle' : "wheel#sailing#switch('circle')",
				\ 'go to location' : "wheel#sailing#switch('location')",
				\ 'go to location in index' : 'wheel#sailing#helix',
				\ 'go to circle in index' : 'wheel#sailing#grid',
				\ 'go to element in wheel tree' : 'wheel#sailing#tree',
				\ 'go to location in history' : 'wheel#sailing#history',
				\ 'go to opened file (buffer)' : 'wheel#sailing#opened_files',
				\ 'go to matching line (occur)' : 'wheel#sailing#occur',
				\ 'go to grep result' : 'wheel#sailing#grep()',
				\ 'go to outline result' : 'wheel#sailing#outline()',
				\ 'go to tag' : 'wheel#sailing#symbol()',
				\ 'go to most recently used file (mru)' : 'wheel#sailing#attic',
				\ 'go to result of locate search' : 'wheel#sailing#locate',
				\ 'go to result of find search' : 'wheel#sailing#find',
				\}
	lockvar s:menu_navigation
endif

if ! exists('s:menu_alternate')
	let s:menu_alternate = {
				\ 'alternate anywhere' : 'wheel#pendulum#alternate_anywhere',
				\ 'alternate in same torus' : 'wheel#pendulum#alternate_same_torus',
				\ 'alternate in same circle' : 'wheel#pendulum#alternate_same_circle',
				\ 'alternate in other torus' : 'wheel#pendulum#alternate_other_torus',
				\ 'alternate in other circle' : 'wheel#pendulum#alternate_other_circle',
				\ 'alternate in same torus, other circle' : 'wheel#pendulum#alternate_same_torus_other_circle',
				\}
	lockvar s:menu_alternate
endif

if ! exists('s:menu_reorganize')
	let s:menu_reorganize = {
				\ 'reorder toruses' : "wheel#shape#reorder('torus')",
				\ 'reorder circles' : "wheel#shape#reorder('circle')",
				\ 'reorder locations' : "wheel#shape#reorder('location')",
				\ 'reorganize wheel' : 'wheel#shape#reorganize',
				\}
	lockvar s:menu_reorganize
endif

if ! exists('s:menu_yank')
	let s:menu_yank = {
				\ 'yank wheel in list mode' : "wheel#clipper#yank('list')",
				\ 'yank wheel in plain mode' : "wheel#clipper#yank('plain')",
				\}
	lockvar s:menu_yank
endif

if ! exists('s:menu_tabs')
	let s:menu_tabs = {
				\ 'toruses on tabs' : "wheel#mosaic#tabs('torus')",
				\ 'circles on tabs' : "wheel#mosaic#tabs('circle')",
				\ 'locations on tabs' : "wheel#mosaic#tabs('location')",
				\}
	lockvar s:menu_tabs
endif

if ! exists('s:menu_windows')
	let s:menu_windows = {
				\ 'toruses on horizontal splits' : "wheel#mosaic#split('torus')",
				\ 'circles on horizontal splits' : "wheel#mosaic#split('circle')",
				\ 'locations on horizontal splits' : "wheel#mosaic#split('location')",
				\ 'toruses on vertical splits' : "wheel#mosaic#split('torus', 'vertical')",
				\ 'circles on vertical splits' : "wheel#mosaic#split('circle', 'vertical')",
				\ 'locations on vertical splits' : "wheel#mosaic#split('location', 'vertical')",
				\ 'toruses on splits, main left layout' : "wheel#mosaic#split('torus', 'main_left')",
				\ 'circles on splits, main left layout' : "wheel#mosaic#split('circle', 'main_left')",
				\ 'locations on splits, main left layout' : "wheel#mosaic#split('location', 'main_left')",
				\ 'toruses on splits, main top layout' : "wheel#mosaic#split('torus', 'main_top')",
				\ 'circles on splits, main top layout' : "wheel#mosaic#split('circle', 'main_top')",
				\ 'locations on splits, main top layout' : "wheel#mosaic#split('location', 'main_top')",
				\ 'toruses on splits, golden horizontal' : "wheel#mosaic#golden('torus', 'horizontal')",
				\ 'circles on splits, golden horizontal' : "wheel#mosaic#golden('circle', 'horizontal')",
				\ 'locations on splits, golden horizontal' : "wheel#mosaic#golden('location', 'horizontal')",
				\ 'toruses on splits, golden vertical' : "wheel#mosaic#golden('torus', 'vertical')",
				\ 'circles on splits, golden vertical' : "wheel#mosaic#golden('circle', 'vertical')",
				\ 'locations on splits, golden vertical' : "wheel#mosaic#golden('location', 'vertical')",
				\ 'toruses on splits, golden left layout' : "wheel#mosaic#golden('torus', 'main_left')",
				\ 'circles on splits, golden left layout' : "wheel#mosaic#golden('circle', 'main_left')",
				\ 'locations on splits, golden left layout' : "wheel#mosaic#golden('location', 'main_left')",
				\ 'toruses on splits, golden top layout' : "wheel#mosaic#golden('torus', 'main_top')",
				\ 'circles on splits, golden top layout' : "wheel#mosaic#golden('circle', 'main_top')",
				\ 'locations on splits, golden top layout' : "wheel#mosaic#golden('location', 'main_top')",
				\ 'toruses on splits, grid layout' : "wheel#mosaic#split_grid('torus')",
				\ 'circles on splits, grid layout' : "wheel#mosaic#split_grid('circle')",
				\ 'locations on splits, grid layout' : "wheel#mosaic#split_grid('location')",
				\ 'toruses on splits, transposed grid layout' : "wheel#mosaic#split_transposed_grid('torus')",
				\ 'circles on splits, transposed grid layout' : "wheel#mosaic#split_transposed_grid('circle')",
				\ 'locations on splits, transposed grid layout' : "wheel#mosaic#split_transposed_grid('location')",
				\ 'rotate windows clockwise' : 'wheel#mosaic#rotate_clockwise()',
				\ 'rotate windows counter-clockwise' : 'wheel#mosaic#rotate_counter_clockwise()',
				\}
	lockvar s:menu_windows
endif

if ! exists('s:menu_tabnwin')
	let s:menu_tabnwin = {
				\ 'mix : toruses on tabs & circles on splits' : "wheel#pyramid#steps('torus')",
				\ 'mix : circles on tabs & locations on splits' : "wheel#pyramid#steps('circle')",
				\ 'zoom : one tab, one window' : 'wheel#mosaic#zoom()',
				\}
	lockvar s:menu_tabnwin
endif

" List of menu variables

if ! exists('s:menu_list')
	let s:menu_list = [
				\ 'add',
				\ 'rename',
				\ 'delete',
				\ 'disc',
				\ 'navigation',
				\ 'alternate',
				\ 'reorganize',
				\ 'yank',
				\ 'tabs',
				\ 'windows',
				\ 'tabnwin',
				\]
	lockvar s:menu_list
endif

" Main menu

if ! exists('s:menu_main')
	let s:menu_main = {}
	for name in s:menu_list
		call extend(s:menu_main, s:menu_{name})
	endfor
	lockvar s:menu_main
endif

" Meta menu

if ! exists('s:menu_meta')
	let s:menu_meta = {
				\ 'add' : "wheel#hub#submenu('add')",
				\ 'rename' : "wheel#hub#submenu('rename')",
				\ 'delete' : "wheel#hub#submenu('delete')",
				\ 'disc' : "wheel#hub#submenu('disc')",
				\ 'navigation' : "wheel#hub#submenu('navigation')",
				\ 'alternate' : "wheel#hub#submenu('alternate')",
				\ 'tabs' : "wheel#hub#submenu('tabs')",
				\ 'window layouts' : "wheel#hub#submenu('windows')",
				\ 'mix of tabs & windows' : "wheel#hub#submenu('tabnwin')",
				\ 'reorganize' : "wheel#hub#submenu('reorganize')",
				\ 'yank' : "wheel#hub#submenu('yank')",
				\}
	lockvar s:menu_meta
endif

" Contextual menus

if ! exists('s:context_sailing')
	let s:context_sailing = {
				\ 'open' : "wheel#boomerang#sailing('current')",
				\ 'open in tab(s)' : "wheel#boomerang#sailing('tab')",
				\ 'open in horizontal split(s)' : "wheel#boomerang#sailing('horizontal_split')",
				\ 'open in vertical split(s)' : "wheel#boomerang#sailing('vertical_split')",
				\ 'open in horizontal golden split(s)' : "wheel#boomerang#sailing('horizontal_golden')",
				\ 'open in vertical golden split(s)' : "wheel#boomerang#sailing('vertical_golden')",
				\}
	lockvar s:context_sailing
endif

if ! exists('s:context_openedFiles')
	let s:context_openedFiles = {
				\ 'delete' : "wheel#boomerang#opened_files('delete')",
				\ 'wipe' : "wheel#boomerang#opened_files('wipe')",
				\}
	call extend(s:context_openedFiles, s:context_sailing)
	lockvar s:context_openedFiles
endif

if ! exists('s:context_grep')
	let s:context_grep = {
				\ 'open quickfix' : "wheel#boomerang#grep('quickfix')",
				\}
	call extend(s:context_grep, s:context_sailing)
	lockvar s:context_grep
endif

if ! exists('s:context_yank')
	let s:context_yank = {
				\ 'paste before' : "wheel#boomerang#yank('before')",
				\ 'paste after' : "wheel#boomerang#yank('after')",
				\}
	lockvar s:context_yank
endif

" Public Interface

fun! wheel#crystal#fetch (varname)
	" Return script variable called varname
	" The leading s: can be omitted
	let varname = a:varname
	let varname = substitute(varname, '/', '_', 'g')
	let varname = substitute(varname, '-', '_', 'g')
	if varname =~ '\m^s:'
		return {varname}
	else
		return s:{varname}
	endif
endfun
