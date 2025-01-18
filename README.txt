How are you here? This is designed for one of four people, and three of them don't know how to use Nix.

INSTALLATION:

1) Install NixOS (no GUI needed), and run the following terminal commands:

2) sudo sed -i 's/^{$/{\n  programs.git.enable = true;/' /etc/nixos/configuration.nix       (Pay attention to the double space after the \n.)

3) sudo nixos-rebuild switch

4) sudo git clone https://github.com/SpiritOfYoink/dotfiles ~/home/dotfiles && cd ~/home/dotfiles

5) sudo nixos-generate-config --root ~/home/dotfiles

6) sudo nano ~/home/dotfiles/modules/variables.nix

7) Change the variables to appropriate values for your computer.

8) Exit nano with Ctl+X, Y, Enter.

9) sudo nixos-rebuild switch --flake ~/home/dotfiles


Note: from then on, you simply need to use 'rebuild' to rebuild and switch the system configuration.