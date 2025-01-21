{pkgs, lib, config, ... }: with lib; {

#   ..... CALLABLE OPTIONS .....
  options = {
    drivers.enable = mkEnableOption "Enables drivers. You probably want these.";
    };

#   ..... CONFIG .....
  config = mkIf drivers.enable {
    hardware = {
      enableAllFirmware = true;   # Enables firmware with a licence allowing redistribution.
      graphics = {
        enable = true;    # Enables OpenGL.
        enable32Bit = true;   # Enables 32-bit drivers for 32-bit applications (such as Wine).
        driSupport = true;    # Enables Vulkan .
        driSupport32Bit = true; 
        }; }; };

}   # End of file.