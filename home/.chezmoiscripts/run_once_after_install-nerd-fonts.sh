#!/usr/bin/sh

printf '%.s-' {1..80}
echo
echo "Installing nerd fonts and symbols:"
echo
for font in NerdFontsSymbolsOnly CascadiaCode CodeNewRoman FantasqueSansMono FiraCode JetBrainsMono Meslo SourceCodePro Terminus Ubuntu VictorMono
do
    if [[ ! -d "$HOME/.local/share/fonts/$font" ]] ; then
        wget "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font.zip" --directory-prefix ~/.local/share/fonts
        unzip ~/.local/share/fonts/$font.zip -d ~/.local/share/fonts/$font/ &> /dev/null
        rm ~/.local/share/fonts/$font.zip -f
        rm ~/.local/share/fonts/$font/*Windows* -f
        echo "Installed $font."
        echo
    else
        echo "$font already installed."
        echo
    fi
done
