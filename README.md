# My Dotfiles

I use `chezmoi` to manage my dotfiles and other configuration files. My current OS is Fedora 36.

Instantly apply this system configuration:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply djinnalexio
```

## Shell Configuration Programs

Here is the list of programs that are referenced in the shell configuration scripts:

```sh
sudo dnf -y install lsd conda cowsay lolcat fortune-mod \
figlet neofetch git git-lfs neovim
git-lfs install
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
* `neovim`: A text editor built upon vim
* `Powerline-Shell`: Beautify the bash shell

### ZSH

I currently use `zsh` as my default shell program.

````sh
sudo dnf -y install zsh autojump
sudo usermod -s $(which zsh) $USER      # set it as the default shell for the current user
````

* `autojump`: Quickly jump back to previously visited directories

## Other Applications

* Input-remapper

    Used to map the side buttons on a mouse to ALT+L and ALT+R on the keyboard

    ```bash
    sudo pip install evdev -U
    sudo pip install --no-binary :all: git+https://github.com/sezanzeb/input-remapper.git
    sudo systemctl enable input-remapper
    sudo systemctl restart input-remapper
    ```

* Kitty
* Terminator

## Chezmoi Configuration Files

Chezmoi supports the template format from Go Extended.
See the guide [here](https://www.chezmoi.io/user-guide/templating/).

### [.chezmoiroot](https://www.chezmoi.io/user-guide/advanced/customize-your-source-directory/)

Placed at the root of the directory, it tells chezmoi which subdirectory to read the source state from.

This way, other files placed at the root but not managed by chezmoi don't need to be included in `.chezmoiignore`.

### [.chezmoi.toml.tmpl](https://www.chezmoi.io/docs/reference/#chezmoiignore)

The file `.chezmoi.<format>.tmpl` is used during `chezmoi init` to generate the configuration file at
`$HOME/.config/chezmoi/chezmoi.<format>` which contains variables entered by the user for this target machine.

Formats: JSON, TOML, YAML

### [.chezmoiignore](https://www.chezmoi.io/user-guide/manage-machine-to-machine-differences/#ignore-files-or-a-directory-on-different-machines)

This file contains a list of files and patterns that chezmoi will not copy to the target system.

By adding if-statements, it is possible to include and exclude files and directories based on the target machine,
user, and other conditions.

### [.chezmoiremove](https://www.chezmoi.io/user-guide/manage-different-types-of-file/#ensure-that-a-target-is-removed)

This file contains a list of files and patterns that chezmoi will delete from the target system.

By adding if-statements, it is possible to include and exclude files and directories based on the target machine,
user, and other conditions.

### [run_once_install-packages.sh.tmpl](https://www.chezmoi.io/user-guide/use-scripts-to-perform-actions/#install-packages-with-scripts)

This file contains commands to install programs when running `chezmoi apply` or `chezmoi update` for the first time. With the `run_once` prefix, the script will not run again unless its contains change.
