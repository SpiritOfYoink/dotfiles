{pkgs, lib, config, ... }: with lib;

let
  cfg = config.modules.system.gui;    # Shorter name to access final settings. cfg is a typical convention.
in {

#   ..... CALLABLE OPTIONS .....
  options = { fuzzle.enable = mkEnableOption "Enables the program launcher."; };

#   ..... CONFIG .....
  config = mkIf cfg.fuzzle.enable {

    };

}   # End of file.