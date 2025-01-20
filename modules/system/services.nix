{pkgs, lib, config, ... }: with lib;

let
  cfg = config.modules.system;    # Shorter name to access final settings. cfg is a typical convention.
in {

#   ..... CALLABLE OPTIONS .....
  options = { services.enable = mkEnableOption "Enables various daemons."; };

#   ..... CONFIG .....
  config = mkIf cfg.services.enable {

    nix.gc = {    # Manages garbage collection.
      enable = true; 
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than-15d";
      };

    nix.optimise = {    # Manages store optimisation.
      enable = true;
      automatic = true;
      dates = "05:30";
      };

    networking.networkmanager.enable = true;    # Enables networking.
    networking.firewall.extraCommands = ''iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns'';    # Tunes firewall to allow SMB sharing.

    xdg.portal = {    # Gnome Toolkit portal needed to make gtk apps happy.
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];   # Used for screencasting.
      };

    hardware = {
      bluetooth.enable = true;
      bluetooth.powerOnBoot = true;   # Powers up the default Bluetooth controller on boot.
      hardware.pulseaudio.enable = false;   # Disables the old PulseAudio drivers.
      }; }; };

#   ..... SERVICES .....
    services = {
      printing.enable = true;   # CUPS printing service.
      libinput.enable = true;   # Enables mouse input.

      xserver = {
        pipewire = {   # Enables Pipewire audio drivers.
          enable = true;
          audio.enable = true;    # Makes Pipewire the default audio handler.
          alsa.enable = true;   # Enables the ALSA sound API.
          alsa.Support32Bit = true;
          jack.enable = true;   # Enables Jack audio emulation. 
          pulse.enable = true;    # Enables PulseAudio server emulation.
          }; };


}   # End of file.