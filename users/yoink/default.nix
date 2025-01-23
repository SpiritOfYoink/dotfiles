








 environment.systemPackages = [
    pkgs.home-manager
  ];


      homeConfigurations.home-manager.lib.homeManagerConfiguration {   # THE SPIRIT OF YOINK
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          specialArgs = { inherit inputs outputs; };   # Allows modules access to flake inputs.
          extraSpecialArgs = { inherit inputs outputs; };   # Allows home-manager modules access to flake inputs.
          config = { allowUnfree = true; };
          modules = [ ./users/yoink ];
          };
