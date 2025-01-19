{pkgs, lib, config ... }: with lib;

let
  cfg = config.modules.system;    # Shorter name to access final settings. cfg is a typical convention.
in {

#   ..... CALLABLE OPTIONS .....
  options = { boot.enable = mkEnableOption "Enables... booting."; };

#   ..... CONFIG .....

  boot.enable = true;

  config = mkIf cfg.boot.enable {
    boot = { 
      loader = {
        systemd-boot.enable = true;   # Enables bootloader. DO NOT TOUCH.
        efi.canTouchEfiVariables = true;    # Allows bootloader to manage boot entries. DO NOT TOUCH.
        systemd-boot.configurationLimit = 10;   # Limits the number of previous configurations stored in the bootloader. Increase if you may need to go further back in time.
        }; };

  config = lib.mkIF cfg.boot.enable && config.modules.system.nvidia-drivers.enable {
    boot.blacklistedKernelModules = [ "nouveau"];    # Prevents the open-source drivers from loading.
    }; };

}   # End of file.
