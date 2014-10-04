" Source a global configuration file if available
if filereadable("/etc/vim/vimrc")
  source /etc/vim/vimrc
endif

source $HOME/.vimrc
source $HOME/data/vimnb/vimnb.vim
source $HOME/data/vimnb/CountJump/autoload/CountJump.vim
source $HOME/data/vimnb/CountJump/autoload/CountJump/Mappings.vim
source $HOME/data/vimnb/CountJump/autoload/CountJump/Motion.vim
source $HOME/data/vimnb/CountJump/autoload/CountJump/Region.vim
source $HOME/data/vimnb/CountJump/autoload/CountJump/TextObject.vim
source $HOME/data/vimnb/CountJump/autoload/CountJump/Region/TextObject.vim

call CountJump#Motion#MakeBracketMotion( '<buffer>', 'b', 'B', '#{{{', '#}}}', 0 )
call CountJump#Region#TextObject#Make( '<buffer>', 'c', 'i', 'V', '^#> [^-}]', 1 )
call CountJump#Region#TextObject#Make( '<buffer>', 'c', 'a', 'V', '^#> ', 1 )
" The above doesn't work. Replace it by a
" CountJump#TextObject#MakeWithJumpFunctions  with suitable jump to #> ---------
call CountJump#Region#TextObject#Make( '<buffer>', 'b', 'i', 'V', '^#> ', 0 )

function Jump_to_begin_codeblock(count, isInner)
	normal j[b
	return [line('.'), 0]
endfunction

function Jump_to_end_codeblock(count, isInner)
	normal k]B
	return [line('.'), '$']
endfunction

call CountJump#TextObject#MakeWithJumpFunctions('<buffer>', 'b', 'a', 'V', 'Jump_to_begin_codeblock', 'Jump_to_end_codeblock')

nmap <C-M>b [b]Bo<CR>#{{{<CR><CR>#}}}<ESC>0k
