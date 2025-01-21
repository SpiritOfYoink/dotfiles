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

     # Alias allowing the shell command 'rebuild' to do a full rebuild from github.
    (writeShellScriptBin "rebuild.sh" ''
      cd "/home/${dotfiles}"
      sudo nixos-rebuild switch --flake '${github}'
      '') ];


  home.programs = {

    vscode = {    # VS Code   -- Source code editor.
      enable = true;
      enableUpdateCheck = false;    # It'll get updated along with the rest of the system.
      enableExtensionUpdateCheck = true;
      mutableExtensionsDir = false;
      extensions = with pkgs.vscode-extensions; [   # Add the VS Code extensions you use here.
        vscode-nix-ide    # Adds Nix language support.
        ];
      userSettings ={   #
        "nix.enableLanguageServer" = true;   # Adds Nil, an incremental analysis assistant for Nix.
        "nix.serverPath": "nil";
        "nix.serverSettings": {
          "nil": {
            "diagnostics": {
              "ignored": ["unused_binding", "unused_with"],
              },
            "formatting": {
              "command": ["nixpkgs-fmt"],;
              };
            };
          };
        };
      };    # End of VS Code.

    git = {   # git package manager.
      enable = true;
      userName = "thespiritofyoink@gmail.com";
      userEmail = "thespiritofyoink@gmail.com";
      };
    
    ghostty = {   # Terminal.
      enable = true;
      };

    };


  home.file = {   # Home Manager is pretty good at managing dotfiles. The primary way to manage plain files is through 'home.file'.
    };


  home.sessionVariables = {   # Home Manager can also manage your environment variables through 'home.sessionVariables'. 
    EDITOR = "vscode";     # Sets the default source-code editor.
    };

}   # End of file.