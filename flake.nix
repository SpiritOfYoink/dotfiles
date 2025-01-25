{
description = "Home Manager Configuration";

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
      };

#   ..... OUTPUTS .....
    outputs = { nixpkgs, lib, ... }@inputs:{

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


#   ..... HOST SETUPS .....

    nixosConfigurations = {
        yoink = nixpkgs.lib.nixosSystem {   # THE SPIRIT OF YOINK
        specialArgs = { inherit inputs; };   # Allows modules access to flake inputs.
        extraSpecialArgs = { inherit inputs; };   # Allows home-manager modules access to flake inputs.
        config = { allowUnfree = true; };
        modules = [ ./users/yoink ];
        };      


        }; }; }   # End of file.