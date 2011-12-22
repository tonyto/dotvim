"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bootstrap plugins and filetypes
"""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible            " Turn off vi compatibility mode
filetype off                " Interferes with Pathogen, so turn off
call pathogen#helptags()    " Generate help tags for plugins
call pathogen#infect()      " Load all the plugins
filetype on                 " Reenable filetype
filetype indent on
filetype plugin on

" Use the matchit macro to enable switching between open close tags and
" if/elsif/else/end with %
runtime macros/matchit.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=1000          " Increase command history size
set ruler                 " Show the ruler
set incsearch             " Incomplete search matches
set hlsearch              " Keep search highlight after complete
set relativenumber        " Show line numbers
set showmode              " Show the current mode in the last line
set showcmd               " Show the current command in the last line
set showmatch             " Highlight matching brackets
set title                 " Set the window title in the terminal
set wildmenu              " Improve tab completion menu
set wildmode=list:longest " Tab complete longest common string and show list
set t_Co=256              " Set 256 color mode
set wildignore+=.git,.hg,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.sw?                            " Vim swap files
set encoding=utf-8        " Default to UTF-8
set scrolloff=2           " start scrolling 2 lines from screen edge
syntax on                 " Enable syntax highlighting
colorscheme zenburn       " Make it pretty
set hidden                " Hide rather than close abandoned buffers
set backspace=2           " Make backspace work for indent, eol, start
set shortmess=atI         " Shorten the large interruptive prompts
set ttyfast               " Smoother redrawing with multiple windows
set lazyredraw            " Suspend redrawing while running macros
set matchtime=3           " Jump to matching paren for a briefer time
set splitbelow            " Open new splits below current window
set splitright            " Open new vsplits to the right
set autowrite             " Autowrite files when leaving
set dictionary=/usr/share/dict/words

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color column settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""
set colorcolumn=80        " Show 80 char column in light grey
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
" Disable colorcolumn in the quickfix buffers
au BufRead,BufNewFile * if &buftype == 'quickfix'|setlocal colorcolumn= |endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Backups, undo and swapfiles
"""""""""""""""""""""""""""""""""""""""""""""""""""""
set undofile
set undodir=~/.vim/tmp/undo,~/tmp,/tmp
set backupdir=~/.vim/tmp/backup,~/tmp,/tmp
set directory=~/.vim/tmp/swap/,~/tmp,/tmp
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation and whitespace
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automate resizing tabs
" See http://vimcasts.org/episodes/tabs-and-spaces/
command! -nargs=* Stab call Stab()

function! Stab()
	let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
	if l:tabstop > 0
		let &l:sts = l:tabstop
		let &l:ts = l:tabstop
		let &l:sw = l:tabstop
	endif
	call SummarizeTabs()
endfunction

function! SummarizeTabs()
	try
		echohl ModeMsg
		echon 'tabstop='.&l:ts
		echon ' shiftwidth='.&l:sw
		echon ' softtabstop='.&l:sts
		if &l:et
			echon ' expandtab'
		else
			echon ' noexpandtab'
		endif
	finally
		echohl None
	endtry
endfunction

function! <SID>StripTrailingWhitespaces()
	" Save the last search and cursor position
	let _s=@/
	let l = line(".")
	let c = col(".")

	%s/\s\+$//e

	let @/=_s
	call cursor(l, c)
endfunction

"Shortcut mapping
noremap <leader><tab> :Stab<cr>
" Indent new lines to same level as last
set autoindent
" Use nicer whitespace characters and show whitespace
set listchars=tab:>-,trail:-
set list
" Set visible character size of tabstops to 4 and make shift keys
" shift by 4 characters
set softtabstop=4
set tabstop=4
set shiftwidth=4

" Allow Mouse selection and navigation
set mouse=a

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldcolumn=3

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keymaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
let maplocalleader=","

" Toggle NERDTRee with F2 in command mode
noremap <f2> :NERDTreeToggle<cr>
" and in insert mode
inoremap <f2> :NERDTreeToggle<cr>i
" Move line down one
nnoremap - ddp
" Open .vimrc in a new split for quick editing
nnoremap <leader>ev :split $MYVIMRC<cr>
" Source .vimrc in current window
nnoremap <leader>sv :source $MYVIMRC<cr>
" Go to start of line
nnoremap H 0
" Go to end of line
nnoremap L $

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Whitespace keymaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle whitespace
noremap <leader>l :set list!<cr>
" Strip Trailing
nnoremap <leader>W :call <SID>StripTrailingWhitespaces()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Default map overrides
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quicker window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap + <C-w>+
noremap - <C-w>-
nnoremap <leader>w <C-w>s<C-w>j
" Exit insert mode
inoremap jk <esc>
inoremap <esc> <NOP>
inoremap <c-c> <NOP>
" Unmap the arrow keys
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
" Unmap the help shortcut key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
" Move up and down by screenline instead of file line
nnoremap j gj
nnoremap k gk
" Fix vim's regexp search to use perl regexps
nnoremap / /\v
vnoremap \ /\v
" Move to matching bracket
nnoremap <tab> %
vnoremap <tab> %
" Don't enter ex mode
noremap Q <nop>

" Turn off search highlighting
nnoremap <leader><space> :noh<cr>
" Bring up ack ready to searc
nnoremap <leader>a :Ack!

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command Maps
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable saving readonly files with sudo
cmap w!! %!sudo tee > /dev/null %
command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gentags config
"""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap ,t :!(cd %:p:h;ctags *)&
set tags=./tags,./../tags,./../../tags,./../../../tags,tags

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_mode_map = { 'mode': 'active', 
                         \ 'active_filetypes': [ 'javascript' ],
                         \ 'passive_filetypes': [] }
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable toggling of the quickfix window
"""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ToggleQuickFix() 
	if !exists("g:quickfix_is_open")
		let g:quickfix_is_open = 0
	endif

	if g:quickfix_is_open == 1
		let g:quickfix_is_open = 0
		cclose
	else
		let g:quickfix_is_open = 1
		copen
	endif
endfunction

command! -nargs=* ToggleQuickFix call ToggleQuickFix()
:noremap <F4> :ToggleQuickFix<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=%f                              " Path
set statusline+=%m                             " Modified flag
set statusline+=%r                             " Readonly flag
set statusline+=%{fugitive#statusline()}       " Show git repo status

set statusline+=%#error#                       " Error highlight
set statusline+=%{SyntasticStatuslineFlag()}   " Show syntastic error status
set statusline+=%*                             " Reset highlighting

set statusline+=%=                             " Right align

set statusline+=(
set statusline+=%{&ff}                         " Line ending format
set statusline+=/
set statusline+=%{strlen(&fenc)?&fenc:&enc}    " Encoding
set statusline+=/
set statusline+=%{&ft}                         " Filetype
set statusline+=)

" Always show status line
set laststatus=2

augroup ft_statusline_background_colour
	au InsertEnter * hi StatusLine ctermfg=15 guifg=#FF3145
	au InsertLeave * hi StatusLine ctermfg=236 guifg=#CD5907
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Commands to run on startup
"""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
	autocmd VimEnter * NERDTree
	autocmd VimEnter * wincmd p

	" Save on losing focus
	autocmd FocusLost * :wa

	" Custom tab settings
	" make must be tabs
	autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
	" yaml and coffeescript must be spaces
	autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
	autocmd FileType coffee setlocal ts=2 sts=2 sw=2 expandtab
	" Use javascript filetype for json files
	autocmd BufRead *.json setlocal filetype=javascript
endif

