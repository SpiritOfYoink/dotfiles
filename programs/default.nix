{ pkgs, lib, config, ... }: with lib; {

#   ..... SUBMODULES .....
imports = [
  ./apps
  ./content-creation
  ./gaming
  ./office
  ./services
  ./theming
  ./tools
  ];

#   ..... DEFAULT SETTINGS .....

    content-creation.enable =  mkDefault true;

    gaming.enable = mkDefault true;

    office.enable = mkDefault true;

    services.enable = mkDefault true;

    theming.enable = mkDefault true;

    tools.enable = mkDefault true; 

#   ..... CONFIG .....
options = {     # Defines new NixOS options. Call with config.programs =
  programs.enable = lib.mkEnableOption "Enables the default software package."; 
  };

}   # End of file.