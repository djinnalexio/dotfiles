#!/bin/sh

printf "%.s=" $(seq 1 $(tput cols))
echo
echo "Installing nerd fonts and symbols:"
echo
for font in NerdFontsSymbolsOnly CascadiaCode CodeNewRoman FiraCode JetBrainsMono Meslo SourceCodePro UbuntuMono VictorMono
do
    if [ ! -d "$HOME/.local/share/fonts/$font" ] ; then
        wget "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font.zip" --directory-prefix ~/.local/share/fonts
        unzip ~/.local/share/fonts/$font.zip -d ~/.local/share/fonts/$font/ > /dev/null
        rm ~/.local/share/fonts/$font.zip -f
        rm ~/.local/share/fonts/$font/*Windows* -f
        echo "Installed $font."
        echo
    else
        echo "$font already installed."
        echo
    fi
done

printf "%.s=" $(seq 1 $(tput cols))
echo
echo "Installing vim-plug and setting up plugins for neovim:"
if [ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ] ; then
    wget "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" --directory-prefix ~/.local/share/nvim/site/autoload/
fi
nvim -c ':PlugInstall' -c ':qa'

printf "%.s=" $(seq 1 $(tput cols))
echo
gsettings set org.gnome.desktop.background show-desktop-icons false
echo "Disabled icons on GNOME desktop."
gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-weekday true
echo "Set clock format."

printf "%.s=" $(seq 1 $(tput cols))
echo
echo "Setting up ZSH as the default shell:"
chsh -s /usr/bin/zsh

printf "%.s=" $(seq 1 $(tput cols))
echo
