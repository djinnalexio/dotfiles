#!/usr/bin/sh

printf "%.s-" $(seq 1 80)
echo
echo "Installing vim-plug and setting up plugins for neovim:"
if [ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ] ; then
    wget "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" --directory-prefix ~/.local/share/nvim/site/autoload/
fi
nvim -c ':PlugInstall' -c ':qa'

printf "%.s-" $(seq 1 80)
echo
