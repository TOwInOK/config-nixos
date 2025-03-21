{ config, lib, pkgs, ... }: {

  options = { hyprland.enable = lib.mkEnableOption "Enable Hyprland WM"; };

  config = lib.mkIf config.hyprland.enable {
    home.sessionVariables.NIXOS_OZONE_WL = "1";
    programs.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      xwayland.enable = true;
      systemd.enable = true;
      settings = {
        "$mainMod" = "SUPER";
        monitor = [ ",1920x1080@143.98100,auto,1" ];
        env = [
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"
          "XDG_SESSION_DESKTOP,Hyprland"
          "XCURSOR_SIZE,36"
          "QT_QPA_PLATFORM,wayland"
          "XDG_SCREENSHOTS_DIR,~/screens"
        ];

        debug = {
          disable_logs = false;
          enable_stdout_logs = true;
        };

        input = {
          kb_layout = "us,ru";
          kb_variant = "lang";
          kb_options = "grp:caps_toggle";

          follow_mouse = 1;

          touchpad = { natural_scroll = false; };

          sensitivity = 0;
        };

        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 3;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";

          layout = "dwindle";

          no_cursor_warps = false;
        };

        decoration = {
          rounding = 8;

          blur = {
            enabled = true;
            size = 16;
            passes = 2;
            new_optimizations = true;
          };

          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";
        };

        animations = {
          enabled = true;

          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          # bezier = "myBezier, 0.33, 0.82, 0.9, -0.08";

          animation = [
            "windows,     1, 7,  default"
            "windowsOut,  1, 7,  default, popin 80%"
            "border,      1, 10, default"
            "borderangle, 1, 8,  default"
            "fade,        1, 7,  default"
            "workspaces,  1, 6,  default"
          ];

        };
        misc = {
          animate_manual_resizes = true;
          animate_mouse_windowdragging = true;
          enable_swallow = true;
          render_ahead_of_time = false;
          disable_hyprland_logo = true;
        };
        windowrule = [ "float, ^(imv)$" "float, ^(mpv)$" ];
        exec-once = [
          "swww init"
          # "swww img ~/wallpapers/dark-willow-interest.jpeg"
          "waybar"
          # "wl-paste --type text --watch cliphist store"
          # "wl-paste --type image --watch cliphist store"
          "blueman-manager"
          # "discord"
          # "telegram-descktop"
          # "swaync"
        ];
        bind = [
          "$mainMod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
          "$mainMod, TAB, exec, swaync-client -t -sw"
          "CTRL, T, exec, alacritty"
          "CTRL, Q, killactive,"
          "$mainMod, M, exit,"
          # "$mainMod, E, exec, dolphin"
          "ALT, F, togglefloating,"
          "CTRL, D, exec, wofi --show drun"
          #"$mainMod, P, pseudo, # dwindle"
          "$mainMod, J, togglesplit, # dwindle"

          # Move focus with mainMod + arrow keys
          "$mainMod, left,  movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up,    movefocus, u"
          "$mainMod, down,  movefocus, d"

          # Moving windows
          "ALT, left,  swapwindow, l"
          "ALT, right, swapwindow, r"
          "ALT, up,    swapwindow, u"
          "ALT, down,  swapwindow, d"

          # Window resizing                     X  Y
          "$mainMod CTRL, left,  resizeactive, -60 0"
          "$mainMod CTRL, right, resizeactive,  60 0"
          "$mainMod CTRL, up,    resizeactive,  0 -60"
          "$mainMod CTRL, down,  resizeactive,  0  60"

          # Switch workspaces with mainMod + [0-9]
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          # # Move active window to a workspace with mainMod + SHIFT + [0-9]
          # "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
          # "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
          # "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
          # "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
          # "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
          # "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
          # "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
          # "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
          # "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
          # "$mainMod SHIFT, 0, movetoworkspacesilent, 10"

          # # Scroll through existing workspaces with mainMod + scroll
          # "$mainMod, mouse_down, workspace, e+1"
          # "$mainMod, mouse_up, workspace, e-1"
          # "$mainMod, left, workspace, e-1"
          # "$mainMod, right, workspace, e+1"
          # Keyboard backlight
          #"$mainMod, F3, exec, brightnessctl -d *::kbd_backlight set +33%"
          #"$mainMod, F2, exec, brightnessctl -d *::kbd_backlight set 33%-"
          # Cli invoke
          # "CTRL, e, exec, alacritty -e ranger"
          # "Ctrl Shift, Escape, exec, alacritty -e htop"
          # Volume and Media Control
          ", XF86AudioRaiseVolume, exec, pamixer -i 5 "
          ", XF86AudioLowerVolume, exec, pamixer -d 5 "
          ", XF86AudioMute, exec, pamixer -t"
          ", XF86AudioMicMute, exec, pamixer --default-source -m"

          # Brightness control
          #", XF86MonBrightnessDown, exec, brightnessctl set 5%- "
          #", XF86MonBrightnessUp, exec, brightnessctl set +5% "

          '', Print, exec, grim -g "$(slurp)" - | swappy -f -''
          #''CTRL, Print, exec, grim -g "$(satty init-crop --early-exit)"''

          # Waybar
          "$mainMod, B, exec, pkill -SIGUSR1 waybar"
          "$mainMod, W, exec, pkill -SIGUSR2 waybar"

          # Disable all effects
          #"$mainMod Shift, G, exec, ~/.config/hypr/gamemode.sh "
        ];

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
      };
    };
  };
}
