# My Setup Steps for Fedora Gnome

- [My Setup Steps for Fedora Gnome](#my-setup-steps-for-fedora-gnome)
  - [Preparations](#preparations)
    - [Backup](#backup)
    - [Create the OS image](#create-the-os-image)
    - [Check BIOS settings](#check-bios-settings)
  - [Installation](#installation)
  - [Primary Setup](#primary-setup)
    - [Enable `sudo` without password](#enable-sudo-without-password)
    - [Setup DNF](#setup-dnf)
    - [Run dnf update](#run-dnf-update)
    - [Enable RPM fusion repositories](#enable-rpm-fusion-repositories)
    - [Z-shell](#z-shell)
    - [Import Dotfiles](#import-dotfiles)
    - [Fedy](#fedy)
    - [Power Management](#power-management)
    - [Setup Timeshift](#setup-timeshift)
    - [Setup Neovim](#setup-neovim)
    - [Setup Git](#setup-git)
      - [Install **Git Large File Storage**](#install-git-large-file-storage)
      - [Install **Gitmoji**](#install-gitmoji)
      - [Setup ssh keys for remote access](#setup-ssh-keys-for-remote-access)
      - [Setup gpg keys for commit signin](#setup-gpg-keys-for-commit-signin)
    - [Optional](#optional)
    - [Setup Powerline for Bash](#setup-powerline-for-bash)
      - [Nerd Fonts](#nerd-fonts)
  - [Flatpaks](#flatpaks)
    - [My opinion on flatpaks](#my-opinion-on-flatpaks)
    - [Setup Flatpak directory in `home` directory (symlink method)](#setup-flatpak-directory-in-home-directory-symlink-method)
  - [Appimages](#appimages)
    - [App Image launcher](#app-image-launcher)
    - [Appimaghub](#appimaghub)
    - [App outlet](#app-outlet)
  - [Customize the Desktop](#customize-the-desktop)
    - [Customize your Desktop Environments](#customize-your-desktop-environments)
    - [Setup a live wallpaper](#setup-a-live-wallpaper)
    - [Map the mouse side buttons to keyboard](#map-the-mouse-side-buttons-to-keyboard)
  - [Customizing GDM](#customizing-gdm)
    - [Adding a Background Image](#adding-a-background-image)
    - [Adding Monitor Default Settings](#adding-monitor-default-settings)
  - [Everything Else](#everything-else)
    - [Install multimedia codecs](#install-multimedia-codecs)
    - [Optimize Firefox](#optimize-firefox)
    - [Setup Virtualization](#setup-virtualization)
    - [Setup Synology Client](#setup-synology-client)
    - [Setup Anaconda](#setup-anaconda)
    - [Setup Docker](#setup-docker)
    - [Setup Unity Engine](#setup-unity-engine)
      - [UnityHub](#unityhub)
      - [.NET Core](#net-core)
      - [Mono Project](#mono-project)
      - [Visual Studio Code](#visual-studio-code)
      - [Unity Editor Settings](#unity-editor-settings)
      - [Wrap Up](#wrap-up)
    - [Setup Android Debug Bridge (ADB)](#setup-android-debug-bridge-adb)
    - [NVIDIA drivers](#nvidia-drivers)
      - [Daemon error](#daemon-error)
    - [Steam and MangoHub](#steam-and-mangohub)
      - [Setup Logging](#setup-logging)
  - [Cleanup](#cleanup)
  - [Apps to be installed as Flatpaks](#apps-to-be-installed-as-flatpaks)
    - [Graphics \& Media](#graphics--media)
    - [Tools](#tools)
    - [Others](#others)
  - [Apps to be installed with DNF](#apps-to-be-installed-with-dnf)

---

## Preparations

### Backup

Make sure to backup all critical data as the drive will be formatted.

### Create the OS image

Download the latest image from [getfedora.org](https://getfedora.org/) for workstations.

Write the image onto a USB drive with a tool like Rufus or Etcher. You can also use the following line:

```bash
dd if=<path_to>/<image>.iso of=/dev/ status=progress
```

### Check BIOS settings

Check that Secure Boot is disabled and Hyper-V is enabled.

Perform a data wipe so that we don't have to manually delete partitions later.

---

## Installation

[docs.fedoraproject.org](https://docs.fedoraproject.org/)

This table is for a 256GB ssd. We are using the advanced custom GUI tool.

When setting up the partitions:

- create a 500MB EFI partition that will be mounted at /boot/efi
- create a 1GB boot partition in EXT4 format mounted at /boot
- create a 50 GiB BTRFS partition for the root section but do not mount it
- Inside that partition, create a subvolume called "@" and mounted at"/"
- create another BTRFS partition taking up the leftover space for the home partition. Make sure to encrypt it.
- Inside that partition, create a subvolume called "@home" and mounted at "/home"

This setup allows a few things:

- the separate boot and home partitions can be troubleshooted independently or might not be affected by a problem or
corruption in the other partition.
- by having the home directory on its exclusive partition, it is possible to reinstall the OS or change distribution
in the root partition without affecting the home folder and having to backup the data.

---

## Primary Setup

**Upon reboot, go into the BIOS again to re-enable Secure Boot.**

### Enable `sudo` without password

Give the user the right to use the sudo command without having to enter the password:

```bash
sudo visudo
```

Near the bottom of the file, uncomment the line

```bash
#%wheel  ALL=(ALL)       NOPASSWD: ALL
```

### Setup DNF

Add the following lines to the dnf configuration file at `/etc/dnf/dnf.conf`:

```bash
fastestmirror=1
max_parallel_downloads=10
defaultyes=yes
```

### Run dnf update

Upgrade all packages with:

```bash
sudo dnf -y update --refresh
```

### Enable RPM fusion repositories

You can do so either through Gnome Software or with the following command:

```bash
sudo dnf -y install \
https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y update --refresh
```

### Z-shell

We will use `zsh` as our default shell. It provides a lot more features than `bash`. First install it with:

```bash
sudo dnf -y install zsh
```

Next, change your default shell:

```bash
sudo usermod -s $(which zsh) $USER
```

### Import Dotfiles

Use `chezmoi` to bring all configuration dotfiles from the remote repository:

```bash
sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply djinnalexio
```

Install programs referenced in the dotfiles:

```bash
sudo dnf -y install \
neovim bash-completion tldr pydf fortune-mod cowsay figlet lolcat lsd ranger bpytop autojump kitty
```

### Fedy

Fedy keeps all software and drivers that are commonly installed in one place. it makes it easy to quickly find and install most of the programs that we would want.

[**Install here.**](https://github.com/rpmfusion-infra/fedy)

### Power Management

Install and enable utilities to improve battery consumption and/or performance.

```bash
sudo dnf -y install tlp tuned tuned-gtk tuned-switcher
sudo systemctl enable tlp tuned
sudo systemctl start tlp tuned
```

### Setup Timeshift

Install Timeshift and run the GUI to set it up.

```bash
sudo dnf -y install timeshift
```

### Setup Neovim

After neovim was installed, intall `vim-plug`:

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

#### Install **Gitmoji**

You can add emojis to your commit messages to indicate the type of changes and look smarter than you
actually are.

```bash
sudo dnf -y install npm
npm i -g gitmoji-cli
```

Gitmoji is a command line tool. You can start the client with the following command:

```bash
gitmoji -c
```

When in a git repository, you can create a **hook** to enable gitmoji to be used automatically when
creating a commit:

```bash
gitmoji --init
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

### Optional

You can create symbolic links in the root directory to those files in order to use the same settings for the
user and superuser.

### Setup Powerline for Bash

Powerline is a fancy prompt generator.

The recommended installation method for the one made specifically for shells is `pip`. Install it as root to
make it accessible to all users:

```bash
sudo pip3 install powerline-shell
```

The configuration files should be applied immediately. If not, re-import them with `chezmoi`. If they are
not set up, follow those [instructions](https://github.com/b-ryan/powerline-shell) to do so.

#### Nerd Fonts

Nerd fonts are patched with a high number glyphs used by powerline. Find them at [nerdfonts.com](https://www.nerdfonts.com/)
and install them with a GUI tool or through the command line. Then, set them in your terminal emulator.

---

## Flatpaks

### My opinion on flatpaks

Pros:

- sandboxing (programs do not depend on dependencies from the system)
- up-to-date (they tend to receive updates faster than distro packages)

Cons:

- large downloads (each flatpak installs its dependencies which wastes space)
- theming (they may not always match the desktop theme)

Personally, I choose flatpaks as my default format for GUI applications. I will use dnf for applications that:

- are used manly in terminal
- benefit more from system integration than sandboxing

### Setup Flatpak directory in `home` directory (symlink method)

[original explanation](https://github.com/flatpak/flatpak/issues/2337)

Move the system-wide flatpak installation folder to my `home` directory, and create a symlink in its original location:

```bash
sudo mv /var/lib/flatpak $HOME/.flatpak
sudo ln -s $HOME/.flatpak  /var/lib/flatpak
```

Flatpaks can quickly take a lot of space on the disk. So, I use this hack to have them located in my bigger home partition.

Compared to using the command line with the `--user` flag, or adding an installation location in flatpak settings that
would still require a flag pointing to the location, the symlink method is quick, easy, and allows Gnome Software to work
exactly the same. The only difference behind the scenes is that packages are actually stored in a folder on the home partition.

Another advantage is that since the flatpak folder is on the home partition, programs can be preserved after loss of the root
partition and OS re-installation as long as the home partition is safe.

---

## Appimages

There are a few applications that help to manage appimages. Make sure to create an `Applications` folder in the home directory
to store appimages.

### App Image launcher

A program that integrates appimages by moving them into the `Applications` folder and creating the `.desktop` file to make
them accessible through the AppMenu.

Download the latest `lite` version [here](https://github.com/TheAssassin/AppImageLauncher/releases), then run it.

```bash
chmod u+x ~/Downloads/appimagelauncher-lite*.AppImage
~/Downloads/appimagelauncher-lite*.AppImage
```

### [Appimaghub](https://www.appimagehub.com)

A website that lists a lot of appimages.

### [App outlet](https://github.com/app-outlet/app-outlet/releases)

A graphical app store for snaps, flatpaks, and appimages.

---

## Customize the Desktop

### Customize your Desktop Environments

Go through the following settings:

- hostname
- settings
- set themes
- background
- gnome-tweaks
- gnome extensions
- fonts
- night color (protect your eyes at night and improving your sleep.)
- default apps

### Setup a live wallpaper

There doesn't seem to be a standard way of setting live wallpapers. Most of the programs I found were either obsolete,
or not available for Fedora.

The solution I settled on consists of 2 Github projects, the script that runs the live wallpaper, and a helper program
that uses `youtube-dl` to download live wallpapers, `ffmpeg` to create static backgrounds used by the desktop.

The helper script provides a GUI to create, start and stop new live wallpapers,and enable them on startup.

The original scripts and programs come from:

- [Animated wallpaper program](https://github.com/Truemmerer/animated_wallpaper_helper)
- [Animated wallpaper helper](https://github.com/Ninlives/animated-wallpaper)

I then rewrote a few things from my needs. Also note that while it works as expected on Xorg, in Wayland, the video behaves
as a window affected by the window manager instead of staying stuck to the desktop.

I found another live wallpaper utility made for Wayland, but this one does not work for me. The videos do not fit the
screens properly.

- [hidamari](https://github.com/jeffshee/hidamari)

### Map the mouse side buttons to keyboard

I want to use the `forward` and `backward` buttons on the side of a mouse without using a mouse. So, I map them to keyboard.

Run the following lines to install `key-mapper`:

```bash
sudo pip install evdev -U  # If newest version not in distros repo
sudo pip install --no-binary :all: git+https://github.com/sezanzeb/input-remapper.git
sudo systemctl enable input-remapper
sudo systemctl restart input-remapper
```

In case an error occur due to `gcc` during installation, run the following command, then try again:

```bash
sudo dnf -y install python3-devel
```

---

## Customizing GDM

GDM is the display/login manager of Gnome. Customizing GDM is more complicated than with other display managers as it currently
doesn't have a tool or GUI to do so. Moreover, manual changes involve compiling or updating a database, but it is relatively easy.

Find the complete guide [here](https://wiki.archlinux.org/title/GDM).

> Be very careful as breaking the login manager can prevent you from access your desktop environment.

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

## Everything Else

### Install multimedia codecs

Install media and audio plugins to help with playing multimedia, movies, music, etc.

```bash
sudo dnf -y groupupdate multimedia --setop="install_weak_deps=False" \
--exclude=PackageKit-gstreamer-plugin
sudo dnf -y groupupdate sound-and-video
```

### Optimize Firefox

In the browser, pass the following commands to enable hardware acceleration:

`about:config` in the search bar. Then:

```bash
layers.acceleration.force-enabled
gfx.webrender.all
```

### Setup Virtualization

[fedoraproject.org: Virtualization Guide](https://docs.fedoraproject.org/en-US/quick-docs/getting-started-with-virtualization/)

KVM is a system of virtualization that offers a lot more control over the virtual machine and allows GPU passthrough.

```bash
sudo dnf -y group install virtualization --with-optional
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
sudo usermod -a -G libvirt $(whoami)
```

### Setup Synology Client

I could not find an `appimage` or `rpm` package of the client. Instead, I used this script
[here](https://gist.github.com/JochemKuijpers/aa8977ddec53967e86f8e09559d8798a) to install the client from a `.deb`
package found [here](https://archive.synology.cn/download/Utility/SynologyDriveClient)
.

Place the script and the package in the same directory and run the script as `sudo`.

**Synology Drive** should now be accessible in the App Menu. Go through the initialization and setup.

Finally, clean up by deleting the script, `.deb` package, and `synology-drive` folder in the current directory.

### Setup Anaconda

Anaconda is a package manager, environment manager, and Python distribution used for data science and machine learning.

To install it, follow these [instructions](https://docs.anaconda.com/anaconda/install/linux/).

- Use `$HOME/.anaconda3` as the install location
- Find an icon and create a `.desktop` file for `anaconda-navigator`.

### Setup Docker

Docker is an open platform for developing, shipping, and running applications. Follow the instructions
[here](https://docs.docker.com/engine/install/fedora/) to install it on Fedora.

### Setup Unity Engine

#### UnityHub

Install the UnityHub to manage the projects and editors. Find the `AppImage` on the official
[website](https://unity.com/).

On UnityHub, login into your account, activate the license, setup default locations, and download the latest editor with
the necessary modules.

#### .NET Core

We need to install the `.NET` SDK (Check which SDK is the recommended one for Unity):

```bash
sudo dnf -y install dotnet-sdk-5.0 dotnet-sdk-3.1
```

You can check that the packages were installed successfully with `dotnet --info`.

#### Mono Project

Next is the mono project that basically allows us to use the `.NET` framework on Linux with Unity. You can find instructions
[here](https://www.mono-project.com/download/stable/#download-lin-fedora).

#### Visual Studio Code

My preferred text editor to use with Unity on Linux.

You can find instructions to download the `rpm`
[here](https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions).

The Flatpak would not be suited since we need access to the frameworks installed on the system.

Then, install the `C# extension`, the `Unity Debugger`, and other relevant extensions.

#### Unity Editor Settings

Go to **Preferences > External Tools** and set the script editor to VScode (the program binary should be `/usr/bin/code`).

Under **Project Settings > Player > Other Settings > Rendering**, disable *Auto Graphics API* and set it to Vulckan.

#### Wrap Up

Now when accessing the C# project from the engine into VScode, `omnisharp` should be able to load all of the solution
files. Also check:

- that the count of references of methods and variables is visible and shows where it the project each item is called
- that unused packages are displayed in a darker shade.
- that autocomplete for Unity-specific packages works as expected.

Make sure that projects can be compiled for all desired platforms.

### Setup Android Debug Bridge (ADB)

The toolkit mostly used to root into phones.

Download the lastest toolkit [here](https://dl.google.com/android/repository/platform-tools-latest-linux.zip).

Extract it and `cd` into `platform-tools` to use the commands.

---

### NVIDIA drivers

> I am currently using a MUXless Optimus laptop: I have an Intel integreted GPU and a discrete NVIDIA GPU.
The dGPU is not directly connected to the monitor, but to the iGPU instead. When the power of the dGPU is
needed for graphical applications, it sends rendered frames to the iGPU which then displays them on screen.

Sources:

- [rpmfusion.org/Howto/NVIDIA](https://rpmfusion.org/Howto/NVIDIA)
- [rpmfusion.org/Howto/Optimus](https://rpmfusion.org/Howto/Optimus)
- [README/primerenderoffload](https://download.nvidia.com/XFree86/Linux-x86_64/440.31/README/primerenderoffload.html)

What works for me is [**System76**](https://copr.fedorainfracloud.org/coprs/szydell/system76/) to set the mode of operation of my dGPU and [**Negativo17**](https://negativo17.org/nvidia-driver/) Nvidia drivers.

1. Uninstall `nouveau` drivers. They are simply not as good as the proprietary drivers from NVIDIA.

2. Install `nvidia` drivers from Negativo17

    ```bash
    sudo dnf config-manager --add-repo=https://negativo17.org/repos/fedora-nvidia.repo
    sudo dnf remove *nvidia*
    dnf -y install nvidia-driver nvidia-driver-cuda nvidia-settings nvidia-driver-libs
    ```

    Make sure to wait at least 5 minutes after installation for the modules to be fully ready.

3. Edit the grub config file

    Open `/etc/default/grub` as root and add the following to `GRUB_CMDLINE_LINUX`:

    ```bash
    GRUB_CMDLINE_LINUX="rhgb quiet rd.driver.blacklist=nouveau nvidia-drm.modeset=1"
    ```

    Then update `grub`

    ```bash
    grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg # for UEFI
    grub2-mkconfig -o /boot/grub2/grub.cfg # for BIOS
    ```

4. Install and setup system76 power management:

    ```bash
    sudo dnf copr enable szydell/system76
    sudo dnf install system76-dkms system76-power system76-driver system76-firmware firmware-manager system76-io-dkms system76-acpi-dkms
    sudo systemctl enable system76-power system76-power-wake system76-firmware-daemon
    sudo systemctl start system76-power system76-firmware-daemon
    systemctl enable --user com.system76.FirmwareManager.Notify.timer
    system76-power graphics integrated
    ```

5. Reboot

    - Changes are applied upon reboot.

    - `system76-power graphics help` shows the modes available.

#### Daemon error

If using `system76-power` returns "`daemon returned an error message: "The name is not activatable"`", try restarting the daemon:

```bash
sudo systemctl restart system76-power system76-firmware-daemon
```

### Steam and MangoHub

Start playing games through `flatpak` **Steam** with a HUD (Heads-Up Display) for FPS.

1. Install Steam through the store.

2. Install `mangohud`, the HUD software:

    ```bash
    sudo dnf -y install mangohud
    ```

3. Use the following line to allow `flatpak` **Steam** to access the configuration file in the home directory in read-only mode:

    ```bash
    flatpak override --user --filesystem=xdg-config/MangoHud:ro com.valvesoftware.Steam
    ```

4. To enable `mangohub` for a game, go to the settings page of that game, and in `Launch options`, enter:

    ```bash
    mangohud %command%
    ```

    Or if it does not work, also try:

    ```bash
    MANGOHUD=1 %command%
    ```

5. Optionally, if MangoHub is not already configured, Install  `goverlay`, a GUI to do so:

    ```bash
    sudo dnf -y install goverlay
    ```

#### Setup Logging

MangoHub can create logs of the data about sessions and save it in .csv files.

1. If it is not already done with Goverlay, edit the config file to set a location MangoHub can save logs to:

    ```bash
    echo "output_folder=$XDG_DATA_HOME/MangoHud" >> $XDG_CONFIG_HOME/MangoHud/MangoHud.conf
    ## adds to the file the output_folder variable set to `/home/<user>/.local/share/MangoHud`
    ```

2. Use the following line to allow `flatpak` **Steam** to access the log folder in read/write mode:

    ```bash
    flatpak override --user --filesystem=xdg-data/MangoHud:create com.valvesoftware.Steam
    ```

---

## Cleanup

After everything is done, we can use `bleachbit` to get rid of all the unnecessary data we accumulated.

Install it and run it as `sudo`:

```bash
sudo dnf -y install bleachbit
sudo bleachbit
```

---

## Apps to be installed as Flatpaks

### Graphics & Media

- audacity
- ardour
- Blender
- darktable
- Gimp
- Kdenlive
- Kodi
- Krita
- OBS Studio
- Spotify
- VLC

### Tools

- Anydesk
- Chromium
- Dconf-editor
- Joplin
- KeepassXC
- LibreOffice
- Okular
- Xournal++
- youtubedl-gui
- Zoom

### Others

- Discord
- Exodus
- Steam

## Apps to be installed with DNF

- terminator | kitty
- bpytop
- cmatrix
- Dnfdragora
- firewall-applet
- htop
- Lshw
- nmap
- lutris
- Stacer
- Ranger
- thunderbird
- ulauncher
- unzip
- youtube-dl

TODO: update this file
