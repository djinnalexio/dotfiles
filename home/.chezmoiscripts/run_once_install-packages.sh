#!/usr/bin/sh

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Setup dnf:"
sudo tee -a /etc/dnf/dnf.conf > /dev/null << EOT
fastestmirror=1
deltarpm=true
keepcache=true
defaultyes=yes
max_parallel_download=20
EOT
cat /etc/dnf/dnf.conf
sudo dnf update -y --refresh

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Installing terminal tools:"
sudo dnf install autojump cmatrix git git-lfs lsd man neofetch neovim tldr unzip zip -y

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Installing nerd fonts and symbols:"
for font in NerdFontsSymbolsOnly CascadiaCode CodeNewRoman FantasqueSansMono FiraCode JetBrainsMono Meslo SourceCodePro Terminus Ubuntu VictorMono
do
    if [[ ! -d "$HOME/.local/share/fonts/$font" ]] ; then
        wget "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font.zip" --directory-prefix ~/.local/share/fonts
        unzip ~/.local/share/fonts/$font.zip -d ~/.local/share/fonts/$font/ &> /dev/null
        rm ~/.local/share/fonts/$font.zip -f
        rm ~/.local/share/fonts/$font/*Windows* -f
        echo "Installed $font.\n"
    else
        echo "$font already installed.\n"
    fi
done

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Installing vim-plug and setting up plugins for neovim:"
if [[ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]] ; then
    wget "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" --directory-prefix ~/.local/share/nvim/site/autoload/
fi
sudo dnf install nodejs -y
nvim -c ':PlugInstall' -c ':qa'
