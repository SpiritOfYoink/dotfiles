{pkgs, lib, config, ... }: with lib;

let
  cfg = config.modules.system.gui;    # Shorter name to access final settings. cfg is a typical convention.
in {

#   ..... CALLABLE OPTIONS .....
  options = { login.enable = mkEnableOption "Enables the login manager, skips login, and launches the GUI."; };

#   ..... CONFIG .....
  config = mkIf cfg.login.enable {

    services = {
      displayManager = {
        enable = true; 
        defaultSession = "niri";
        }; };
    
      xserver = {   # Terrible name, but services.xserver is used for GUI-related commands.
        enable = true;
        displayManager.gdm = {
          enable = true;
          wayland = true;
          settings = {
            AutomaticLoginEnable = true;
            AutomaticLogin = ${user};
            }; }; };
      };

}   # End of file.