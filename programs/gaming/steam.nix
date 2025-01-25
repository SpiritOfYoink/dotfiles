{ pkgs, lib, config, ... }: with lib; {

#   ..... DEFAULT SETTINGS .....
    options = {     # Defines new NixOS options. Call with config.programs =
      steam.enable = lib.mkEnableOption "Enables Steam."; 
      };

    programs.steam = {   # Steam runs better if installed system-wide.
          enable = true;
          gamescope.enable = true;
          pkgs.steam.override.withJava = true;    # Allows for Java games.

          remotePlay.openFirewall = true;   # Open ports in the firewall for Steam Remote Play.
          localNetworkGameTransfers.openFirewall = true;    # Open ports in the firewall for Steam Local Network Game Transfers.
          extest.enable = true;   # Translates X11 input events to uinput events. (For using Steam Input on Wayland.)
          extraPackages = with pkgs; [ gamescope ];   # Valve's microcompositor to allow games to run in an isolated enviroment.
          gamescopeSession.enable = true;
          };

}   # End of file.