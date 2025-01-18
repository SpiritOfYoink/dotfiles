{
  description = "YoinkOS configuration and versioning.";

#   ..... INPUTS .....

  inputs = {self, nixpkgs, pkgs, lib, home-manager, niri, user, fullname, hostname, password, rootpw, server, github, ... }:{
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";       # Nixpkgs.
    # nix.package = pkgs.nixVersions.latest;   # Prevents NixOS from throwing an error about nixVersions.unstable
    
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

  outputs = { self, nixpkgs, pkgs, lib, home-manager, niri, user, fullname, hostname, password, rootpw, server, github, ... }:{

    modules = [
      ./configuration.nix
      ./variables.nix
      ./modules/desktop.nix
      ./modules/home-manager.nix
      ../../etc/nixos/hardware-configuration.nix
      inputs.home-manager.nixosModules.default    # Pulls in the default home-manager module?
      ];


    # Set your values in variables.nix!

    variables.nix = {
      specialArgs = {inherit inputs; }; # Sends flake.nix's inputs to every nix module.
      ExtraSpecialArgs = { inherit inputs; };   # Sends flake.nix's inputs to every home manager module.
      user = "user";
      fullname = "fullname";
      hostname = "hostname";
      server = "server";
      github = "github";
      system = "system";
      pkgs = inputs.nixpkgs.legacyPackages."system";
      lib = nixpkgs.lib;
      #password = "password";
      #rootpw = "rootpw";
      };

    pkgs = import nixpkgs {
        config.allowUnfree = true;
        config.contentAddressedByDefault = false;
      };

    home-manager = {    # Configuration for home-manager.
      enable = true;
      ExtraSpecialArgs = { inherit inputs; };   # Sends flake.nix's inputs to every home manager module.
      users.${user} = {
        backupFileExtension = "backup";
        useGlobalPkgs = true;
        useUserPackages = true;
        };
      };
    };
}