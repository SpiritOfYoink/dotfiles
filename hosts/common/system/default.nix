{pkgs, lib, config, ... }: with lib; {


#   ..... SUBMODULES .....
imports = [
  ./boot.nix
  ./daemons.nix
  ./drivers.nix
  ./login.nix
  ./nvidia-drivers.nix
  ];

#   ..... DEFAULT SETTINGS .....

    boot.enable = mkDefault true;

    daemons.enable = mkDefault true;

    drivers.enable = mkDefault true;
    nvidia-drivers.enable = mkDefault false;

    login-session = "niri".
    autologin = true;

}   # End of file.