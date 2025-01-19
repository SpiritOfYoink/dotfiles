{pkgs, lib, config ... }: with lib; {

#   ..... SUBMODULES .....
imports = [
  ./home-manager/
  ./programs/
  ./system/
  ]; 

#   ..... DEFAULT SETTINGS .....
    home-manager.enable = mkDefault true;

    programs.enable = mkDefault true;

    system.enable = mkDefault true;

}   # End of file.