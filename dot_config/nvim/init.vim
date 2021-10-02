


set nocompatible			" don't attempt to be compatible with vi/vim
filetype off				" we don't want it on before loading the plugins

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" Add plugins below

Plug 'vim-airline/vim-airline'		" status bar format
Plug 'vim-airline/vim-airline-themes'

" Plug 'tpope/vim-fugitive'		" git plugin

" Plug 'preservim/nerdtree'		" file explorer

" Plug 'ctrlpvim/ctrlp.vim'		" fuzzy file searcher

" Plug 'sensible.vim'


" Plugins for code completion



" Plugins for appearance
"
"
"
" Plugins for extra tools


" Initialize plugin system
call plug#end()

set number

" Source configs
source $HOME/.config/nvim/themes/airline.vim
