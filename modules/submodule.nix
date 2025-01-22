

# SAMPLE SUBMODULE

{ pkgs, lib, config, ... }:{

  home.packages = [

  ];

  # Use packages from `pkgs-stable` instead of `pkgs`
  home.packages = with pkgs-stable; [
    firefox-wayland

    # Chrome Wayland support was broken on the nixos-unstable branch,
    # so we fallback to the stable branch for now.
    # Reference: https://github.com/swaywm/sway/issues/7562
    google-chrome
  ];

  programs.vscode = {
    enable = true;
    # Refer to vscode from `pkgs-stable` instead of `pkgs`
    package = pkgs-stable.vscode;
  };
}
