How are you here? This is designed for one of four people, and three of them don't know how to use Nix.

INSTALLATION:

1) Install NixOS (no GUI needed), and run the following terminal commands:

2) cd ~/etc/nixos && sudo nano configuration.nix

In nano, add the following lines below imports:

    programs.git.enable = true;

    nix = {
        package = pkgs.nixFlakes;
        extraOptions = "experimental-features = nix-command flakes";
        };

3) sudo nixos-rebuild switch

4) git clone https://github.com/SpiritOfYoink/dotfiles ~/home/dotfiles && cd ~/home/dotfiles

5) sudo nixos-generate-config --root ~/home/dotfiles

6) sudo nano ~/home/dotfiles/flake.nix

7) Change the variables (under the VARIABLES header) to appropriate values for your computer.

8) Exit nano with Ctl+X, Y, Enter.

9) sudo nixos-rebuild switch --flake ~/home/dotfiles


Note: from then on, you simply need to use 'rebuild' to rebuild and switch the system configuration.