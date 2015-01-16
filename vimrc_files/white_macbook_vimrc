

set nocompatible



execute pathogen#infect()
" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
call pathogen#helptags()
"call pathogen#runtime_append_all_bundles()

syntax on
filetype plugin indent on
 
set exrc            " enable per-directory .vimrc files
set secure          " disable unsafe commands in local .vimrc files

set wildignore=*.swp,*.bak,*.pyc,*.class
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo

"some defaults"
set tabstop=4     " a tab is four spaces
set shiftwidth=4  " number of spaces to use for autoindenting
set expandtab


autocmd! BufNewFile,BufRead *.ino setlocal ft=arduino

autocmd FileType asm set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType c set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType markdown set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType perl set tabstop=4|set shiftwidth=4|set expandtab

" add list lcs=tab:>-,trail:x for tab/trailing space visuals
autocmd BufEnter ?akefile* set noet ts=8 sw=8 nocindent
autocmd BufEnter *.mk set noet ts=8 sw=8 nocindent

" au BufRead,BufNewFile *.pde     setf java

autocmd FileType reprocessed set tabstop=2|set shiftwidth=2|set expandtab
let processing_output_dir="build-tmp" " so it builds in dir with same name 	
					"as the processing sublime plugin uses
					"

