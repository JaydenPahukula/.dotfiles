## Installing on a new machine

### 1. Install NixOS

1. Idk go follow a guide online or something. I like to choose no desktop environment, but that doesn't really matter.

### 2. Clone this repository

1. Make sure the machine is connected to the internet.

2. If git is not already installed, run `nix-shell -p git`.

3. Clone the repo:

    ```shell
    git clone https://github.com/JaydenPahukula/.dotfiles.git
    ```

    I typically clone it to `~/.dotfiles`, which is the default if you run this command from the home directory.

### 3. Build your configuration

#### If you are making a new host configuration:

1. Copy `hosts/template/*` into `hosts/<HOSTNAME>/`, where `<HOSTNAME>` is your new hostname. I hope you picked a cool name!

2. Customize the configuration. This is optional for new, the template config has enough to make it through install.

3. Copy `/etc/nixos/hardware-configuration.nix` into your host directory.

#### If using an existing host configuration:

1. All you need to do is copy `/etc/nixos/hardware-configuration.nix` into `hosts/<HOSTNAME>/`.

### 4. Rebuild the system

1. Rebuild the system:

    ```shell
    nixos-rebuild switch --flake .#HOSTNAME
    ```

    `HOSTNAME` is your config hostname, and the dot (`.`) is the path to this repo (or wherever `flake.nix` is).

2. Build home manager:

    ```shell
    home-manager switch --flake .#HOSTNAME
    ```

### 5. Reboot

1. Reboot the system by running:

    ```shell
    restart
    ```

2. Once the system reboots, you are done! Start configuring to your heart's content!

### Post Install

Here are some things that are probably a good idea to do after install:

1. Authenticate with git.

### Debugging

Some issues I've run into before:

-   When running the installer, a message appears saying: "shim_lock protocol not found".

    -   Turn off secure boot in the BIOS.

-   The `nixos-rebuild` command fails.

    -   Did you copy `/etc/nixos/hardware-configuration.nix` into your host directory?

-   The `nixos-rebuild` command fails, and spews some garbage about systemd boot loading and efi stuff.

    -   Try deleting `/boot/EFI/systemd/systemd-bootx64.efi` and `/boot/EFI/Boot/bootx64.efi`, then rebuilding again.

-   The boot partition is full

    -   See [docs/ResizeBootPartitions.md](docs/ResizeBootPartition.md).
