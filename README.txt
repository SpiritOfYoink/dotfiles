How are you here? This is designed for one of four people, and three of them don't know how to use Nix.


# TO INSTALL:

Step 1: Install NixOS using a graphical installer. Choose a temporary password, login automatically, and reuse password for administrator. Select no desktop when prompted.

Step 2: Before rebooting, use the live CD to navigate to the new volume. Under /etc/nixos, edit configuration.nix.

Step 3: Add the following lines below the imports = []; section:

    programs.git.enable = true;
    nix.settings.experimental-features = "nix-command flakes";

      then exit and save.

Step 4: Next, navigate to /home on the same volume. Right click and select "open in terminal."

Step 5: In the terminal, run:
    sudo nixos-rebuild switch && sudo git clone https://github.com/spiritofyoink/dotfiles

Step 6: Run the following, replacing <my-system> with your user or host. Current hosts are yoink, dame, mac, & hamster.

    sudo nixos-rebuild boot --flake github:spiritofyoink/dotfiles#<my-system>

Step 7: Finally, run:

    sudo nixos-generate-config --root /home/dotfiles

Step 8: Reboot. You should now be in NixOS.



Note: from then on, you simply need to use 'rebuild' to rebuild and switch the system configuration.



try:

export NIX_CONFIG="experimental-features = nix-command flakes"
nix shell nixpkgs#git --command nix flake clone github:spiritofyoink/dotfiles --dest ~/dotfiles
nix shell nixpkgs#git --command sudo nixos-rebuild switch --flake ~/dotfiles#<my-system>