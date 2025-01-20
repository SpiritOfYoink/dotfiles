{
  description = "You don't need to mess with this. It controls software versioning on your system.";

#   ..... INPUTS .....
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";       # Nixpkgs.

   # home-manager.url = "github:nix-community/home-manager";    # Home manager.
   # home-manager.inputs.nixpkgs.follows = "nixpkgs";
 
   # nix-colors.url = "github:misterio77/nix-colors";    # Nix colors.

   # sops-nix.url = "github:mic92/sops-nix";   # Secret provisioning for password security.
   # sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    
   # nix-gl.url = "github:nix-community/nixgl";    # Wrapper to fix launching openGL games.
   # nix-gl.inputs.nixpkgs.follows = "nixpkgs";
  
    niri-stable.url = "github:YaLTeR/niri/v25.01";    # Niri window manager.
    niri-stable.inputs.nixpkgs.follows = "nixpkgs";

   # xwayland-satellite-stable.url = "github:Supreeeme/xwayland-satellite/v0.5";   # Allows Niri to hook into wayland.
   # xwayland-satellite-stable.inputs.nixpkgs.follows = "nixpkgs";
    };


#   ..... OUTPUTS .....
  outputs = {self, nixpkgs, ... }@inputs:{
    system = "x86_64-linux";
    #ISO = self.nixosConfigurations.iso.config.system.build.isoImage;
    #homeManagerModules.default = ./modules/home-manager;
    };
}   # End of file.