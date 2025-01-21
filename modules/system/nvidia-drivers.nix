{pkgs, lib, config, ... }: with lib; {

#   ..... CALLABLE OPTIONS .....
  options = {
    nvidia-drivers.enable = mkEnableOption "Enables Nvidia propriatary drivers.";
    };

#   ..... CONFIG .....
  config = mkIf config.nvidia-drivers.enable {
    boot.blacklistedKernelModules = [ "nouveau"];    # Prevents the open-source drivers from loading.

    nixpkgs.config = {
      allowUnfree = true;    # Allows unfree software. Required for nvidia drivers.
      nvidia.acceptLicense = true;   # Accepts Nvidia's terms of service.
      };
  
    package = config.boot.kernelPackages.nvidiaPackages.latest;   # Use most recent Nvidia drivers.

    services.xserver.videoDrivers = ["nvidia"];   # Loads Nvidia driver for Xorg and Wayland.

    
    hardware.graphics.extraPackages = with pkgs; [vaapiVdpau nvenc];


    hardware.nvidia = {
      modesetting.enable = true;    # Modesetting is required to run wayland.

      open = true;    # Uses the open-source modules (not drivers).
      nvidiaSettings = true;    # Enables the nvidia settings menu.

      powerManagement = {
        enable = false;   # Experimental and can cause sleep/suspend to fail. Enable if having crashes after wakie from sleep.
        finegrained = false;    # Turns off GPU when not in use. Do not enable.
        };
#       nvidia-persistenced = true;    # Allows the toggling of 'persistence mode' in nvidia management software. May only be for laptops?
#       dynamicBoost.enable = true;    # Allows the GPU clock speed to boost as normal. May only be for laptops?
      }; }

}   # End of file.