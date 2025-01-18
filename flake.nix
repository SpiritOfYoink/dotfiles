{
  description = "YoinkOS configuration and versioning.";

#   ..... INPUTS .....

  inputs = {
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

  outputs = inputs@{ self, nixpkgs, pkgs, specialArgs, ... }:

  #   ..... VARIABLES .....    
  let
    user = "yoink";     # What's your login?
    fullname = "The Spirit of Yoink!";      # What's the user called?
    host = "Ncase M2";      # What's the computer called?

    #password = ;        # What is the user's secret file?
    #rootpw = ;      # What is the root user's secret file?

    server = "//192.168.1.70/NAS_Storage";      # Where's your network storage attached? (SMB share.)
    github = "https://github.com/SpiritOfYoink/dotfiles";       # Change this to the github link for your repository.

    pkgs = nixpkgs.legacyPackages."x86_64-linux";    # If 'system' changes, change this!
    lib = nixpkgs.lib;    # No need to change this.

  in {
      nixosConfigurations = {

        modules = [
          ./configuration.nix
          ./modules/desktop.nix
          ./modules/home-manager.nix
          ];

        "${host}" = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit user fullname host server github pkgs lib; };
            home-manager.ExtraSpecialArgs = { inherit user fullname host server github pkgs lib; };
            };

      pkgs = import nixpkgs {
          config.allowUnfree = true;
          config.contentAddressedByDefault = false;
          };
        };
      };
}
