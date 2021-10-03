""""""""""""""""""""""""""""""""""""""""""""""""""""""
"      _  _ _                   _           _        "
"   __| |(_|_)_ __  _ __   __ _| | _____  _(_) ___   "
"  / _` || | | '_ \| '_ \ / _` | |/ _ \ \/ / |/ _ \  "
" | (_| || | | | | | | | | (_| | |  __/>  <| | (_) | "
"  \__,_|/ |_|_| |_|_| |_|\__,_|_|\___/_/\_\_|\___/  "
"      |__/                                          "
"                                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This is my Nvim configuration for Linux.

au! BufWritePost $MYVIMRC source %      " this file is automatically sourced when saved

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off                            " we don't want it on before loading the plugins

call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline'          " status bar format
Plug 'vim-airline/vim-airline-themes'   " additional themes for status bar

" Plug 'tpope/vim-fugitive'             " git plugin
" Plug 'preservim/nerdtree'             " file explorer
" Plug 'ctrlpvim/ctrlp.vim'             " fuzzy file searcher
" Plug 'sensible.vim'

" Initialize plugin system
call plug#end()



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" General 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible			            " don't attempt to be compatible with vi/vim
set clipboard+=unnamedplus              " using system clipboard
"set confirm                            " ask for confirmation when saving
set hidden                              " Required to keep multiple buffers open multiple buffers
set updatetime=300                      " Faster completion
set timeoutlen=200                      " By default timeoutlen is 1000 ms
set encoding=UTF-8                      " set the default encoding



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Search
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hlsearch                            " highlight search
set incsearch                           " increamental search
set ignorecase                          " search is case insensitive
set smartcase                           " ... becomes sensitive if an uppercase letter is entered

"set wildmode=longest,list               " get bash-like tab completions
set wildignore=*.swp,*.bak,*.pyc,*.class    " things to exclude from completion



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Format
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4                           " number of columns occupied by a tab
set softtabstop=4                       " see multiple spaces as tabstops so <BS> does the right thing
set shiftwidth=4                        " width for autoindents
set smarttab                            " detects what length of tabs is being used
set expandtab                           " converts tabs to spaces
set smartindent                         " detects what indents are needed
set autoindent                          " indent a new line the same amount as the line just typed




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Swap & Backup 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:enableswap = 1                    " enable the use of swap files when editing
let g:enablebackup = 0                  " enable backups of files (not recommended for coc)

" those options may not be that useful when VCS is present

if enableswap
    if !isdirectory('./swap')           " create a swap directory if necessary
        call mkdir('./swap', 'p')
    endif
    set directory=./swap//              " make it the default localtion for swap files
else
    set noswapfile                      " disable swapfiles
endif

if enablebackup
    if !isdirectory('./backup')         " create a backup directory if necessary
        call mkdir('./backup', 'p')
    endif
    set backupdir=./backup//            " make it the default localtion for backup files
else
    set nobackup                        " disable backups
    set nowritebackup
endif



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Visual
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on                               " syntax highlighting
set title                               " have the name of the file as window title
set number                              " shows lines numbers on the left
set showtabline=2		                " Always show tabs
set noshowmode			                " We don't need to see things like -- INSERT -- anymore
set cursorline                          " highlight current cursorline
"set cc=80                               " set an 80 column border
set splitbelow                          " Horizontal split below current
set splitright                          " Vertical split to right of current
set scrolloff=10                        " rows above/below cursor while scrolling
set sidescrolloff=5                     " columns to left/right of cursor while scrolling
set showmatch                           " Show matching brackets
set nowrap                              " Display long lines as just one line
set pumheight=10                        " Makes popup menu smaller







""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Plugin Configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " airline
    """""""""

" enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

" enable powerline fonts
let g:airline_powerline_fonts = 1
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''

" Switch to your current theme
let g:airline_theme = 'violet'



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Key Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

" Alternative to Escape key
inoremap jk <Esc>
inoremap kj <Esc>      

" Alternate way to save
nnoremap <C-s> :w<CR>

" Alternate way to save & quit
nnoremap <C-Q> :wq!<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv




