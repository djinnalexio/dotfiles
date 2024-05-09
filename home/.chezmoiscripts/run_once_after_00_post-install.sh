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
if command -v nvim &> /dev/null; then
    nvim -c ':PlugInstall' -c ':qa'
else
    echo 'Neovim is not installed yet. Run `:PlugInstall` the first time you use it to install the plugins.'
fi

printf "%.s=" $(seq 1 $(tput cols))
echo
gsettings set org.gnome.desktop.background show-desktop-icons false
echo "Disabled icons on GNOME desktop."
gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-weekday true
echo "Set clock format."
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer', 'variable-refresh-rate']"
echo "Enabled V-Sync and fractional scaling."

printf "%.s=" $(seq 1 $(tput cols))
echo
echo "Setting up ZSH as the default shell:"
chsh -s /usr/bin/zsh

printf "%.s=" $(seq 1 $(tput cols))
echo
echo "Enabling flathub repository:"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update --appstream
flatpak update

printf "%.s=" $(seq 1 $(tput cols))
echo
echo "Installing Pywal and some alternative backends for color parsing:"
if command -v pip3 &> /dev/null; then
    pip3 install --user pywal16 colorz haishoku colorthief
else
    echo '`pip` not found. Pywal was not installed.'
fi
echo 'With Pywal16, you can run `wal --cols16 -a 75 --saturate 1 -n -i <path/to/img>` to create and apply a new color scheme.'
echo "'-a' for opacity and '-n' to disable changing the current wallpaper."

printf "%.s=" $(seq 1 $(tput cols))
echo
