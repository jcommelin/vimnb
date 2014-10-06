" Inspired by the pipe2eval plugin.

" Default key for running a selection through the REPL
let s:map_key_default = "<Space>"
" Users can define another key
let s:map_key = exists('g:vimnb_map_key') ? g:vimnb_map_key : s:map_key_default

" Location of the REPL call script
let g:vimnb_call = expand('<sfile>:p:h') . '/vimnb_call.sh'

" Setup the mapping to run a selection through the REPL (pass the filename as argument)
execute "vm <buffer> ". s:map_key ." :!". g:vimnb_call . " " . expand('%:p') . "<CR><CR>"
