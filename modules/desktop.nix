{ self, nixpkgs, pkgs, lib, specialArgs, ... }: {

imports = [
  inputs.niri.nixosModules.niri   # Niri window manager
  ];

  #   ..... NIRI - WINDOW MANAGER .....
    #   ..... SETTINGS .....
    niri-flake.cache.enable = true;
    nixpkgs.overlays = [niri.overlays.niri];
    environment.variables.NIXOS_OZONE_WL = "1";
    programs.niri = {
      package = pkgs.niri-stable;
      settings = {
        enable = true;
        prefer-no-csd = true;   # Asks applications to omit their client-side decorations.
        screenshot-path = "~/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
        input = {
          disable-power-key-handling = true;
          focus-follows-mouse = true;
          focus-follows-mouse-max-scroll-amount = "10%";
          };

        #   ..... KEYBINDINGS .....
        binds = with config.lib.niri.actions; {
          "Mod+Minus".action = set-column-width "+10%";
          "Mod+Equals".action = set-column-width "-10%";
          "Alt+Ctrl+Shift+H".action = spawn "bitwarden";
          "SysRq".action = screenshot-window;
          <name>.repeat = false;
          };

        #   ..... STARTUP: .....
        spawn-at-startup = "eww";   # Taskbar and notifications.
        spawn-at-startup = "fuzzel";    # Program launcher.

        #   ..... LAYOUT .....
        layout = {
          gaps = 16;
          center-focused-column = "never";
          
          always-center-single-column = true;

          focus-ring = {
            width = 2;
            active-color = "#7fc8ff";
            inactive-color = "#505050";
            };

          insert-hint = {
            enable = true ;
            color = "ffc87f80";
            };

          struts = {
            left = 64 ;
            right = 64 ;
            };

          default-column-width = { proportion = 0.33333; };

          preset-column-widths = {
            proportion = 0.33333 ;
            proportion = 0.5 ;
            proportion = 0.66667 ;
            };
          };

        #   ..... RULES .....
        window-rules = {
          window-rule = {     # Universal window rules?
            geometry-corner-radius = 12;
            clip-to-geometry = true;
            variable-refresh-rate = true;
            min-width = 100;
            max-width = 200;
            min-height = 300;
            max-height = 300;
            };

          window-rule = {   # Prevents focusing on the GIMP startup splash screen.
            match = app-id="^gimp" title="^GIMP Startup$" ;
            open-focused = false ;
            };

          window-rule = {   # Blocks Bitwarden from any screencast.
            match = app-id="bitwarden-desktop" app-id="bitwarden";
            block-out-from = "screen-capture";
            };

          layer-rule = {   # Blocks mako notifications from any screencast. How does this work with eww notifications?
            match = namespace="^notifications$";
            block-out-from = "screen-capture";
            };

          layer-rule = {    # Makes fuzzel semitransparent.
            match = namespace="^launcher$";
            opacity = 0.85 ;
            };
          };
        };    # End of niri.settings 
      };    # End of Niri.

  #   ..... EWW - TASKBAR AND NOTIFICATIONS .....

  #   ..... FUZZEL - PROGRAM LAUNCHER .....

}