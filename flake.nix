{
  description = "YoinkOS configuration and versioning.";

#   ..... INPUTS .....

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";       # Nixpkgs.
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    
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

    ghostty.url = "github:ghostty-org/ghostty";    # Ghostty terminal.
    ghostty.inputs.nixpkgs.follows = "nixpkgs";

    niri-stable.url = "github:YaLTeR/niri/v25.01";    # Niri window manager.
    niri-stable.inputs.nixpkgs.follows = "nixpkgs";

    xwayland-satellite-stable.url = "github:Supreeeme/xwayland-satellite/v0.5";   # Allows Niri to hook into wayland.
    xwayland-satellite-stable.inputs.nixpkgs.follows = "nixpkgs";
    };


#   ..... OUTPUTS .....

  outputs = { self, nixpkgs, ... } @ inputs: {
    let {    # Set these values in variables.nix!
      user = config.modules.variables.user;
      fullname = config.modules.variables.fullname;
      hostname = config.modules.variables.hostname;
      password = config.modules.variables.password;
      rootpw = config.modules.variables.rootpw;
      system = config.modules.variables.system;
      device = config.modules.variables.device;
      github = config.modules.variables.github;
      pkgs = nixpkgs.legacyPackages.${system};
      };

    in {
      nixosConfigurations.config.modules.variables.hostname = nixpkgs.lib.nixosSystem {
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
};
