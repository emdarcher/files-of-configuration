" echo ">^.^<"

set nocompatible

set number numberwidth=2

set hlsearch incsearch

" stuff for pathogen
execute pathogen#infect()


"from other vimrc
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
"
"change default max amount of tabs open
set tabpagemax=24


"make sure backspace behaves like I want it to
set backspace=indent,eol,start

"set so statusline always shows
set laststatus=2

" set default statusline format
set statusline=%f%=%c/%l

syntax on

" solarized settings {{{
" enable proper transparency in some terminals
let g:solarized_termtrans=1
" }}}

" Mapping related settings {{{

" set the leader characters
let mapleader = ","
let maplocalleader = "\\" 

nnoremap <Leader>- ddp
" take note of 'kP' instead of just P
nnoremap <Leader>_ ddkP
" map C-U in insert mode to select word and cover to all caps 
" and return to insert
" imap <c-u> <esc>vwUi
inoremap <Leader><c-u> <esc>vwUi
" same as above, but for use inside normal mode
" nmap <c-u> vwU
nnoremap <Leader><c-u> vwU

" shortcut to edit my global vimrc in a window
nnoremap <Leader>ev :split $MYVIMRC<cr>
" shortcut to relaod the global vimrc as the source
nnoremap <Leader>sv :source $MYVIMRC<cr>
" shortcut to edit my global vimrc in a new tab
nnoremap <Leader>etv :tabe $MYVIMRC<cr>



" shortcut to edit my local vimrc in a window
nnoremap <Leader>elv :split ./.vimrc<cr>
" shortcut to relaod the local vimrc as the source
nnoremap <Leader>slv :source ./.vimrc<cr>
" shortcut to edit my local vimrc in a new tab
nnoremap <Leader>etlv :tabe ./.vimrc<cr>


" map for putting double-quotes around a word
nnoremap <Leader>" viw<esc>a"<esc>hbi"<esc>lel

" map for putting single-quotes around a word
noremap <Leader>' viw<esc>a'<esc>hbi'<esc>lel

" map for putting double-quotes around visually-selected text in visual mode
vnoremap <Leader>" <esc>`>a"<esc>`<i"<esc>

" somewhat risky map to save from effort to press <esc> by mapping 'jk' to it
" inoremap jk <esc>

" little less risky, using <Leader>
inoremap <Leader>jk <esc>

" opens previous buffer in a split window in top or left
nnoremap <Leader>pbs :execute "topleft split " . bufname("#")<cr>

" matches and highlights trailing whitespace as an Error
nnoremap <Leader>w :execute "match Error /\\v\\s+$/"<cr>
" clears the Error  match for trailing whitespace
nnoremap <Leader>W :execute "match none /\\v\\s+$/"<cr>

" map to turn off hlsearch for the last search
nnoremap <Leader>nhl :execute "nohlsearch"<cr>

" mapping to grep stuff
" nnoremap <Leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen 12<cr>

" toggling paste mode, pastetoggle
set pastetoggle=<F9>


" Maps with functions----------  {{{


" map to toggle the fold column
nnoremap <Leader>f :call <SID>FoldColumnToggle()<cr>

function! s:FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=4
    endif
endfunction


" map to toggle number line
nnoremap <Leader>nn :call <SID>NumberLineToggle()<cr>

function! s:NumberLineToggle()
    if &number
        setlocal nonumber
    else
        setlocal number
    endif
endfunction

nnoremap <Leader>ai :call <SID>AutoIndentToggle()<cr>

function! s:AutoIndentToggle()
    if &autoindent
        setlocal noautoindent
    else
        setlocal autoindent
    endif
endfunction


" map and function to toggle the QuickFix window
nnoremap <Leader>q :call <SID>QuickfixToggle()<cr>

let g:quickfix_is_open = 0

function! s:QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

"variable flag for if running the toggle for first time
let g:s_toggle_first_time = 1

"function to toggle solarized colorscheme
nnoremap <Leader>sol :call <SID>SolarizedToggle()<cr>

function! s:SolarizedToggle()
    if g:s_toggle_first_time == 1
        " if first time then declare the global variables
        " and clear the flag
        let g:s_toggle_first_time = 0
        let g:colors_name = "default"
        let g:old_colo = g:colors_name
    endif
    if g:colors_name ==# "solarized" 
        execute "colorscheme " . g:old_colo
    else
        let g:old_colo = g:colors_name
        set background=light
        colorscheme solarized
    endif
endfunction

"variable flag for if running the toggle for first time
let g:sd_toggle_first_time = 1

"function to toggle solarized dark colorscheme
nnoremap <Leader>sod :call <SID>SolarizedDarkToggle()<cr>

function! s:SolarizedDarkToggle()
    if g:sd_toggle_first_time == 1
        " if first time then declare the global variables
        " and clear the flag
        let g:sd_toggle_first_time = 0
        let g:colors_name = "default"
        let g:old_colo = g:colors_name
    endif
    if g:colors_name ==# "solarized" 
        execute "colorscheme " . g:old_colo
    else
        let g:old_colo = g:colors_name
        set background=dark
        colorscheme solarized
    endif
endfunction

" }}}


" }}}

" FileType specific settings {{{

" augroups to prevent duplication
" JavaScript file settings {{{
augroup filetype_javascript
    autocmd!
    autocmd FileType javascript setlocal numberwidth=4
    autocmd FileType javascript :iabbrev <buffer> iff if ()<left>
    autocmd FileType javascript :iabbrev <buffer> ftn function ()<left>
    " map for adding a comment to the begging of a line
    autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
    " map to <localleader>; to put semicolon at end of line
    " and then return to original cursor location
    autocmd FileType javascript nnoremap <buffer> <LocalLeader>; :<c-u>execute "normal! mqA;\e`q"<cr>
augroup END
" }}} 

" Python file settings {{{
augroup filetype_python
    autocmd!
    autocmd FileType python setlocal tabstop=4|setlocal shiftwidth=4|setlocal expandtab
    autocmd FileType python :iabbrev <buffer> iff if:<left>
    autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
augroup END
" }}}

" C file settings {{{
augroup filetype_c
    autocmd!
    autocmd FileType c setlocal tabstop=4|setlocal shiftwidth=4|setlocal expandtab
    "autocmd FileType c :iabbrev <buffer> rtn return
    " map for adding a comment to the begging of a line
    autocmd FileType c nnoremap <buffer> <localleader>c I//<esc>
    " map to <localleader>; to put semicolon at end of line
    " and then return to original cursor location
    autocmd FileType c nnoremap <buffer> <LocalLeader>; :<c-u>execute "normal! mqA;\e`q"<cr>
augroup END
" }}}

" C++ file settings {{{
augroup filetype_cpp
    autocmd!
    autocmd FileType cpp setlocal tabstop=4|setlocal shiftwidth=4|setlocal expandtab
    "autocmd FileType cpp :iabbrev <buffer> rtn return
    " map for adding a comment to the begging of a line
    autocmd FileType cpp nnoremap <buffer> <localleader>c I//<esc>
    " map to <localleader>; to put semicolon at end of line
    " and then return to original cursor location
    autocmd FileType cpp nnoremap <buffer> <LocalLeader>; :<c-u>execute "normal! mqA;\e`q"<cr>
augroup END
" }}}

" Text file settings {{{
augroup filetype_text
    autocmd!
    autocmd FileType text :setlocal statusline=%f         " Path to the file
    autocmd FileType text :setlocal statusline+=%=        " Switch to the right side
    autocmd FileType text :setlocal statusline+=%l        " Current line
    autocmd FileType text :setlocal statusline+=/         " Separator
    autocmd FileType text :setlocal statusline+=%L        " Total lines
    autocmd FileType text :setlocal nonumber              " to disable numline
augroup END
" }}}

" some operator things
" around last paren
" onoremap al( :<c-u>normal! f)lviw<cr>
" around next paren
" onoremap an( :<c-u>normal! f(hviw<cr>
" inside next parens
" onoremap in( :<c-u>normal! f(vi(<cr>
" inside last (previous) parens
" onoremap il( :<c-u>normal! F)vi(<cr>

" Markdown file settings {{{
augroup filetype_markdown
    autocmd!
    autocmd FileType markdown setlocal tabstop=2|setlocal shiftwidth=2|setlocal expandtab
    " for editing header with === or --- underneath
    autocmd FileType markdown onoremap <buffer> ih :<c-u>execute "normal! ?^[==\|--]\\+$\r:nohlsearch\rkvg_"<cr> 
    " around the section heading
    autocmd FileType markdown onoremap <buffer> ah :<c-u>execute "normal! ?^[==\|--]\\+$\r:nohlsearch\rg_vk0"<cr>
augroup END
" }}}

" Vimscript file settings-------------------- {{{ 
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim nnoremap <buffer> <LocalLeader>sf :source %<cr>
augroup END
" }}}

" Makefile settings {{{
augroup filetype_makefiles
    autocmd!
    " add list lcs=tab:>-,trail:x for tab/trailing space visuals
    autocmd BufEnter ?akefile* set noet ts=8 sw=8 nocindent
    autocmd BufEnter *.mk set noet ts=8 sw=8 nocindent
augroup END
" }}}

" Arduino file settings {{{
augroup filetype_arduino
    autocmd!
    autocmd BufNewFile,BufRead *.ino setlocal ft=arduino
augroup END
" }}}

" Assembly file settings {{{
augroup filetype_assembly
    autocmd!
    autocmd FileType asm setlocal tabstop=4|setlocal shiftwidth=4|setlocal expandtab
augroup END
" }}}

" Perl file settings {{{
augroup filetype_perl
    autocmd!
    autocmd FileType perl setlocal tabstop=4|setlocal shiftwidth=4|setlocal expandtab
augroup END
" }}}

" }}}

" name of next email address
" onoremap nn@ :<c-u>normal! f@hviw<cr>

" change the next whole email address



