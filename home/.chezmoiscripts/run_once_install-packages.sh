#!/usr/bin/sh

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Setup dnf:"
echo "fastestmirror=1\nmax_parallel_download=20\ndefaultyes=yes\n" | sudo tee -a /etc/dnf/dnf.conf > /dev/null
sudo dnf update -y --refresh

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Installing terminal tools:"
sudo dnf install autojump cmatrix git git-lfs lsd man neofetch neovim tldr unzip zip -y

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Installing nerd fonts and symbols:"
for font in NerdFontsSymbolsOnly CascadiaCode CodeNewRoman FantasqueSansMono FiraCode JetBrainsMono Meslo SourceCodePro Terminus Ubuntu VictorMono
    do
    wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/$font.zip" --directory-prefix ~/.local/share/fonts
    unzip ~/.local/share/fonts/$font.zip -d ~/.local/share/fonts/$font/ &> /dev/null
    rm ~/.local/share/fonts/$font.zip -f
    rm ~/.local/share/fonts/$font/*Compatible.ttf -f
done

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Installing vim-plug and setting up plugins for neovim:"
wget "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" --directory-prefix ~/.local/share/nvim/site/autoload/
sudo dnf install nodejs -y
nvim -c ':PlugInstall' -c ':qa'
