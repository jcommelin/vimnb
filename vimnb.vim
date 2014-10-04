" Inspired by the pipe2eval plugin.
let s:map_key_default = "<Space>"
let g:vimnb_call = expand('<sfile>:p:h') . '/vimnb_call.sh'

let l:map_key = exists('g:vimnb_map_key') ? g:vimnb_map_key : s:map_key_default
execute "vm <buffer> ". l:map_key ." :!". g:vimnb_call . " " . expand('%:p') . "<CR><CR>"
