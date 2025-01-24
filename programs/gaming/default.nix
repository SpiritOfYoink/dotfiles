{pkgs, lib, config, ... }:{

#   ..... SUBMODULES .....
    imports = [
      ./emulators
      ./gamemode.nix
      ./heroic.nix
      ./lutris.nix
      ./steam.nix
      ];


#   ..... DEFAULT SETTINGS .....

    emulators.enable = mkDefault false;
    gamemode.enable = mkDefault true;
    heroic.enable = mkDefault true;
    lutris.enable = mkDefault true;
    steam.enable = mkDefault true;

#   ..... CONFIG .....
    options = {     # Defines new NixOS options. Call with config.<option> =
      gaming.enable = lib.mkEnableOption "Installs gaming-related applications."; 
      };

    config = lib.mkIf config.desktopapps.enable {
      users."${user}".programs = {

      }; };

}       # End of file.