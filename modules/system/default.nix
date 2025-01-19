{pkgs, lib, config... }: with lib; {

#   ..... SUBMODULES .....
imports = [
  ./boot.nix
  ./drivers.nix
  ./services.nix
  ./gui
  ];

#   ..... DEFAULT SETTINGS .....

    boot.enable = mkDefault true;

    drivers = [
      enable = mkDefault true;
      nvidia-drivers.enable = mkDefault true;
      ];

    services.enable = mkDefault true;
    
}   # End of file.