set nocompatible            " Turn off vi compatibility mode
filetype off                " Interferes with Pathogen, so turn off
call pathogen#helptags()    " Generate help tags for plugins
call pathogen#infect()      " Load all the plugins


" Set filetypes to on
filetype on
filetype indent on
filetype plugin on

" System leader for mappings is now ","
let mapleader=","

" Tabstops are 2 spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent


""" UI settings

set number                  " Show line numbers
set showcmd                 " Show last command in bottom bar
set showmode                " Show the current mode in the bottom bar
set cursorline              " Highlights current line
filetype indent on          " Load filetype specific indentation files
set wildmenu                " Visual autocomplete for command menu
set lazyredraw              " Redraw only when needed
set ttyfast                 " Smoother redrawing
set showmatch               " Show matching parenthesis
set encoding=utf-8          " Default to UTF-8
set backspace=2             " Make backspace work for indent, eol, start
set autowrite               " Autowrite files when leaving

colorscheme zenburn         " Pretty colours


""" Searching

set incsearch               " Search as characters are entered
set hlsearch                " Highlight search matches
nnoremap <leader><space> :nohlsearch<CR>


" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
