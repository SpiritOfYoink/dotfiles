How are you here? This is designed for one of four people, and three of them don't know how to use Nix.


# TO INSTALL:

Step 1: Install NixOS using a graphical installer. Select no desktop when prompted.


Step 2: Run the following command in the terminal:

    sudo nix shell nixpkgs#git --extra-experimental-features "nix-command flakes"

Step 3: Next, run:

    sudo mkdir /home/dotfiles && sudo chown 760 /home/dotfiles && cd /home/dotfiles


Step 4: Run the following terminal command, replacing <my-system> with your user or host. Current hosts are yoink, dame, mac, & hamster.

    git clone github:spiritofyoink/dotfiles#<my-system>


Step 5: Run:

    sudo nixos-rebuild switch --flake

Step 5: Reboot.


Note: from then on, you simply need to use 'rebuild' to rebuild and switch the system configuration.