" MY VIMRC!

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

" Improves drawing with fast terminals
set ttyfast

" Show cursor in ruler
set ruler

" Better command line completion
set wildmenu

" Show what you are typing as a command.
set showcmd

" Ward off unexpected things influenced by distro
set nocompatible

" Turn on syntax highlighting.
syntax enable
syntax on

" Keep at least 3 lines above/below when scrolling
set scrolloff=3

" Enable mouse support in console.
set mouse=a

" Turn on line numbers
set number

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

" If using gui, select fav colorscheme
if has("gui_running")
    colorscheme desert
endif

" Always show statusline
set laststatus=2

" Keep all backup and temp files in the same place
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" Automatically set directory to current file
set autochdir

" Mapping to make colon command easier
nnoremap ; :
nnoremap : ;

" Map jj to escape
inoremap jj <Esc>


