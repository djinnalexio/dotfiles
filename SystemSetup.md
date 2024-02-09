# Software Setup Notes for Gnome

- [Software Setup Notes for Gnome](#software-setup-notes-for-gnome)
  - [Primary Setup](#primary-setup)
    - [Z-shell](#z-shell)
    - [Import Dotfiles](#import-dotfiles)
    - [Setup Neovim](#setup-neovim)
    - [Setup Git](#setup-git)
      - [Install **Git Large File Storage**](#install-git-large-file-storage)
      - [Setup ssh keys for remote access](#setup-ssh-keys-for-remote-access)
      - [Setup gpg keys for commit signin](#setup-gpg-keys-for-commit-signin)
      - [Nerd Fonts](#nerd-fonts)
    - [Setup Synology Client](#setup-synology-client)
  - [Customize the Desktop](#customize-the-desktop)
    - [Adding a Background Image](#adding-a-background-image)
    - [Adding Monitor Default Settings](#adding-monitor-default-settings)
  - [Silverblue Setup](#silverblue-setup)  
    - [Enable fractional scaling](###enable-fractional-scaling)
    - [Configure ostree](#configure-ostree)
    - [Install packages to the base](#install-packages-to-the-base)
    - [Enable flathub repository](#enable-flathub-repository)
    - [Setup a distrobox](#setup-a-distrobox)

---

## Primary Setup

### Z-shell

We will use `zsh` as our default shell. It provides a lot more features than `bash`. First install it with:

```bash
sudo dnf -y install zsh
```

Next, change your default shell:

```bash
sudo usermod -s $(command -v zsh) $USER
```

### Import Dotfiles

Use `chezmoi` to bring all configuration dotfiles from the remote repository:

```bash
sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply djinnalexio
```

Install programs referenced in the dotfiles:

```bash
sudo dnf -y install \
neovim tldr pydf fortune-mod cowsay figlet lolcat lsd ranger bpytop autojump kitty
```

### Setup Neovim

After neovim was installed, install `vim-plug`:

```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Then, if the configuration file was imported with chezmoi, open neovim and run `:PlugInstall` to
install the plugins.

### Setup Git

#### Install **Git Large File Storage**

```bash
sudo dnf -y install git git-lfs
git-lfs install
```

#### Setup ssh keys for remote access

Create a new key pair:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Start the ssh agent in the background:

```bash
eval "$(ssh-agent -s)"
```

Add your new key to the ssh agent:

```bash
ssh-add <key>
```

On the website, paste the contents of the `.pub` file.

#### Setup gpg keys for commit signin

Create an new GPG key of type `RSA and RSA, 4096 bits`:

```bash
gpg --full-generate-key
```

After the key has been created, list your keys to copy the key ID:

```bash
gpg --list-secret-keys --keyid-format=long
```

The key ID you need will be on the line with `sec`. Copy it and show the public key:

```bash
gpg --armor --export <key>
```

Copy your GPG key from `-----BEGIN PGP PUBLIC KEY BLOCK-----` to `-----END PGP PUBLIC KEY BLOCK-----`.

Paste the contents on the website.

#### Nerd Fonts

Nerd fonts are patched with a high number glyphs used by powerline. Find them at [nerdfonts.com](https://www.nerdfonts.com/)
and install them with a GUI tool or through the command line. Then, set them in your terminal emulator.

### Setup Synology Client

I could not find an `appimage` or `rpm` package of the client. Instead, I used this script
[here](https://gist.github.com/JochemKuijpers/aa8977ddec53967e86f8e09559d8798a) to install the client from a `.deb`
package found [here](https://archive.synology.cn/download/Utility/SynologyDriveClient)
.

Place the script and the package in the same directory and run the script as `sudo`.

**Synology Drive** should now be accessible in the App Menu. Go through the initialization and setup.

Finally, clean up by deleting the script, `.deb` package, and `synology-drive` folder in the current directory.

---

## Customize the Desktop

### Adding a Background Image

1. Extract the current GDM theme into a directory by creating and running the following script:

    `extractgst.sh`:

    ```bash
    #!/bin/sh
    gst=/usr/share/gnome-shell/gnome-shell-theme.gresource
    workdir=${HOME}/shell-theme

    for r in `gresource list $gst`; do
        r=${r#\/org\/gnome\/shell/}
        if [ ! -d $workdir/${r%/*} ]; then
        mkdir -p $workdir/${r%/*}
        fi
    done

    for r in `gresource list $gst`; do
            gresource extract $gst $r >$workdir/${r#\/org\/gnome\/shell/}
    done
    ```

2. The location should be `~/shell-theme/theme/`. Copy the image you want to set as background into the directory.
*I recommend renaming it something generic like `background.png`. If in the future, you replace the picture but*
*the filename stays the same, you will then only need to re-compile the theme without having to edit the other files.*

3. Create the following file in the directory:

    `gnome-shell-theme.gresource.xml`:

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
        <gresources>
            <gresource prefix="/org/gnome/shell/theme">
            <file>calendar-today.svg</file>
            <file>calendar-today-light.svg</file>
            <file>checkbox.svg</file>
            <file>checkbox-focused.svg</file>
            <file>checkbox-off-focused-light.svg</file>
            <file>checkbox-off-focused.svg</file>
            <file>checkbox-off-light.svg</file>
            <file>checkbox-off.svg</file>
            <file>gnome-shell.css</file>
            <file>gnome-shell-high-contrast.css</file>
            <file>gnome-shell-start.svg</file>
            <file>pad-osd.css</file>
            <file>process-working.svg</file>
            <file>toggle-off.svg</file>
            <file>toggle-off-hc.svg</file>
            <file>toggle-off-light.svg</file>
            <file>toggle-on.svg</file>
            <file>toggle-on-hc.svg</file>
            <file>toggle-on-light.svg</file>
            <file>workspace-placeholder.svg</file>
            <file>background.png</file>
        </gresource>
    </gresources>
    ```

    Make sure the last file of the list matches with the name of the picture.

4. Open the `gnome-shell.css` file, find and edit the `#lockDialogGroup` section:

    ```css
    #lockDialogGroup {
    background: url(background.png);
        background-size: 1920px 1080px;
        background-repeat: no-repeat; }
    ```

   Make sure the filename matches and you have the desired resolution. Regarding `background-repeat`, see
   [here](https://developer.mozilla.org/en-US/docs/Web/CSS/background-repeat).

5. Compile the theme using the following command:

    ```bash
    glib-compile-resources gnome-shell-theme.gresource.xml
    ```

6. Copy your compiled theme to `/usr/share/gnome-shell`. You might want to preserve the current one just in case.

    ```bash
    sudo cp -v /usr/share/gnome-shell/gnome-shell-theme.gresource /usr/share/gnome-shell/gnome-shell-theme.gresource.original
    sudo cp -v gnome-shell-theme.gresource /usr/share/gnome-shell/gnome-shell-theme.gresource
    ```

7. Finally, restart GDM. You will be logged out during the process.

    ```bash
    sudo systemctl restart gdm.service
    ```

### Adding Monitor Default Settings

It is possible to have GDM follow the monitor setup that is defined by the user.

```bash
cp ~/.config/monitors.xml /var/lib/gdm/.config/
chown gdm:gdm /var/lib/gdm/.config/monitors.xml
```

Logout and check the changes.

---

## Silverblue Setup

### Enable fractional scaling

run:

```bash
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
```

Reboot

### Configure ostree

run `sudo vi /etc/rpm-ostreed.conf` and change the options to the following:

```text
[Daemon]
AutomaticUpdatePolicy=stage
IdleExitTimeout=60
```

Reload `ostree` and enable the automatic timer:

```bash
rpm-ostree reload
systemctl enable rpm-ostreed-automatic.timer --now
```

### Install packages to the base

Enable NVIDIA repositories:

```bash
rpm-ostree install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
```

Upgrade the system:

```bash
rpm-ostree upgrade
```

Install layered packages:

```bash
rpm-ostree install distrobox git-lfs kitty neofetch neovim zsh
rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-cuda
# After installing nvidia drivers, blacklist nouveau drivers
rpm-ostree kargs --append=rd.driver.blacklist=nouveau --append=modprobe.blacklist=nouveau --append=nvidia-drm.modeset=1
rpm-ostree status -v
```

Switch the default shell from `bash` to `zsh`:

```bash
sudo vi /etc/passwd
# and at the end of the line of your user, change bash to zsh
```

### Enable flathub repository

```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update --appstream
flatpak update
```

Reboot the system

### Setup a distrobox

Create a box:

```bash
distrobox create --image fedora:38 --name <name>
distrobox enter <name>
```

Inside the box, run `chezmoi`:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin init --apply djinnalexio
```

You can use `chezmoi init` later to update the variables and `chezmoi update` to pull changes from github.
