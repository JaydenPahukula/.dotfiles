# Dual Boot

I often dual boot my machines with Windows to get the best of both worlds. Here are some considerations when dual booting using my configs.

## Boot Order

If you want to boot to NixOS by default (but it is defaulting to Windows), run

```shell
efibootmgr
```

This displays the current boot order. Here is an example of modifying the boot order:

```shell
efibootmgr -o 0000,0001,...
```

## Resizing the Boot Partition

Because NixOS generates many different kernels, the boot partition can run out of space quickly. This especially happens when dual booting with Windows, since Windows creates a very small boot partition.

[This guide](https://drakerossman.com/blog/how-to-dualboot-windows-and-nixos#increasing-boot-partition-size) gives great instructions on how to resize the boot partition size, but I've also typed out the instructions for posterity.

### 1. Open GParted

Since you are going to be messing with partitions, this cannot be done from inside NixOS. There are many ways to do this, but here is one option:

1. Boot from the NixOS graphical installer. Either GNOME or Plasma works.

2. Open GParted

### 2. Rearrange Partitions

1. In GParted, resize and move partitions so that your boot partition has enough space.

2. Sometimes it might fail to resize the fat32 boot partition. In that case, you need to open up a terminal and do the following:

    - Back up your boot partition:

        ```shell
        mkdir /tmp/backup-boot
        mkdir /mnt/actual-boot

        mount /dev/nvme0n1p1 /mnt/actual-boot

        cp -r /mnt/actual-boot /tmp/backup-boot

        umount /mnt/actual-boot
        ```

    - Go back into GParted and create your boot partition. It should be the primary partition, use fat32 file system, and have three flags: `boot`, `esp`, and `no_automount`.

    - Copy files back to the boot partition:

        ```shell
        mount /dev/nvme0n1p1 /mnt/actual-boot

        cp -r /tmp/backup-boot /mnt/actual-boot

        umount /mnt/actual-boot
        ```

### 3. Reboot

Once you reboot, you should be done!
