#!/usr/bin/sh

printf "%.s-" $(seq 1 80)
echo
echo "Installing nerd fonts and symbols:"
echo
for font in NerdFontsSymbolsOnly CascadiaCode CodeNewRoman FantasqueSansMono FiraCode JetBrainsMono Meslo SourceCodePro Terminus Ubuntu VictorMono
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

printf "%.s-" $(seq 1 80)
echo
echo "Installing vim-plug and setting up plugins for neovim:"
if [ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ] ; then
    wget "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" --directory-prefix ~/.local/share/nvim/site/autoload/
fi
nvim -c ':PlugInstall' -c ':qa'

printf "%.s-" $(seq 1 80)
echo
echo "Configure GNOME Terminal:"
dconf load /org/gnome/terminal/legacy/profiles:/ < ~/.config/gnome-terminal-profiles.dconf

printf "%.s-" $(seq 1 80)
echo
echo "Setting up ZSH as the default shell:"
chsh -s /usr/bin/zsh

printf "%.s-" $(seq 1 80)
echo
