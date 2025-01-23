{pkgs, lib, config, ... }: with lib; {

#   ..... SUBMODULES .....
imports = [
  ./adobe
  ./audacity.nix
  ./blender.nix
  ./davinci-resolve.nix
  ./gimp.nix
  ./kdenlive.nix
  ./obs.nix
  ];

#   ..... DEFAULT SETTINGS .....

    adobe.enable = mkDefault false;

    audacity.enable = mkDefault true;

    blender.enable = mkDefault false;

    davinci-resolve.enable =  mkDefault false;

    gimp.enable = mkDefault true;

    kdenlive.enable = mkDefault false;

    obs.enable = mkDefault true;

#   ..... CONFIG .....
    options = {     # Defines new NixOS options. Call with config.<option>.enable =
      content-creation.enable = lib.mkEnableOption "Enables media creation tools."; 
      };

    config = lib.mkIf config.content-creation.enable {
      users."${user}".programs = {

        opera.override { proprietaryCodecs = true; } = {
          enable = true;
          package = pkgs.opera
          extensions = {
          }; }; }; };

}       # End of file.