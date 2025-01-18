{ self, nixpkgs, pkgs, config, lib, home-manager, niri, user, fullname, hostname, password, rootpw, server, github, ...  }: {

#   ..... BOILERPLATE ..... 

  programs.home-manager.enable = true;  # Enables home-manager.
  useGlobalPkgs = true;
  useUserPackages = true;
  backupFileExtension = "backup";
  systemd.user.startServices = "sd-switch";   # Nicely reloads system units when changing configs.

  home.username = ${user};
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "23.11";    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion

#   ..... THEMING .....
  xsession = {    # Wait, but I'm supposed to be using wayland..?
    enable = true;
    pointerCursor = {
      size = 40 ;
      package = pkgs.nur.repos.ambroisie.vimix-cursors;
      name = "Vimix-cursors";
      };
    };

    # stylix, and the font is "Consolas, 'Courier New', monospace"


#   ..... PROGRAMS .....

  home.packages = with pkgs; [  # The home.packages option allows you to install Nix packages into your environment.

    eww   # ElKowar's Wacky Widgets, used for taskbar and notifications.
    bitwarden-desktop   # Password Manager.
    java    # Language required for some Steam games.
    wget    # Web server file retrieval.
    curl    # Data transfer through network protocols.
    gfie    # Greenfish icon editor.
    spotify   # Spotify music streamer.
    discord   # Messaging and screencasting.
    beeper    # Universal chat, including discord.
    squirreldisk    # Disk space analysis tool.

    opera    # Browser
    termite.browser = "opera"   # Allows URLs to be clicked on to open them in the browser.
    termite.clickableUrl = true

  # Alias allowing the shell command 'rebuild' to do a full rebuild from github.
    (pkgs.writeShellScriptBin "rebuild" ''
      cd "${dotfiles}"
      sudo nixos-rebuild switch --flake '${github}'
      "
      '')
    ];

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
        "nix.enableLanguageServer": true;   # Adds Nil, an incremental analysis assistant for Nix.
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

}