{pkgs, lib, config ... }: with lib;

let
  cfg = config.modules.system.gui;    # Shorter name to access final settings. cfg is a typical convention.
in {

#   ..... CALLABLE OPTIONS .....
  options = { eww.enable = mkEnableOption "Enables the taskbar and notifications widget."; };

#   ..... CONFIG .....
  config = mkIf cfg.eww.enable {

    };

}   # End of file.
