{pkgs, lib, config, ... }: with lib; {

#   ..... CALLABLE OPTIONS .....
  options = { boot.enable = mkEnableOption "Enables... booting."; };

#   ..... CONFIG .....

  config = mkIf boot.enable {
    boot.loader = {
        systemd-boot.enable = true;   # Enables bootloader. DO NOT TOUCH.
        efi.canTouchEfiVariables = true;    # Allows bootloader to manage boot entries. DO NOT TOUCH.
        systemd-boot.configurationLimit = 10;   # Limits the number of previous configurations stored in the bootloader. Increase if you may need to go further back in time.
        };

  config = mkIF boot.enable && nvidia-drivers.enable {
    boot.blacklistedKernelModules = [ "nouveau"];    # Prevents the open-source drivers from loading.
    }; };

}   # End of file.
