{pkgs, lib, config, inputs, ... }: with lib;
let
  pointer = config.home.pointerCursor;
  makeCommand = command: {
    command = [command]; };
in {

    #   ..... CONFIG .....

    programs.niri = {
      enable = true;
      prefer-no-csd = true;   # Asks applications to omit their client-side decorations.
      screenshot-path = "~/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      settings = {
        niri-flake.cache.enable = true;
        nixpkgs.overlays = [niri.overlays.niri];

        environment = {
          QT_QPA_PLATFORM = "wayland";
          QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
          NIXOS_OZONE_WL = "1";
          };

        spawn-at-startup = {
          (makeCommand "/usr/libexec/polkit-gnome-authentication-agent-1")
          (makeCommand "${inputs.self.packages.${pkgs.system}.cosmic-ext-alt}/bin/cosmic-ext-alternative-startup")
          (makeCommand "eww launch taskbar")
          (makeCommand "eww enable notifications")
          (makeCommand "fuzzle launch")
          };

        input = {
          disable-power-key-handling = true;
          focus-follows-mouse = true;
          focus-follows-mouse-max-scroll-amount = "10%";
          workspace-auto-back-and-forth = true;
          };

        layout = {
          gaps = 16;
          center-focused-column = "never";
          always-center-single-column = true;
          border.enable = false;
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
          default-column-width = {proportion = 1.0 / 2.0;};
          preset-column-widths = [
            {proportion = 1.0 / 3.0;}
            {proportion = 1.0 / 2.0;}
            {proportion = 2.0 / 3.0;}
            {proportion = 1.0;}
            ]; };

        animations.shaders.window-resize = ''
          vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
              vec3 coords_next_geo = niri_curr_geo_to_next_geo * coords_curr_geo;

              vec3 coords_stretch = niri_geo_to_tex_next * coords_curr_geo;
              vec3 coords_crop = niri_geo_to_tex_next * coords_next_geo;

              // We can crop if the current window size is smaller than the next window
              // size. One way to tell is by comparing to 1.0 the X and Y scaling
              // coefficients in the current-to-next transformation matrix.
              bool can_crop_by_x = niri_curr_geo_to_next_geo[0][0] <= 1.0;
              bool can_crop_by_y = niri_curr_geo_to_next_geo[1][1] <= 1.0;

              vec3 coords = coords_stretch;
              if (can_crop_by_x)
                  coords.x = coords_crop.x;
              if (can_crop_by_y)
                  coords.y = coords_crop.y;

              vec4 color = texture2D(niri_tex_next, coords.st);

              // However, when we crop, we also want to crop out anything outside the
              // current geometry. This is because the area of the shader is unspecified
              // and usually bigger than the current geometry, so if we don't fill pixels
              // outside with transparency, the texture will leak out.
              //
              // When stretching, this is not an issue because the area outside will
              // correspond to client-side decoration shadows, which are already supposed
              // to be outside.
              if (can_crop_by_x && (coords_curr_geo.x < 0.0 || 1.0 < coords_curr_geo.x))
                  color = vec4(0.0);
              if (can_crop_by_y && (coords_curr_geo.y < 0.0 || 1.0 < coords_curr_geo.y))
                  color = vec4(0.0);

              return color;
              ''}

        #   ..... KEYBINDINGS .....

        binds = with config.lib.niri.actions; {
          set-volume = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@";
          "Mod+Minus".action = set-column-width "+10%";
          "Mod+Equals".action = set-column-width "-10%";
          "Alt+Ctrl+Shift+H".action = spawn "bitwarden";
          "SysRq".action = screenshot-window;
          repeat = false;
          };

        #   ..... RULES .....

        window-rules = [
          {
          geometry-corner-radius = 12;
          clip-to-geometry = true;
          variable-refresh-rate = true;
          };{   # Prevents focusing on the GIMP startup splash screen.
          matchse = app-id="^gimp" title="^GIMP Startup$" ;
          open-focused = false ;
          };{   # Blocks Bitwarden from any screencast.
          matches = app-id="bitwarden-desktop" app-id="bitwarden";
          block-out-from = "screen-capture";
          };{   # Blocks signal from any screencast.
          matches = [{app-id = "org.signal.desktop";}];
          block-out-from = "screen-capture";
          };{    # Blocks mako notifications from any screencast. How does this work with eww notifications?
          matches = namespace="^notifications$";
          block-out-from = "screen-capture";
          };{    # Makes fuzzel semitransparent.
          matches = namespace="^launcher$";
          opacity = 0.85 ;
          }; ]; };

}   # End of file.