*How are you here? This is designed for one of four people, and three of them don't know Nix from Nil.*


![Image](nixos-configuration-map.jpg?raw=true)

## TO INSTALL:

* Step 1: Install NixOS using a graphical installer.
  * For name and username, select from: yoink, dame, mac, & hamster. This will be your ``` <user> ``` in step 6.
  * Choose a temporary password, and check both 'login automatically,' and 'reuse password for administrator.'
  * Select 'no desktop' when prompted.
  * Finally, partition the hard drive you're installing NixOS to, selecting the 'swap but no hibernate' option.


* Step 2: Reboot, removing the installation media.


* Step 3: In the terminal prompt you're presented with, run the following:
 
    ``` export NIX_CONFIG="experimental-features = nix-command flakes" ```


* Step 4: Run:
 
    ``` nix shell nixpkgs#git --command nix flake clone github:spiritofyoink/dotfiles --dest ~/dotfiles ```


* Step 5: Run:
 
     ``` sudo mv /etc/nixos/hardware-configuration.nix /home/<host>/dotfiles/hosts/<host>/hardware-configuration.nix ```


* Step 6: Run the following, replacing ```<user>``` with the user you selected in step one. (yoink, dame, mac, or hamster)
 
     ``` nix shell nixpkgs#git --command sudo nixos-rebuild boot --flake '/home/<user>/dotfiles#<user>' ```

> [!IMPORTANT]
> Don't forget the closing apostrphe!


* Step 7: Reboot. You should now be in NixOS.


> [!NOTE]
> From now on, you simply need to use 'rebuild' to rebuild and switch the system configuration.


If you're debugging, include the following lines in /etc/nixos/configuration.nix

    programs.git.enable = true;
    nix.settings.experimental-features = "nix-command flakes";
