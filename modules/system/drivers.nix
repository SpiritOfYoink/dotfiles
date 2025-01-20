{pkgs, lib, config, ... }: with lib;

let
  cfg = config.modules.system;    # Shorter name to access final settings. cfg is a typical convention.
in {

#   ..... CALLABLE OPTIONS .....
  options = {
    drivers.enable = mkEnableOption "Enables drivers. You probably want these.";
    nvidia-drivers.enable = mkEnableOption "Enables Nvidia propriatary drivers.";
    };

#   ..... CONFIG .....
  config = mkMerge [
    (mkIf cfg.drivers.enable = {
    hardware = {
      enableAllFirmware = true;   # Enables firmware with a licence allowing redistribution.
      graphics = {
        enable = true;    # Enables OpenGL.
        enable32Bit = true;   # Enables 32-bit drivers for 32-bit applications (such as Wine).
        driSupport = true;    # Enables Vulkan .
        driSupport32Bit = true; 
        }; }; }; );

    ( mkIf cfg.nvidia-drivers.enable = {

      nixpkgs.config.allowUnfree = true;
      services.xserver.videoDrivers = ["nvidia"];   # Loads Nvidia driver for Xorg and Wayland.

      hardware.nvidia = {
        open = true;    # Uses the open-source modules (not drivers).
        modesetting.enable = true;    # Modesetting is required to run wayland.

  #      nvidia-persistenced = true;    # Allows the toggling of 'persistence mode' in nvidia management software. May only be for laptops?
  #      dynamicBoost.enable = true;    # Allows the GPU clock speed to boost as normal. May only be for laptops?

        powerManagement = {
          enable = false;   # Experimental and can cause sleep/suspend to fail. Enable if having crashes after wakie from sleep.
          finegrained = false;    # Turns off GPU when not in use. Do not enable.
          };

        nvidiaSettings = true;    # Enables the nvidia settings menu.
        package = config.boot.kernelPackages.nvidiaPackages.latest;   # Use most recent Nvidia drivers.
        }; }; ); ];


}   # End of file.