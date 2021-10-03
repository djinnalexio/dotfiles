
"" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off                            " we don't want it on before loading the plugins

" Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline'          " status bar format
Plug 'vim-airline/vim-airline-themes'   " additional themes for status bar

" Plug 'tpope/vim-fugitive'             " git plugin
" Plug 'preservim/nerdtree'             " file explorer
" Plug 'ctrlpvim/ctrlp.vim'             " fuzzy file searcher
" Plug 'sensible.vim'

" Initialize plugin system
call plug#end()



"" General 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible			" don't attempt to be compatible with vi/vim



"" Search
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"" Format
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab



"" Visual
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number			" shows lines numbers on the left
set showtabline=2		" Always show tabs
set noshowmode			" We don't need to see things like -- INSERT -- anymore



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



