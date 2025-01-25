{  description = "Home Manager Configuration";

#   ..... INPUTS .....
    inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";       # Nixpkgs.
      home-manager = {
        url = "github:nix-community/home-manager";    # Home manager.
        inputs.nixpkgs.follows = "nixpkgs";
        };
      niri = {
        url = "github:YaLTeR/niri/v25.01";
        inputs.nixpkgs.follows = "nixpkgs"; 
        };
      xwayland-satellite-stable.url = "github:Supreeeme/xwayland-satellite/v0.5";# Allows Niri to hook into wayland.
      niri-stable.flake = false;
      xwayland-satellite-stable.flake = false;


    # wsl.url = "github:nix-community/NixOS-WSL";    # Used for Windows Subsystem for Linux compatibility
    # nix-colors.url = "github:misterio77/nix-colors";    # Nix colors.
      stylix = {
        url = "github:danth/stylix";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.home-manager.follows = "home-manager";
        };
    # sops-nix.url = "github:mic92/sops-nix";   # Secret provisioning for password security.
    # nix-gl.url = "github:nix-community/nixgl";    # Wrapper to fix launching openGL games.
    };


#   ..... OUTPUTS .....
    outputs = {self, nixpkgs, home-manager, stylix, niri-stable, ... }@inputs:
      let
        inherit (home-manager.lib) homeManagerConfiguration;
        system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;
          config = {allowUnfree = true; };
          };

      in rec {


#   ..... SYSTEM .....

    environment.sessionVariables = {
      NIX_PATH = "/home/dotfiles/${user}/configuration.nix";
      };
    
    nixpkgs.config.allowUnfree = true;
    programs.gamemode.enable = true;    # TODO: See if this needs more setting up.

    nix = {
      environment.systemPackages = with pkgs; [
        git   # Flakes clones its dependencies through the git command, so it must be at the top of the list.
        home-manager
        ];
      settings.experimental-features = ["nix-command flakes"];   # Enables the Flakes update system command in conjunction with a rebuild.
      checkConfig = true;
      checkAllErrors = true;
      };

    time.timeZone = "America/Los_Angeles";      # Sets your time zone.
    i18n.defaultLocale = "en_US.UTF-8";     # Selects internationalisation properties.
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
        };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "24.11";    # Did you read the comment?


#   ..... USER SETUP .....

    networking.hostName = "${host}";    # What the computer is called on your network.

    users.users."${user}" = {   # Defines the user account.
        isNormalUser = true;
        description = "${fullname}";
        extraGroups = [ "wheel"  "networkmanager"];
        initialPassword = "correcthorsebatterystaple";    # TODO: Be sure to change this to the secrets below, when you get that set up.

    #users.users."${user}"".HashedPassword = mkOption { "/home/${user}/hosts/${user}/secrets/user-secrets" };   # This is the user's password.
    #users.users."root".HashedPassword = mkOption { "/home/${user}/hosts/${user}/secrets/root-secrets"; };   # This is the root user's password.

    users.mutableUsers = false;   # Users and passwords cannot be changed ourside of this file.
    };


  #   ..... HOST SETUPS .....

      nixosConfigurations = {


        }; 



     # Alias allowing the shell command 'rebuild' to do a full rebuild from github. Does this go inside or outside of home manager?
    (writeShellScriptBin "rebuild.sh" ''
      cd "/home/${dotfiles}"
      sudo nixos-rebuild switch --upgrade --flake '${github}'
      '')



      homeConfigurations = {      # These actually go in the user's dotfiles. 

        yoink = home-manager.lib.homeManagerConfiguration {   # THE SPIRIT OF YOINK
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          specialArgs = { inherit inputs outputs; };   # Allows modules access to flake inputs.
          extraSpecialArgs = { inherit inputs outputs; };   # Allows home-manager modules access to flake inputs.
          config = { allowUnfree = true; };
          modules = [ ./users/yoink ];
          };

  #     dame = nixpkgs.lib.nixosSystem rec {    # NO AIM DAME
  #        pkgs = nixpkgs.legacyPackages.x86_64-linux;
  #      specialArgs = { inherit inputs outputs; };   # Allows modules access to flake inputs.
  #        extraSpecialArgs = { inherit inputs outputs; };   # Allows home-manager modules access to flake inputs.
  #        config = { allowUnfree = true; };
  #         modules = [ ./hosts/dame/configuration.nix ./home-manager ];
  #         };

  #    mac = nixpkgs.lib.nixosSystem rec {   # MAC'N'CHEESE
  #        pkgs = nixpkgs.legacyPackages.x86_64-linux;
  #        specialArgs = { inherit inputs outputs; };   # Allows modules access to flake inputs.
  #        extraSpecialArgs = { inherit inputs outputs; };   # Allows home-manager modules access to flake inputs.
  #        config = { allowUnfree = true; };
  #         modules = [ ./hosts/mac/configuration.nix ./home-manager ];
  #         };

  #     hamster = nixpkgs.lib.nixosSystem rec {    # HAMSTER
  #        pkgs = nixpkgs.legacyPackages.x86_64-linux;
  #        specialArgs = { inherit inputs outputs; };   # Allows modules access to flake inputs.
  #        extraSpecialArgs = { inherit inputs outputs; };   # Allows home-manager modules access to flake inputs.
  #        config = { allowUnfree = true; };
  #         modules = [ ./hosts/hamster/configuration.nix ./home-manager ];
  #         };

  #     server = nixpkgs.lib.nixosSystem rec {    # SERVER
  #        pkgs = nixpkgs.legacyPackages.x86_64-linux;
  #        specialArgs = { inherit inputs outputs; };   # Allows modules access to flake inputs.
  #        extraSpecialArgs = { inherit inputs outputs; };   # Allows home-manager modules access to flake inputs.
  #        config = { allowUnfree = true; };
  #         modules = [ ./hosts/server/configuration.nix ./home-manager ];
  #         };

        }; }; }   # End of file.