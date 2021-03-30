" vim: set filetype=vim:

" Tests

" Completion {{{1

fun! Complete(Arglead,Cmdline,CursorPos)
	let list = ['toto', 'tutu', 'titi']
	return join(list, "\n")
endfun

fun! CompleteList(arglead,cmdline,cursorPos)
	let list = ['toto', 'tutu', 'titi']
	let regex = a:arglead . '.*'
	call filter(list, {ind, val -> val =~ regex })
	return list
endfun

fun! TestArgs (...)
	echo 'test args : ' join(a:000, '/')
endfun

command! -nargs=* -complete=custom,Complete TestArgs :call TestArgs(<args>)
command! -nargs=* -complete=custom,Complete TestQargs :call TestArgs(<q-args>)
command! -nargs=* -complete=custom,Complete TestFargs :call TestArgs(<f-args>)

command! -nargs=* -complete=customlist,CompleteList TestFargs :call TestArgs(<f-args>)

com! In      :echo input('Var ? ', '', 'custom,Complete')
com! Inlist  :echo input('Var ? ', '', 'customlist,CompleteList')

" }}}1

" Script variables {{{1

" Does not work
"source autoload/wheel/hub.vim
"echo 'alternate : ' s:alternate

" }}}1

" Dictionaries {{{1

let s:a = {'un':1, 'deux': 2}
let s:b = {'trois':1, 'quatre': 2}
call extend(s:a, s:b, 'error')
echo 'script a : ' s:a
echo 'script b : ' s:b

" }}}1

" Brace names {{{1

let s:a = 'win'
let s:b = 's:a'

echo 'Brace name {s:b} : ' {s:b}
echo 'Brace name winnr = {s:a}nr : ' {s:a}nr()

" }}}1

" Eval {{{1

let s:ptr='winnr()'
echo 'eval :' eval(s:ptr)

exe 'echo "coucou"'

" }}}1

" Identity {{{1

fun! s:Function (list, dict)
	let list = a:list
	let dict = a:dict
	echomsg 'is ? ' list is a:list dict is a:dict
endfun

call s:Function([1,2], {'i':1,'ii':2})

" }}}1

" Execute string {{{1

fun! s:Function (arg)
	let string = 'let var = ' . string(a:arg)
	echo 'string : ' string
	exe string
	echo 'Exe string -> var : ' var
endfun

call s:Function({'a':1,'b':2})
call s:Function('abc')

" }}}1

" Functions {{{1

" Optional arguments {{{2

fun! s:Function (...)
	return s:Called (a:000)
endfun

fun! s:Called (...)
	return a:000
endfun

echo 'Optional args : ' s:Function (1, 2)

" }}}2

" Func ref {{{2

fun! s:Plus(a, b)
	return a:a + a:b
endfu

fun! s:Minus(a, b)
	return a:a - a:b
endfu

echo 'plus 3 : ' function('s:Plus', [3])(4)
let s:Plus3 = function('s:Plus', [3])
echo 'plus3 : ' s:Plus3(4)

echo 'minus 3 : ' function('s:Minus', [3])(2)
let s:TreeMinus = function('s:Minus', [3])
echo 'minus3 : ' s:TreeMinus(2)

fun! s:Multi (fn)
	let r = a:fn(1, 2) + a:fn(3, 4)
	return r
endfun

" }}}2

" Lambda {{{2

echo 'lambda : ' {a -> 2 * a}(2)
let s:L = {a -> 2 * a}
echo 'lambda var : ' s:L(3)

fun! s:ArgumentConstant(fn, value)
	return {arg -> a:fn(arg, a:value) }
endfu

" }}}2

" Closure {{{2

fun! s:Fonctionnelle(fn, value)
	fun! Function(arg) closure
		return a:fn(a:arg, a:value)
	endfun
	return funcref('Function')
endfun

echo 'functional : ' s:Fonctionnelle(function('s:Minus'), 3)(7)
let s:F = s:Fonctionnelle(function('s:Minus'), 3)
echo 'functional : ' s:F(5)

" }}}2

" Dict func {{{2

" fun! Dico (arg) dict
" 	echo self.name a:arg
" endfun
"
" let d = {'name' : 'john'}
" let d.fn = function('Dico')
" call d.fn('Doe')
"
" let F = function('Dico', d)
" call F('Smith')
"
" let G = function('Dico', [], d)
" call G('Foo')
"
" fun! d.iam (arg) dict
" 	echo self.name a:arg
" endfun
"
" call d.iam('Bar')

" }}}2

" Recursivity {{{2

fun! s:Factorial (n)
	if a:n == 0
		return v:true
	else
		return a:n * s:Factorial(a:n -1)
endfun

echo 'Factorial 5 :' s:Factorial(5)

" }}}2

" Range {{{2

fun! s:Range () range
	echo 'range : ' a:firstline a:lastline
endfun

2,4call s:Range()

" }}}2

" }}}1

" Mappings {{{1

fun! s:Map ()
	echo 'coucou'
endfun

nnoremap <f12>t :call <sid>Map ()<cr>

" Does not work
"nnoremap <f12>t :call s:Map ()<cr>

" }}}1

" Vim vars {{{1

fun! s:Vars ()
	echo 'v:count' v:count
	let count = 'my count'
	echo 'count' count
	echo 'v:count' v:count
endfun

call s:Vars ()

" }}}1

" }}}1

" Autocommands {{{1

" Use noau w to really write the file
"au BufWriteCmd <buffer> echo 'autocommand replacing write'

" }}}1

" Popup {{{1

"call nvim_open_win(nvim_create_buf(v:false,v:true),v:true,{'width':70,'height':70,'relative':'win','bufpos':[2,3]})

" }}}1

" Wheel {{{1

" {'file': '/home/david/racine/public/wheel/test/test.vim', 'col': 8, 'name': 'test', 'line': 54}

" }}}1
