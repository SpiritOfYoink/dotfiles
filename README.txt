How are you here? This is designed for one of four people, and three of them don't know how to use Nix.

INSTALLATION:

1) Install NixOS (no GUI needed), and run the following terminal commands:

2) cd /etc/nixos && sudo nano configuration.nix

3) In nano, add the following lines below imports:

    programs.git.enable = true;
    nix.settings.experimental-features = "nix-command flakes";

4) Exit nano with Ctl+X, Y, Enter.

5) sudo nixos-rebuild switch

cd /

6) sudo git clone https://github.com/SpiritOfYoink/dotfiles /home/dotfiles && cd /home/dotfiles



8) sudo nano /home/dotfiles/flake.nix

9) Change the variables (under the VARIABLES header) to appropriate values for your computer.

10) Exit nano with Ctl+X, Y, Enter.

11) sudo nixos-rebuild switch --flake /home/dotfiles


Note: from then on, you simply need to use 'rebuild' to rebuild and switch the system configuration.

