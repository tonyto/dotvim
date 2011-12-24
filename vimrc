" }}}
" Bootstrap plugins and filetypes {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" }}}
" Basic stuff {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=1000          " Increase command history size
set ruler                 " Show the ruler
set incsearch             " Incomplete search matches
set hlsearch              " Keep search highlight after complete
set showmode              " Show the current mode in the last line
set showcmd               " Show the current command in the last line
set showmatch             " Highlight matching brackets
set title                 " Set the window title in the terminal
set wildmenu              " Improve tab completion menu
set wildmode=list:longest " Tab complete longest common string and show list
"set t_Co=256              " Set 256 color mode
set wildignore+=.git,.hg,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.sw?                            " Vim swap files
set encoding=utf-8        " Default to UTF-8
set scrolloff=2           " start scrolling 2 lines from screen edge
syntax on                 " Enable syntax highlighting
"colorscheme zenburn       " Make it pretty
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

" }}}
" Cursor settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set cursorline                       " Highlight the line under the cursor
"set nocursorcolumn                   " Don't Highlight the column
"au WinEnter * setlocal cursorline    " Turn on cursorline on focus
"au WinLeave * setlocal nocursorline  " And off on losing focus

" }}}
" Color column settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set colorcolumn=80        " Show 80 char column in light grey
"highlight ColorColumn ctermbg=239 guibg=#4f4f4f
" Disable colorcolumn in the quickfix buffers
"au Filetype qf setlocal colorcolumn=0 nolist nocursorline nowrap

" }}}
" Backups, undo and swapfiles {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set undofile
set undodir=~/.vim/tmp/undo,~/tmp,/tmp
set backupdir=~/.vim/tmp/backup,~/tmp,/tmp
set directory=~/.vim/tmp/swap/,~/tmp,/tmp
set noswapfile

" }}}
" Indentation and whitespace {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" Allow Mouse in normal and visual mode
set mouse=nv

" }}}
" Folding {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldlevelstart=99               " Open all folds
set foldcolumn=3                    " Show 3 levels

" }}}
" Keymaps {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
let maplocalleader=","

" Toggle NERDTRee with F2 in command mode
noremap <f2> :NERDTreeToggle<cr>
" and in insert mode
inoremap <f2> :NERDTreeToggle<cr>i
" Open .vimrc in a new split for quick editing
nnoremap <leader>ev :split $MYVIMRC<cr>
" Source .vimrc in current window
nnoremap <leader>sv :source $MYVIMRC<cr>
" Go to start of line
nnoremap H 0
" Go to end of line
nnoremap L $

" }}}
" Whitespace keymaps {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle whitespace
noremap <leader>l :set list!<cr>
" Strip Trailing
nnoremap <leader>W :call <SID>StripTrailingWhitespaces()<cr>

" }}}
" Window manipulation keymaps {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quicker window navigation
noremap <C-h>             <C-w>h
noremap <C-j>             <C-w>j
noremap <C-k>             <C-w>k
noremap <C-l>             <C-w>l
noremap +                 <C-w>+
noremap -                 <C-w>-
" Split window and move down into new window
nnoremap <leader>w        <C-w>s<C-w>j

" }}}
" Mode switching keymaps {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Exit insert mode
inoremap jk               <esc>
inoremap <esc>            <NOP>
inoremap <c-c>            <NOP>

" }}}
" Remap annoying default keymaps {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unmap the arrow keys
inoremap <Up>             <NOP>
inoremap <Down>           <NOP>
inoremap <Left>           <NOP>
inoremap <Right>          <NOP>
noremap <Up>              <NOP>
noremap <Down>            <NOP>
noremap <Left>            <NOP>
noremap <Right>           <NOP>
" Unmap the infuriating help shortcut key
inoremap <F1>             <ESC>
nnoremap <F1>             <ESC>
vnoremap <F1>             <ESC>
" Move up and down by screenline instead of file line
nnoremap j                gj
nnoremap k                gk
" Fix vim's regexp search to use perl regexps
nnoremap /                /\v
vnoremap \                /\v
" Move to matching bracket
nnoremap <tab>            %
vnoremap <tab>            %
" Don't enter ex mode
noremap Q                 <nop>

" Turn off search highlighting
nnoremap <leader><space>  :noh<cr>
" Bring up ack ready to searc
nnoremap <leader>a        :Ack!

" }}}
" Auto close character sequences {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto append closing curly braces and skip over closing braces
inoremap {            {}<Left>
inoremap {<CR>        {<CR>}<ESC>O
inoremap {{           {
inoremap {}           {}
inoremap <expr> }     strpart(getline('.'), col('.') - 1, 1) == "}"
                     \? "\<Right>" : "}"
" Parentheses
inoremap (            ()<Left>
inoremap <expr> )     strpart(getline('.'), col('.') - 1, 1) == ")"
                     \? "\<Right>" : ")"
" C-style comments
inoremap /*           /**/<Left><Left>
inoremap /*<Space>    /*<Space><Space>*/<Left><Left><Left>
inoremap /*<CR>       /*<CR>*/<Esc>O
inoremap <Leader>/*   /*

" }}}
" Command Maps {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable saving readonly files with sudo
cmap w!! %!sudo tee > /dev/null %
command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g

" }}}
" Gentags config {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap ,t :!(cd %:p:h;ctags *)&
set tags=./tags,./../tags,./../../tags,./../../../tags,tags

" }}}
" Syntastic configuration {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_mode_map = { 'mode': 'active',
                         \ 'active_filetypes': [ 'javascript' ],
                         \ 'passive_filetypes': [] }
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

" }}}
" Rainbow Parentheses confiugration {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>R :RainbowParenthesesToggle<cr>
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16

" Turn on rainbow parentheses for all types by default
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


" }}}
" Enable toggling of the quickfix and errors window {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ToggleErrors()
	if exists("w:is_error_window")
		unlet w:is_error_window
		exec "q"
	else
		exec "Errors"
		botright lopen
		let w:is_error_window = 1
	endif
endfunction

function! ToggleQuickFix(forced)
	if exists('g:quickfix_is_open') && a:forced == 0
		unlet g:quickfix_is_open
		cclose
	else
		botright copen 10
		let g:quickfix_is_open = bufnr("$")
	endif
endfunction

command! -bang -nargs=? ToggleQuickFix call ToggleQuickFix(<bang>0)
command! ToggleErrors call ToggleErrors()

:noremap <F4> :ToggleQuickFix<CR>
:noremap <F3> :ToggleErrors<CR>

" }}}
" Statusline {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=%f                              " Path
set statusline+=%m                             " Modified flag
set statusline+=%r                             " Readonly flag
set statusline+=%{fugitive#statusline()}       " Show git repo status

set statusline+=%#error#                       " Error highlight
set statusline+=%{SyntasticStatuslineFlag()}   " Show syntastic error status
set statusline+=%*                             " Reset highlighting

set statusline+=%=                             " Right align

set statusline+=%c,                            " Cursor column
set statusline+=%l/%L                          " Cursor line / total lines
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

" }}}
" Css and less files {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup ft_css
	au!

	au BufNewFile,BufRead *.less setlocal filetype=less

	" Make folding work
	au FileType less,css setlocal foldmethod=marker
	au FileType less,css setlocal foldmarker={,}
augroup END

" }}}
" Javascript files {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup ft_javascript
	au!

	au FileType javascript setlocal foldmethod=marker
	au FileType javascript setlocal foldmarker={,}
augroup END

" }}}
" Vimscript files {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup ft_vim
	au!

	au FileType vim setlocal foldmethod=marker
	au FileType vim setlocal foldmarker={,}
augroup END

" }}}
" Commands to run on startup {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

