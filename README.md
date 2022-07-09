# My Dotfiles

I use `chezmoi` to manage my dotfiles and other configuration files. My current OS is Fedora 36.

Instantly apply this system configuration:

```bash
sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply djinnalexio
```

## Shell Configuration Programs

Here is the list of programs that are referenced in the shell configuration scripts:

```sh
sudo dnf -y install lsd conda cowsay lolcat fortune-mod figlet neofetch git git-lfs npm neovim

git-lfs install

npm i -g gitmoji-cli

sudo pip3 install powerline-shell
```

* `lsd`: An improved `ls` command that includes colors and file icons
* `conda`: Anaconda to manage python environments
* `cowsay`: Displays messages in speech bubbles from animals and other ascii art
* `lolcat`: Rainbow-colored output
* `fortune-mod`: Outputs quotes, jokes, sayings, etc.
* `figlet`: Big lettering ascii art
* `neofetch`: Display system information
* `git`: Version System Control
* `git-lfs`: Git Large File Storage
* `npm`: A package manager for the JavaScript programming (for gitmoji)
* `neovim`: A text editor built upon vim
* `gitmoji-cli`: A tool to add emojis to git commit messages
* `Powerline-Shell`: Beautify the bash shell

### ZSH

I currently use `zsh` as my default shell program.

````sh
sudo dnf -y install zsh autojump
sudo usermod -s $(which zsh) $USER      # set it as the default shell for the current user
````

* `autojump`: Quickly jump back to previously visited directories

## Other Applications

* Key-mapper

    Used to map the side buttons on a mouse to ALT+L and ALT+R on the keyboard

    ```bash
    sudo pip install --no-binary :all: git+https://github.com/sezanzeb/ key-mapper.git
    sudo systemctl enable key-mapper
    sudo systemctl restart key-mapper
    ```

* Kitty

    My current favorite terminal emulator, minimal and fast

    ```bash
    sudo dnf -y install kitty
    ```

* Terminator

    My previous terminal emulator

    ```bash
    sudo dnf -y install terminator
    ```

* ULauncher

    An app launcher that I find convenient

    ```bash
    sudo dnf -y install ulauncher
    ```
