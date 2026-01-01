## Installing on a new machine

### 1. Install NixOS

1. Idk go follow a guide online or something. I like to choose no desktop environment, but that doesn't really matter.

### 2. Clone this repository

1. Make sure the machine is connected to the internet.

2. If git is not already installed, run `nix-shell -p git`.

3. Clone the repo. I typically clone it to `~/.dotfiles`.

### 3. Build your configuration

#### If making a new host configuration:

1. **IMPORTANT:** Pick a cool hostname.

2. Copy `hosts/template/*` into `hosts/<HOSTNAME>/`

3. Customize the configuration. This is optional for now, the template config should have enough to make it through install.

4. Copy `/etc/nixos/hardware-configuration.nix` into your host directory.

#### If using an existing host configuration:

1. Just copy `/etc/nixos/hardware-configuration.nix` into `hosts/<HOSTNAME>/`.

### 4. Rebuild the system

1. Rebuild the system:

    ```shell
    sudo nixos-rebuild switch --flake .#HOSTNAME
    ```

    The dot (`.`) is the path to wherever `flake.nix` is, and `HOSTNAME` is your hostname.

2. Build home manager:

    ```shell
    home-manager switch --flake .#HOSTNAME
    ```

### 5. Reboot

1. Reboot the system.

2. That's it! Start configuring to your heart's content!

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

    -   See [Resizing the Boot Partition](./DualBoot.md#resizing-the-boot-partition).
