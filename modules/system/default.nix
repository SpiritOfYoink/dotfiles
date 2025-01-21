{pkgs, lib, config, ... }: with lib; {


#   ..... SUBMODULES .....
imports = [
  ./boot.nix
  ./drivers.nix
  ./daemons.nix
  ];

#   ..... DEFAULT SETTINGS .....

    boot.enable = mkDefault true;

    daemons.enable = mkDefault true;

    drivers.enable = mkDefault true;
    nvidia-drivers.enable = mkDefault true;

}   # End of file.