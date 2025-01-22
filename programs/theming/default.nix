{pkgs, lib, config, ... }:{

options = {     # Defines new NixOS options. Call with config.desktopapps =
desktopapps.enable = lib.mkEnableOption "enables desktopapps"; 

    };

config = lib.mkIf config.desktopapps.enable {      # These values will be enabled as long as desktopapps.enable is set to true.
  users."${user}".programs = {

    opera.override { proprietaryCodecs = true; } = {
      enable = true;
      package = pkgs.opera
      extensions = {
      }; }; }; };



}       # End of file.