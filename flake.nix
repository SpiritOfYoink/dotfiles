{  description = "Home Manager Configuration";

#   ..... INPUTS .....
    inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";       # Nixpkgs.
      home-manager.url = "github:nix-community/home-manager";    # Home manager.
      home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # wsl.url = "github:nix-community/NixOS-WSL";    # Used for Windows Subsystem for Linux compatibility
    # nix-colors.url = "github:misterio77/nix-colors";    # Nix colors.
      stylix = {
        url = "github:danth/stylix";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.home-manager.follows = "home-manager";
        };
    # sops-nix.url = "github:mic92/sops-nix";   # Secret provisioning for password security.
    # nix-gl.url = "github:nix-community/nixgl";    # Wrapper to fix launching openGL games.
      niri-stable.url = "github:YaLTeR/niri/v25.01";    # Niri window manager.
      niri-stable.inputs.nixpkgs.follows = "nixpkgs";
    # xwayland-satellite-stable.url = "github:Supreeeme/xwayland-satellite/v0.5";   # Allows Niri to hook into wayland.
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
        packages = [
          import ./pkgs { inherit pkgs; }
          pkgs.home-manager
          ];
      
      

  #   ..... HOST SETUPS .....

      homeConfigurations = {       

        yoink = home-manager.lib.homeManagerConfiguration {   # THE SPIRIT OF YOINK
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          specialArgs = { inherit inputs outputs; };   # Allows modules access to flake inputs.
          extraSpecialArgs = { inherit inputs outputs; };   # Allows home-manager modules access to flake inputs.
          config = { allowUnfree = true; };
          modules = [ ./users/yoink ];
          };

          };

  #     dame = nixpkgs.lib.nixosSystem rec {    # NO AIM DAME
  #       specialArgs = { inherit inputs; };
  #         modules = [ ./hosts/dame/configuration.nix ./home-manager ];
  #         };

  #    mac = nixpkgs.lib.nixosSystem rec {   # MAC'N'CHEESE
  #       specialArgs = { inherit inputs; };
  #         modules = [ ./hosts/mac/configuration.nix ./home-manager ];
  #         };

  #     hamster = nixpkgs.lib.nixosSystem rec {    # HAMSTER
  #       specialArgs = { inherit inputs; };
  #         modules = [ ./hosts/hamster/configuration.nix ./home-manager ];
  #         };

  #     server = nixpkgs.lib.nixosSystem rec {    # SERVER
  #       specialArgs = { inherit inputs; };
  #         modules = [ ./hosts/server/configuration.nix ./home-manager ];
  #         };

        }; }   # End of file.