{ pkgs, lib, config, ... }: with lib; {

#   ..... SUBMODULES .....
imports = [
  ./common/system/
  ./common/gui/
  ];

#   ..... DEFAULT SETTINGS .....

    nvidia-drivers.enable =  mkDefault true;


#   ..... CONFIG .....
options = {     # Defines new NixOS options. Call with config.programs =
  programs.enable = lib.mkEnableOption "Enables the default software package."; 
  };

}   # End of file.