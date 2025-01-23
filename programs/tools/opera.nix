{pkgs, lib, config, ... }: with lib; {

#   ..... SUBMODULES .....
imports = [
  ];

#   ..... CONFIG .....
    options = {     # Defines new NixOS options. Call with config.<option>.enable =
      opera.enable = lib.mkEnableOption "Enables media creation tools."; 
      };

    config = lib.mkIf config.opera.enable {
      users."${user}".programs = {

        opera.override { proprietaryCodecs = true; } = {
          enable = true;
          package = pkgs.opera
          extensions = {
          }; }; }; };

}       # End of file.