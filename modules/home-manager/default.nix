{pkgs, lib, config, ... }: with lib; {


#   ..... SUBMODULES .....
imports = [
  ]; 

#   ..... CALLABLE OPTIONS .....
  options = { home-manager.enable = mkEnableOption "Enables various daemons."; };


}   # End of file.