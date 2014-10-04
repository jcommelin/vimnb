" Source a global configuration file if available
if filereadable("/etc/vim/vimrc")
  source /etc/vim/vimrc
endif

source $HOME/.vimrc
source $HOME/data/vimnb/vimnb.vim


