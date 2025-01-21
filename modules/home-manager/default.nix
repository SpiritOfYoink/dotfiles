{ pkgs, lib, config, ... }: with lib; {


  home.username = "${user}";
  home.homeDirectory = "/home/${user}/dotfiles/modules/home-manager";
  home.stateVersion = "24.11";    # This is used for backwards compatiblity. Don't change this.
  programs.home-manager.enable = true;    # Let Home Manager install and manage itself.

  home.packages = [   # Packages that should be installed to the user profile.
  pkgs.htop   # Allows monitoring system resources through the terminal.
  ];
}