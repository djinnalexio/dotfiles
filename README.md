# My Dotfiles

I use `chezmoi` to manage my dotfiles and other configuration files. My current OS is Fedora 36.

Instantly apply this system configuration:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin init --apply djinnalexio
```

## Shell Configuration Programs

Here is the list of programs that are referenced in the shell configuration scripts:

* `autojump`: Quickly jump back to previously visited directories
* `lsd`: An improved `ls` command that includes colors and file icons
* `kitty`: the terminal I like
* `neofetch`: Display system information
* `git-lfs`: Git Large File Storage
* `neovim`: A text editor built upon vim
* `zsh`: the shell I use

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

This file contains commands to run commands when running `chezmoi apply` or `chezmoi update` for the first time. With the `run_once` prefix, the script will not run again unless its contains change.
