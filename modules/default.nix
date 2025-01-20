{pkgs, lib, config, ... }: with lib;

let
  cfg = config.modules;    # Shorter name to access final settings. cfg is a typical convention.
in {


#   ..... SUBMODULES .....
imports = [
 # ./home-manager
 # ./programs
  ./system
  ]; 

#   ..... DEFAULT SETTINGS .....
    cfg.home-manager.enable = mkDefault false;

    cfg.programs.enable = mkDefault true;

    cfg.system.enable = mkDefault true;

}   # End of file.