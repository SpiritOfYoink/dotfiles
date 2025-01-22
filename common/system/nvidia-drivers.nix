{pkgs, lib, config, ... }: with lib; {

#   ..... CALLABLE OPTIONS .....
  options = {
    nvidia-drivers.enable = mkEnableOption "Enables Nvidia propriatary drivers.";
    };

#   ..... CONFIG .....
  config = mkIf config.nvidia-drivers.enable {
    boot.blacklistedKernelModules = [ "nouveau"];    # Prevents the open-source drivers from loading.
    boot.initrd.kernelModules = [ "nvidia" ];   # Forces the nvidia drivers to load.
    boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];


    nixpkgs.config = {
      allowUnfree = true;    # Allows unfree software. Required for nvidia drivers.
      nvidia.acceptLicense = true;   # Accepts Nvidia's terms of service.
      };
  
    package = config.boot.kernelPackages.nvidiaPackages.latest;   # Use most recent Nvidia drivers.

    services.xserver.videoDrivers = ["nvidia"];   # Loads Nvidia driver for Xorg and Wayland.

    
    hardware.graphics.extraPackages = with pkgs; [nvidia-vaapi-driver];


    hardware.nvidia = {
      modesetting.enable = true;    # Modesetting is required to run wayland.
      open = true;    # Uses nvidia's open-source modules (not drivers).

      nvidiaSettings = true;    # Enables the nvidia settings menu.

      encode.enable = true; 

      powerManagement = {
        enable = true;   # *Can* cause sleep/suspend to fail. Enable in case of graphical corruption or system crashes on suspend / resume.
        finegrained = false;    # Enable if the above setting gets enabled.
        };

#       forceFullCompositionPipeline = true;   # Can sometimes fix screen tearing issues, but may reduce the performance of some OpenGL applciations.
      }; }

}   # End of file.