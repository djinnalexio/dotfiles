#!/usr/bin/sh

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Setup dnf:"
echo "fastestmirror=1" | sudo tee -a /etc/dnf/dnf.conf > /dev/null
echo "max_parallel_download=10" | sudo tee -a /etc/dnf/dnf.conf > /dev/null
echo "defaultyes=yes" | sudo tee -a /etc/dnf/dnf.conf > /dev/null
sudo dnf update -y --refresh

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Installing terminal tools:"
sudo dnf install autojump cmatrix git git-lfs lsd man neofetch neovim tldr unzip zip -y

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Installing nerd fonts and symbols:"
for font in NerdFontsSymbolsOnly CascadiaCode CodeNewRoman FantasqueSansMono FiraCode JetBrainsMono Meslo SourceCodePro Terminus Ubuntu VictorMono
    if [ ! -d "~/.local/share/fonts/$font" ] ; then
    do
        wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/$font.zip" --directory-prefix ~/.local/share/fonts
        unzip ~/.local/share/fonts/$font.zip -d ~/.local/share/fonts/$font/ &> /dev/null
        rm ~/.local/share/fonts/$font.zip -f
    fi
done
rm ~/.local/share/fonts/*/*Windows* -f

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Installing vim-plug and setting up plugins for neovim:"
wget "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" --directory-prefix ~/.local/share/nvim/site/autoload/
sudo dnf install nodejs -y
nvim -c ':PlugInstall' -c ':qa'
