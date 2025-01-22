*How are you here? This is designed for one of four people, and three of them don't know how to use Nix.*


![Image](nixos-configuration-map.jpg?raw=true)

## TO INSTALL:

Step 1: Install NixOS using a graphical installer. For user, put your hostname. Current hosts are yoink, dame, mac, & hamster.
        Choose a temporary password, login automatically, and reuse password for administrator. Select no desktop when prompted.
        Finally, partition the hard drive you're installing NixOS to, with swap but no hibernate.


Step 2: Reboot, removing the installation media.


Step 3: In the terminal prompt you're presented with, run the following:
    export NIX_CONFIG="experimental-features = nix-command flakes"


Step 4: Run:
    nix shell nixpkgs#git --command nix flake clone github:spiritofyoink/dotfiles --dest ~/dotfiles


Step 5: Run:
    sudo mv /etc/nixos/hardware-configuration.nix /home/<host>/dotfiles/hosts/<host>/hardware-configuration.nix


Step 6: Run the following, replacing <host> with the host you chose above. (yoink, dame, mac, or hamster).
    nix shell nixpkgs#git --command sudo nixos-rebuild boot --flake '/home/<host>/dotfiles#<host>'

Note: Don't forget the closing apostrphe.



Step 7: Reboot. You should now be in NixOS.

Note: from now on, you simply need to use 'rebuild' to rebuild and switch the system configuration. If this is still in testing and the flake hasn't loaded, use: sudo nixos-rebuild switch --flake '/home/<user>/dotfiles#<user>'






Note: if you're debugging, include the following lines in /etc/nixos/configuration.nix

    programs.git.enable = true;
    nix.settings.experimental-features = "nix-command flakes";

Note: If you need to refresh the evaluation cache, run sudo rm -rf / <location of nixos tarball>
