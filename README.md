vimnb
=====

Vim notebook, mimicking IPython notebooks

Install
-------

Make sure the files `pywrap.py` and `vimnb` are executable.
Make sure `vimnb` is in your path.
Edit `vimnb` so that the variable `FILEDIR` points to the location of
all other files.

Usage
-----

Call `vimnb` on your favourite python script, and execute parts of the code by
selecting them, and hitting `<Space>`. Watch the magic happen.

Codeblocks
----------

VimNB has a notion of codeblocks. It are pieces of Python code delimited by
`#{{{` and `#}}}`. To create a codeblock, hit `<Ctrl-N>b`.

Keyboard shortcuts
------------------

 * `<Ctrl-N>b` to create a codeblock.
 * `<Ctrl-N>r` to run a codeblock.
 * `<Ctrl-N>e` to run a codeblock, and jump to the next.
 * `<Ctrl-N>s` to split a codeblock.
 * Use `[b` (resp. `]b`) to jump to the start of the previous
(resp. next) codeblock.
 * Use `[B` (resp. `]B`) to jump to the start of the end
(resp. next) codeblock.
 * There are vim textobjects:
   * `ab` operates on an entire codeblock
   * `ib` operates on the code in a codeblock
   * `io` operates on the output of a codeblock
   For example: `dio` deletes the output (make sure the cursor is 
	on the output)
   In the same spirit, `cib` changes the code of the codeblock,
   `vab` selects the entire codeblock, and `zfio` folds the output.
