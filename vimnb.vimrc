" Source a global configuration file if available
if filereadable("/etc/vim/vimrc")
  source /etc/vim/vimrc
endif
source $HOME/.vimrc

" Communication with the Python REPL
execute 'source ' . expand('<sfile>:p:h') . '/vimnb.vim'

" Plugin for textobject commands
execute 'source ' . expand('<sfile>:p:h') . '/CountJump/autoload/CountJump.vim'
execute 'source ' . expand('<sfile>:p:h') . '/CountJump/autoload/CountJump/Mappings.vim'
execute 'source ' . expand('<sfile>:p:h') . '/CountJump/autoload/CountJump/Motion.vim'
execute 'source ' . expand('<sfile>:p:h') . '/CountJump/autoload/CountJump/Region.vim'
execute 'source ' . expand('<sfile>:p:h') . '/CountJump/autoload/CountJump/TextObject.vim'
execute 'source ' . expand('<sfile>:p:h') . '/CountJump/autoload/CountJump/Region/TextObject.vim'

" Textobjects
call CountJump#Motion#MakeBracketMotion( '<buffer>', 'b', 'B', '#{{{', '#}}}', 0 )
call CountJump#Region#TextObject#Make( '<buffer>', 'o', 'i', 'V', '^#> [^}]', 1 )

function Jump_to_begin_codeblock(count, isInner)
	normal j[b
	return [line('.'), 0]
endfunction

function Jump_to_end_codeblock(count, isInner)
	if a:isInner == 1
		let match = search('#> -\{55\}\|#}}}', 'cs')
	else
		let match = search('#}}}', 'cs')
	endif
	return [match, '$']
endfunction

call CountJump#TextObject#MakeWithJumpFunctions('<buffer>', 'b', 'ai', 'V', 'Jump_to_begin_codeblock', 'Jump_to_end_codeblock')

" Keyboard shortcuts
nmap <C-N>b [b]Bo<CR>#{{{<CR><CR>#}}}<ESC>0k
nmap <C-N>r k]Bkdiovib<Space>
nmap <C-N>e <C-N>r]bj


" Colors
if exists('##VimEnter')
        autocmd VimEnter * call VimnbColors()
endif

function VimnbColors()
	syn match vimnbOutput "#> .*"
	hi vimnbOutput ctermfg=darkyellow
endfunction
