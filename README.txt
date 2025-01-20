How are you here? This is designed for one of four people, and three of them don't know how to use Nix.


# TO INSTALL:

Step 1: Install NixOS using a graphical installer. Choose a temporary password, login automatically, and reuse password for administrator. Select no desktop when prompted.

Step 2: Before rebooting, use the live CD to navigate to the new volume. Under /etc/nixos, edit configuration.nix.

Step 3: Add the following lines below the imports = []; section:

    programs.git.enable = true;
    nix.settings.experimental-features = "nix-command flakes";

      then exit and save.

Step 4: Next, navigate to /home on the same volume. Right click and select "open in terminal."

Step 3: Run:
    sudo git clone https://github.com/spiritofyoink/dotfiles

Step 4: Reboot.

Step 5: After logging back in, run:
    cd /home/dotfiles

Step 6: Run the following terminal command, replacing <my-system> with your user or host. Current hosts are yoink, dame, mac, & hamster.

    sudo nixos-rebuild switch --flake github:spiritofyoink/dotfiles#<my-system>



Note: from then on, you simply need to use 'rebuild' to rebuild and switch the system configuration.