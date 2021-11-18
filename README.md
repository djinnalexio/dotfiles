# My Dotfiles

I use `chezmoi` to manage my dotfiles and other configuration files. My current OS is Fedora 35.

Here is the list of programs with configuration files that `chezmoi` manages.

Instantly apply this system configuration:
```
sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply djinnalexio
```

## Essentials

* ZSH
    * My default shell
    ```bash
    sudo dnf -y install zsh
    sudo usermod -s $(which zsh) $USER      # set it as the default shell for the current user
    ```

* Aliases commands
    * `sudo dnf -y lsd conda autojump`

* Welcome Message Text
    * Programs used to display to greet the users when opening the terminal.
    * `sudo dnf -y install cowsay lolcat fortune-mod figlet`

* Neofetch
    * ~~Show off~~ Display system information
    * `sudo dnf -y install neofetch`

* Git, Git-lfs, and Gitmoji
    * Version Control System
    * Support for large files with Git
    * Emoji helper for expressive commits
    ```bash
    sudo dnf -y install git git-lfs npm
    git-lfs install
    npm i -g gitmoji-cli
    ```

* Neovim
    * My default text editor
    * `sudo dnf -y install neovim`

* Key-mapper
    * ~~Mostly~~ Only used to map the side buttons on a mouse to ALT+L and ALT+R on the keyboard
    ```bash
    sudo pip install --no-binary :all: git+https://github.com/sezanzeb/ key-mapper.git
    sudo systemctl enable key-mapper
    sudo systemctl restart key-mapper
    ```

## Non-Essentials

* Kitty
    * My current terminal emulator
    * Minimal and fast
    * `sudo dnf -y install kitty`

* Terminator
    * My previous terminal emulator
    * `sudo dnf -y install terminator`

* powerline-shell
    * Setup to beautify the bash shell
    * `sudo pip3 install powerline-shell`

* ULauncher
    * An app launcher that I find convenient
    * `sudo dnf -y install ulauncher`