{
  description = "YoinkOS configuration and versioning.";

#   ..... INPUTS .....

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";       # Nixpkgs.
    nix.package = pkgs.nixVersions.latest   # Prevents NixOS from throwing an error about nixVersions.unstable
    
    home-manager.url = "github:nix-community/home-manager";    # Home manager.
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
 
    nix-colors.url = "github:misterio77/nix-colors";    # Nix colors.
    nix-colors.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:mic92/sops-nix";   # Secret provisioning for password security.
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    
    nix-gl.url = "github:nix-community/nixgl";    # Wrapper to fix launching openGL games.
    nix-gl.inputs.nixpkgs.follows = "nixpkgs";

    nil.url = "https://github.com/oxalica/nil";   # Nix Language Server for VSCode.
    nil.inputs.nixpkgs.follows = "nixpkgs";

    niri-stable.url = "github:YaLTeR/niri/v25.01";    # Niri window manager.
    niri-stable.inputs.nixpkgs.follows = "nixpkgs";

    xwayland-satellite-stable.url = "github:Supreeeme/xwayland-satellite/v0.5";   # Allows Niri to hook into wayland.
    xwayland-satellite-stable.inputs.nixpkgs.follows = "nixpkgs";
    };


#   ..... OUTPUTS .....

  outputs = @ inputs: { self, nixpkgs, config, pkgs, lib, inputs, outputs, home-manager, niri, ... }

    #   ..... VARIABLES .....    
    let {
      user = "yoink";     # What's your login?
      fullname = "The Spirit of Yoink!";      # What's the user called?
      hostname = "Ncase M2";      # What's the computer called?

      #password = mkOption {};        # What is the user's secret file?
      #rootpw = mkOption {};      # What is the root user's secret file?

      device = "//192.168.1.70/NAS_Storage";      # Where's your network storage attached? (SMB share.)
      github = "github:SpiritOfYoink/dotfiles"       # Change this to the github link for your repository.

      system = "x86_64-linux";        # This doesn't need to change unless you're using ARM or Apple silicon.
      pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";    # If 'system' changes, change this!
      lib = nixpkgs.lib
      };


    in {
      nixosConfigurations.config.modules = nixpkgs.lib.nixosSystem {
        SpecialArgs = {inherit inputs; }; # Sends flake.nix's inputs to every nix module.
        modules = [
          ./configuration.nix;
          ./modules/desktop.nix;
          ./modules/home-manager.nix;
          ./moduels/variables.nix
          inputs.home-manager.nixosModules.default;    # Pulls in the default home-manager module?
          ];

        overlays = [
          nixgl.overlay;   # You can now reference pkgs.nixgl.nixGLIntel, etc.
          ];
        };

        home-manager = {    # Configuration for home-manager.
          enable = true;
          ExtraSpecialArgs = { inherit inputs; };   # Sends flake.nix's inputs to every home manager module.
          users.${user} = {
            imports = [
              eww.homeManagerModules.${system}.default    # Imports ElKowar's Wacky Widgets, used for taskbar and notifications.
              inputs.nix-colors.homeManagerModules.default    # Imports nix-colors, a comprehensive style selector.
              ];
            backupFileExtension = "backup";
            useGlobalPkgs = true;
            useUserPackages = true;
            };
          };
    };
};





    
