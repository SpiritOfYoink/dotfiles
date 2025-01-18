How are you here? This is designed for one of four people, and three of them don't know how to use Nix.

INSTALLATION:

1) Install NixOS (no GUI needed), and run the following terminal commands:

2) sed -i 's/^{$/{\n  programs.git.enable = true;/' /etc/nixos/configuration.nix

3) git clone https://github.com/SpiritOfYoink/dotfiles ~/.config/nixos && cd ~/.config/nixos

4) sudo nixos-generate-config

5) sudo nano ~/.config/nixos/dotfiles/modules/variables.nix

6) Change the variables to appropriate values for your computer.

7) Exit nano with Ctl+X, Y, Enter.

8) sudo nixos-rebuild switch --flake


Note: from then on, you simply need to use 'rebuild' to rebuild and switch the system configuration.