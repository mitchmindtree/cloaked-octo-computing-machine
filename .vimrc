" MY VIMRC!

" Run Pathogen...
execute pathogen#infect()

" Tab business (set to 4 spaces)
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab

" Smart indenting specific to files
filetype indent plugin on
set autoindent smartindent

" File saving and confirmation
set confirm
set autowriteall

" be iMproved, required
set nocompatible

" Improves drawing with fast terminals
set ttyfast

" Show cursor in ruler
set ruler

" Better command line completion
set wildmenu

" Show what you are typing as a command.
set showcmd

" Turn on syntax highlighting.
syntax enable
syntax on

" Allow filetype dependent stuff.
filetype on

" Keep at least 3 lines above/below when scrolling
set scrolloff=3

" Enable mouse support in console.
set mouse=a

" Turn on line numbers
set number

" Sync clipboards
set clipboard^=unnamed

" Make backspace delete over newlines etc
set backspace=2

" Ignore case using / but consider when uppercase is specified
set ignorecase
set smartcase

" Move cursor to matched string while searching and highlight
set incsearch
set hlsearch

" Map jj to escape
inoremap jj <Esc>

" Set off matching parenthesis
highlight MatchParen ctermbg=4

" Always show statusline
set laststatus=2

" Keep all backup and temp files in the same place
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" Automatically set directory to current file
set autochdir

" Soft wrap text
set wrap linebreak nolist

" Change line number colour.
highlight LineNr ctermfg=darkblue

" Mapping to make colon command easier
nnoremap ; :
nnoremap : ;
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap j gj
nnoremap k gk

" Map ctrl j/k to scroll 3lines in insert mode.
nnoremap <C-k> <C-y><C-y><C-y>
nnoremap <C-j> <C-e><C-e><C-e>

" If Python file is buffer, excute current file with...
autocmd FileType python nnoremap <buffer> <F5> :exec '!python' shellescape(@%, 1)<cr>

" Auto open NERDTree...
autocmd vimenter * NERDTree

""""""" Jedi-Vim...

" Python imports goto
nnoremap <C-p> :Pyimport 

" Stop doc-strings from popping up during auto completion...
autocmd FileType python setlocal completeopt-=preview

" Shortcut for running the current file as python script.
autocmd FileType python nnoremap <Leader>b :!python %<CR>

""""""" Clang Complete...

let g:clang_use_library=1

let s:clang_library_path='/Library/Developer/CommandLineTools/usr/lib'
if isdirectory(s:clang_library_path)
    let g:clang_library_path=s:clang_library_path
endif

let g:clang_user_options='|| exit 0'
let g:clang_close_preview=1

" See definition, and return.
nnoremap <Leader>] <C-]>
nnoremap <Leader>[ <C-t>

""""""" Syntastic...

" Check header files
let g:syntastic_cpp_check_header=1

" Compiler
let g:syntastic_cpp_compiler='clang++'
let g:syntastic_cpp_compiler_options=' -std=c++11 -stdlib=libc++'
let g:syntastic_check_on_open=0
let g:syntastic_cpp_config_file='.clang_complete'

" Passive Mode for cpp / h
" let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['rust'], 'passive_filetypes': ['cpp', 'h'] }
autocmd FileType cpp nnoremap <C-e> :SyntasticCheck<CR>
autocmd FileType h nnoremap <C-e> :SyntasticCheck<CR>

" Auto-complete easier with ctrl-space
autocmd Filetype cpp inoremap <C-Space> <C-x><C-o>
autocmd Filetype h inoremap <C-Space> <C-x><C-o>
autocmd Filetype rust inoremap <C-Space> <C-x><C-o>
if !has("gui_running")
    inoremap <C-@> <C-x><C-o>
endif

" Syntax highlighting
let g:syntastic_enable_highlighting=0

" Turn off signs for Rust
autocmd Filetype rust let g:sytastic_enable_signs=0

" let g:syntastic_rust_rustc_fname = "src/main.rs"
" let g:syntastic_rust_rustc_args = ['--no-trans']

""""""" A.Vim

" Switch to alternate with \a or \v to split
nnoremap <Leader>a :A<CR>
nnoremap <Leader>v :AV<CR>

" Auto run
" autocmd Filetype cpp nnoremap <Leader>r :call ManageBuild(getcwd(), '-r')
" autocmd Filetype h nnoremap <Leader>r :call ManageBuild(getcwd(), '-r')

" Make statusbar black.
hi StatusLine ctermbg=white ctermfg=black
hi StatusLineNC ctermbg=blue ctermfg=black

" Make vsplits black
hi VertSplit ctermfg=black

" Stop weird backspace behaviour from elm.vim in .elm files.
let g:Haskell_no_mapping=1

