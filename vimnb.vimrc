" Source a global configuration file if available
if filereadable("/etc/vim/vimrc")
  source /etc/vim/vimrc
endif
source $HOME/.vimrc

" Configure communication with the Python REPL
""""""""""""""""""""""""""""""""""""""""""""""
execute 'source ' . expand('<sfile>:p:h') . '/vimnb.vim'

" Plugin for textobject commands
""""""""""""""""""""""""""""""""
execute 'source ' . expand('<sfile>:p:h') . '/CountJump/autoload/CountJump.vim'
execute 'source ' . expand('<sfile>:p:h') . '/CountJump/autoload/CountJump/Mappings.vim'
execute 'source ' . expand('<sfile>:p:h') . '/CountJump/autoload/CountJump/Motion.vim'
execute 'source ' . expand('<sfile>:p:h') . '/CountJump/autoload/CountJump/Region.vim'
execute 'source ' . expand('<sfile>:p:h') . '/CountJump/autoload/CountJump/TextObject.vim'
execute 'source ' . expand('<sfile>:p:h') . '/CountJump/autoload/CountJump/Region/TextObject.vim'


" Textobjects
"""""""""""""

" Setup motion commands: [b ]b [B ]B
call CountJump#Motion#MakeBracketMotion( '<buffer>', 'b', 'B', '#{{{', '#}}}', 0 )

" Setup textobject for output from the REPL: io
call CountJump#Region#TextObject#Make( '<buffer>', 'o', 'i', 'V', '^#> [^}]', 1 )

" Return the first line of the current codeblock
function Jump_to_begin_codeblock(count, isInner)
	normal j[b
	return [line('.'), 0]
endfunction

" Return the last line of the current codeblock
function Jump_to_end_codeblock(count, isInner)
	if a:isInner == 1
		let match = search('#> -\{55\}\|#}}}', 'cs')
	else
		let match = search('#}}}', 'cs')
	endif
	return [match, '$']
endfunction

" Setup textobject for codeblocks: ib ab
call CountJump#TextObject#MakeWithJumpFunctions('<buffer>', 'b', 'ai', 'V', 'Jump_to_begin_codeblock', 'Jump_to_end_codeblock')


" Keyboard shortcuts
""""""""""""""""""""

" New codeblock
nmap <C-N>b [b]Bo<CR>#{{{<CR><CR>#}}}<ESC>0k
" Run codeblock in place
nmap <C-N>r k]Bkdiovib<Space>
" Run codeblock, and move to the next one
nmap <C-N>e <C-N>r]bj
" Split codeblock above the cursor
nmap <C-N>s O#}}}<CR><CR>#{{{<Esc>j


" Colors
""""""""

if exists('##VimEnter')
        autocmd VimEnter * call VimnbColors()
endif

function VimnbColors()
	syn match vimnbOutput "#> .*"
	syn match vimnbError "#> !.*"
	hi vimnbOutput ctermfg=darkyellow
	hi vimnbError ctermfg=darkred
endfunction
