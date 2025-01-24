{pkgs, lib, config, ... }: with lib; {


#   ..... SUBMODULES .....
imports = [
  ./eww.nix
  ./fuzzle.nix
  ./niri.nix
  ];

#   ..... DEFAULT SETTINGS .....

    eww.taskbar.enable = mkDefault true;
    eww.notifications.enable =  mkDefault true;

    fuzzle.enable = mkDefault true;

    niri.enable = mkDefault true;

}   # End of file.