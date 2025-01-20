How are you here? This is designed for one of four people, and three of them don't know how to use Nix.


# TO INSTALL:

Step 1: Install NixOS using a graphical installer. For user, put your hostname. Current hosts are yoink, dame, mac, & hamster.
        Choose a temporary password, login automatically, and reuse password for administrator. Select no desktop when prompted.
        Finally, partition the hard drive you're installing NixOS to, with swap but no hibernate.


Step 2: Reboot, removing the installation media.


Step 3: In the terminal prompt you're presented with, run the following:

    export NIX_CONFIG="experimental-features = nix-command flakes"


Step 4: Run:

    nix shell nixpkgs#git --command nix flake clone github:spiritofyoink/dotfiles --dest ~/dotfiles


Step 5: Run the following, replacing <my-system> with the host you chose above. (yoink, dame, mac, or hamster).

    nix shell nixpkgs#git --command sudo nixos-rebuild boot --flake ~/dotfiles#<my-system>


Step 6: Reboot. You should now be in NixOS.