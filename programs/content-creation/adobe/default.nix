{pkgs, lib, config, ... }: with lib; {

#   ..... SUBMODULES .....
    imports = [
      ./after-effects.nix
      ./photoshop.nix
      ./premiere-pro.nix
      ];

#   ..... DEFAULT SETTINGS .....

    after-effects.enable = mkDefault true;
    photoshop.enable = mkDefault true;
    premiere-pro.enable = mkDefault true;

#   ..... CONFIG .....
    options = {     # Defines new NixOS options. Call with config.<option>.enable =
      adobe.enable = lib.mkEnableOption "Enables propriatary, expensive editing software."; 
      };

    config = lib.mkIf config.content-creation.enable {
      users."${user}".programs = {

      }; };

}       # End of file.