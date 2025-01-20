{pkgs, lib, config, ... }: with lib;

let
  cfg = config.modules.system;    # Shorter name to access final settings. cfg is a typical convention.
in {


#   ..... SUBMODULES .....
imports = [
  ./boot.nix
  ./drivers.nix
  ./services.nix
  ./gui
  ];

#   ..... DEFAULT SETTINGS .....

    cfg.boot.enable = mkDefault true;

    cfg.drivers.enable = mkDefault true;
    cfg.drivers.nvidia-drivers.enable = mkDefault true;


    cfg.services.enable = mkDefault true;
    
}   # End of file.