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

nmap <C-M>b [b]Bo<CR>#{{{<CR><CR>#}}}<ESC>0k
