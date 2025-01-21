{ pkgs, lib, config, ... }: with lib; {


  home.username = "${user}";
  home.homeDirectory = "/home/${user}/dotfiles/modules/home-manager";
  home.stateVersion = "24.11";    # This is used for backwards compatiblity. Don't change this.
  programs.home-manager.enable = true;    # Let Home Manager install and manage itself.


  #   ..... THEMING .....
  xsession = {    # Wait, but I'm supposed to be using wayland..?
    enable = true;
    pointerCursor = {
      size = 40 ;
      package = pkgs.nur.repos.ambroisie.vimix-cursors;
      name = "Vimix-cursors";
      };
    };




  home.packages = with pkgs; [  # The home.packages option allows you to install Nix packages into your environment.

    # GUI
    eww   # ElKowar's Wacky Widgets, used for taskbar and notifications.
    niri-stable   # Window Manager.
    fuzzle    # Program Launcher

    # SERVICES
    java    # Language required for some Steam games.
    wget    # Web server file retrieval.
    curl    # Data transfer through network protocols.
   
    # DESKTOP APPS
    spotify   # Spotify music streamer.
    discord   # Messaging and screencasting.
    beeper    # Universal chat, including discord.

    # SYSTEM TOOLS
    bitwarden-desktop   # Password Manager.
    gfie    # Greenfish icon editor.
    squirreldisk    # Disk space analysis tool.
    htop   # Allows monitoring system resources through the terminal.

    # BROWSERS
    opera
    termite.browser = "opera"   # Allows URLs to be clicked on to open them in the browser.
    termite.clickableUrl = true

     # Alias allowing the shell command 'rebuild' to do a full rebuild from github.
    (writeShellScriptBin "rebuild.sh" ''
      cd "/home/${dotfiles}"
      sudo nixos-rebuild switch --flake '${github}'
      '') ];

}   # End of file.