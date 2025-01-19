{pkgs, lib, config... }: with lib; {

#   ..... SUBMODULES .....
imports = [
  ./eww.nix
  ./fuzzle.nix
  ./login.nix
  ./niri.nix
  ];

#   ..... DEFAULT SETTINGS .....

    eww.enable = makDefault true;

    fuzzle.enable = mkDefault true;

    login.enable = mkDefault true; 

    niri.enable = mkDefault true;

}   # End of file.