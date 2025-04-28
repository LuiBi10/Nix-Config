{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # Monitor configuration
      monitor = [
        ",preferred,auto,auto"
      ];

      # Environment variables
      env = [
        "QT_QPA_PLATFORM,wayland"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_STYLE_OVERRIDE,qtc6t"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "HYPRCURSOR_THEME, Qogir Cursors"
      ];

      # Programs
      "$terminal" = "ghostty"; # Make sure alacritty is installed
      "$fileManager" = "dolphin";
      "$menu" = "rofi -show drun";

      # Autostart
      exec-once = [
        "systemctl --user start hyprpolkitagent"
        "$terminal"
        "nm-applet &"
        "waybar"
        "hyprpaper"
      ];

      # General settings
      general = {
        gaps_in = 2;
        gaps_out = 8;
        border_size = 1;
        "col.active_border" = "rgb(b4befe)";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      # Decoration settings
      decoration = {
        rounding = 12;
        active_opacity = 0.80;
        inactive_opacity = 0.87;

        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          vibrancy = 0.15;
        };
      };

      # Animation settings
      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      # Layout configurations
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      # Miscellaneous settings
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = false;
      };

      # Input settings
      input = {
        kb_layout = "us, latam";
        kb_options = "grp:alt_shift_toggle";
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = false;
        };
      };

      # Gesture settings
      gestures = {
        workspace_swipe = false;
      };

      # Per-device configurations
      device = [
        {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        }
      ];

      # Window and workspace rules
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "float,title:^(Save File)$"
        "opacity 0.85,title:^(discord)$"
        "workspace 3, class:^(obsidian)$"
        "workspace 3, class:^(org.kde.dolphin)$"
        "workspace 2, class:^(Google-chrome)$"
        "workspace 2, class:^(zen-twilight)$"
        "opacity 0.90 0.90,class:^(zen-twilight)$"
        "opacity 1.0 override, class:^(zen-twilight)$, title:^(.*Netflix.*)$"
        "opacity 1.0 override, class:^(zen-twilight)$, title:^(.*Video.*)$"
        "opacity 1.0 override, class:^(zen-twilight)$, title:^Picture-in-Picture$"
       ];

      # Key bindings
      "$mainMod" = "SUPER";

      # Combined Key bindings - IMPORTANT: Only ONE 'bind' section
      bind = [
        # Window controls
        "$mainMod, F, fullscreen"
        "$mainMod, Q, killactive"
        "$mainMod, Space, togglefloating"
        "$mainMod CTRL, Space, pin"

        # Application launchers
        "$mainMod, Return, exec, $terminal"
        "$mainMod CTRL, Return, exec, [float] $terminal"
        "SUPER_SHIFT, B, exec, $terminal -e btop"
        "SUPER_CTRL, Space, exec, rofi -show drun -disable-history"
        "SUPER_SHIFT, F, exec, XDG_CURRENT_DESKTOP=KDE dolphin"
        "SUPER_SHIFT, K, exec, XDG_CURRENT_DESKTOP=KDE kate"
        "SUPER, R, exec, EDITOR=nvim $terminal -e yazi"
        "SUPER, V, exec, $terminal -e nvim"
        "SUPER_SHIFT, V, exec, code"
        "SUPER, B, exec, zen-twilight"
        "SUPER, D, exec, discord"
        "SUPER, M, exec, EDITOR=nvim $terminal -e ncspot"
        "SUPER, O, exec,  obsidian --enable-features=UseOzonePlatform --ozone-platform=wayland"

        # Workspace management
        "SUPER CTRL, S, movetoworkspace, special"
        "SUPER, S, togglespecialworkspace"
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
        "$mainMod, TAB, workspace, previous"
        "SUPER_CTRL, J, workspace, -1"
        "SUPER_CTRL, K, workspace, +1"

        # Move windows to workspaces
        "$mainMod CTRL, 1, movetoworkspace, 1"
        "$mainMod CTRL, 2, movetoworkspace, 2"
        "$mainMod CTRL, 3, movetoworkspace, 3"
        "$mainMod CTRL, 4, movetoworkspace, 4"
        "$mainMod CTRL, 5, movetoworkspace, 5"
        "$mainMod CTRL, 6, movetoworkspace, 6"
        "$mainMod CTRL, 7, movetoworkspace, 7"
        "$mainMod CTRL, 8, movetoworkspace, 8"
        "$mainMod CTRL, 9, movetoworkspace, 9"
        "$mainMod CTRL, 0, movetoworkspace, 10"
        "SUPER_ALT, right, movetoworkspace, +1"
        "SUPER_ALT, left, movetoworkspace, -1"
        "SUPER_ALT, k, movetoworkspace, +1"
        "SUPER_ALT, j, movetoworkspace, -1"

        # Move windows to workspaces silently
        "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"

        # Mouse wheel workspace switching
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Screenshot bindings... "$mainMod SHIFT, Z, exec, hyprshot -m window -o ~/Pictures/Screenshots"
        "$mainMod SHIFT, S, exec, hyprshot -m region -o ~/Pictures/Screenshots"
        "$mainMod CTRL SHIFT, S, exec, hyprshot -m output -o ~/Pictures/Screenshots"

        # Focus movement
        "$mainMod, j, movefocus, l"
        "$mainMod, k, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, h, movefocus, l"
        "$mainMod, n, movefocus, r"
        "$mainMod, c, movefocus, u"
        "$mainMod, t, movefocus, d"

        # Power menu / system panel
        "$mainMod, Escape, exec, ags -t user-panel"

        # Move window bindings
        "$mainMod CTRL, left, movewindow, l"
        "$mainMod CTRL, right, movewindow, r"
        "$mainMod CTRL, up, movewindow, u"
        "$mainMod CTRL, down, movewindow, d"
        "$mainMod CTRL, h, movewindow, l"
        "$mainMod CTRL, n, movewindow, r"
        "$mainMod CTRL, c, movewindow, u"
        "$mainMod CTRL, t, movewindow, d"
      ];

      # Resize window bindings
      binde = [
        "$mainMod SHIFT, left, resizeactive, -50 0"
        "$mainMod SHIFT, right, resizeactive, 50 0"
        "$mainMod SHIFT, up, resizeactive, 0 -50"
        "$mainMod SHIFT, down, resizeactive, 0 50"
        "$mainMod SHIFT, H, resizeactive, -50 0"
        "$mainMod SHIFT, N, resizeactive, 50 0"
        "$mainMod SHIFT, C, resizeactive, 0 -50"
        "$mainMod SHIFT, T, resizeactive, 0 50"
      ];

      # Volume and media control
      bindel = [
        "ALT, F11, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        "ALT, F11, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        "ALT, F5, exec, brightnessctl set +10%"
        "ALT, F4, exec, brightnessctl set 10%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
      ];

      # Media control bindings
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}

