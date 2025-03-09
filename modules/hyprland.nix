{ config, pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    settings = {
      monitor = ",preferred,auto,auto";
      
      env = [
        "QT_QPA_PLATFORM,wayland"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_STYLE_OVERRIDE,kvantum"
      ];
      
      general = {
        gaps_in = 2;
        gaps_out = 8;
        border_size = 1;
        col.active_border = "rgb:b4befe";
        col.inactive_border = "rgba:595959aa";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };
      
      decoration = {
        rounding = 12;
        active_opacity = 0.95;
        inactive_opacity = 0.90;
        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          vibrancy = 0.15;
        };
      };
      
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
        ];
      };
      
      input = {
        kb_layout = "us,latam";
        kb_options = "grp:alt_shift_toggle";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad.natural_scroll = false;
      };
      
      gestures.workspace_swipe = false;
      
      device."epic-mouse-v1".sensitivity = -0.5;
      
      exec-once = [
        "systemctl --user start hyprpolkitagent"
        "ghostty"
        "nm-applet &"
        "waybar"
        "hyprpaper"
      ];
      
      bind = [
        "SUPER, Return, exec, ghostty"
        "SUPER, Space, togglefloating"
        "SUPER, Q, killactive"
        "SUPER_SHIFT, B, exec, ghostty -e btop"
        "SUPER_SHIFT, K, exec, XDG_CURRENT_DESKTOP=KDE kate"
        "SUPER, R, exec, EDITOR=nvim ghostty -e yazi"
        "SUPER, V, exec, ghostty -e nvim"
        "SUPER, O, exec, obsidian"
      ];
      
      bindel = [
        "ALT, F11, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        "ALT, F4, exec, brightnessctl set 10%-"
      ];
      
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];
    };
  };
}

