How are you here? This is designed for one of four people, and three of them don't know how to use Nix.


# TO INSTALL:

Step one: Install NixOS using a graphical installer. Select no GUI when prompted.

Step two: Run the following terminal command, replacing <my-system> with your user or host. Current hosts are yoink, dame, mac, & hamster.

        sudo nixos-rebuild switch --flake github:SpiritOfYoink/dotfiles#<my-system>


Note: from then on, you simply need to use 'rebuild' to rebuild and switch the system configuration.