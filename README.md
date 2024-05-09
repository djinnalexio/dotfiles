# My Dotfiles

I use `chezmoi` to manage my dotfiles and other configuration files. My current main OS is Fedora Silverblue.

Instantly apply this system configuration:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin init --apply djinnalexio
```

## Shell Configuration Programs

Here some of the programs that are installed by the shell configuration scripts:

* `autojump`: Quickly jump back to previously visited directories
* `cmatrix`: to jump into the matrix
* `distrobox`: to create containers in immutable systems
* `pywal16`: create terminal color schemes from wallpapers
* `fastfetch`: Display system information
* `kitty`: the terminal I like
* `lsd`: An improved `ls` command that includes colors and file icons
* `neovim`: A text editor built upon vim
* `tldr`: short, highlighted man pages with examples
* `zsh`: the shell I use

## Chezmoi Configuration Files

Chezmoi supports the template format from Go Extended.
See the guide [here](https://www.chezmoi.io/user-guide/templating/).

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

### [.chezmoiroot](https://www.chezmoi.io/user-guide/advanced/customize-your-source-directory/)

Placed at the root of the directory, it tells chezmoi which subdirectory to read the source state from.

This way, other files placed at the root but not managed by chezmoi don't need to be included in `.chezmoiignore`.

### [.chezmoiscripts](https://www.chezmoi.io/reference/special-files-and-directories/chezmoiscripts/)

This folder contains scripts that will be run alongside chezmoi. it will not be copied to the target system.

It is best practice to make sure that scripts used with `chezmoi` are idempotent (that running them repeatedly will not change the results).

>Scripts will normally run with their working directory set to their equivalent location in the destination directory.
>If the equivalent location in the destination directory either does not exist or is not a directory, then chezmoi will walk up the script's directory hierarchy and run the script in the first directory that exists and is a directory.

### [run_once_*.sh](https://www.chezmoi.io/user-guide/use-scripts-to-perform-actions/#install-packages-with-scripts)

These scripts contain commands to run commands when running `chezmoi apply` for the first time. There is also the `run_on_change_` prefix which sets the script to run again each time its contains change.

They can be set to run again resetting the state with `chezmoi state reset`.

You can even specify if you want the scripts to run before or after `chezmoi` has applied the dotfiles with the prefixes `before_` and `after_` (e.g. `run_once_before_<>.sh`)
