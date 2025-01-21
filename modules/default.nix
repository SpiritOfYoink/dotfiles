{pkgs, lib, config, ... }: with lib; {


#   ..... SUBMODULES .....
imports = [
 ./home-manager
  ./system
  ]; 

#   ..... DEFAULT SETTINGS .....
    home-manager.enable = mkDefault false;

    system.enable = mkDefault true;

}   # End of file.