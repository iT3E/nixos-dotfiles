{ host, lib, ... }:
{
  wayland.windowManager.hyprland = {
    settings = {

      # autostart
      exec-once = [
        "systemctl --user import-environment &"
        "hash dbus-update-activation-environment 2>/dev/null &"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &"
        "nm-applet &"
        "wl-clip-persist --clipboard both"
        "swaybg -m fill -i $(find ~/Pictures/wallpapers/ -maxdepth 1 -type f) &"
        "hyprctl setcursor Nordzy-cursors 22 &"
        "poweralertd &"
        "waybar &"
        "swaync &"
        "wl-paste --watch cliphist store &"
        "hyprlock"

        # Static workspaces
        "$terminal = kitty"
        "$editor = nvim"
        "$browser = firefox-devedition"
        "$browser2 = google-chrome-stable"
        "[workspace 1 silent] $browser"
        "[workspace 2 silent] obsidian"
        "[workspace 2 silent] $terminal"
        "[workspace 3 silent] $terminal btop"
        "[workspace 3 silent] $terminal ping 8.8.8.8"
        "[workspace 3 silent] $terminal ping 172.16.1.1"
        "[workspace 3 silent] $terminal ping 10.10.30.1"
        "[workspace 3 silent] $terminal nvtop"
        "[workspace 4 silent] $browser"
        "[workspace 5 silent] $browser2"
        "[workspace 8 silent] $terminal"
      ];

      input = {
        kb_layout = "us";
        kb_options = "grp:alt_caps_toggle";
        numlock_by_default = true;
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.2;
          clickfinger_behavior = true;
          tap-to-click = false;
        };
        force_no_accel = lib.mkMerge [
          (lib.mkIf (host == "desktop") 1)
          (lib.mkIf (host != "desktop") 0)
        ];
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };

      general = {
        "$mainMod" = "SUPER";
        layout = "dwindle";
        gaps_in = 0;
        gaps_out = 0;
        border_size = 2;
        "col.active_border" = "rgb(cba6f7) rgb(94e2d5) 45deg";
        "col.inactive_border" = "0x00000000";
        border_part_of_window = false;
        no_border_on_floating = false;
      };

      misc = {
        disable_autoreload = true;
        disable_hyprland_logo = true;
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = false;
        enable_swallow = true;
        focus_on_activate = true;
      };

      dwindle = {
        # no_gaps_when_only = 1;
        force_split = 0;
        special_scale_factor = 1.0;
        split_width_multiplier = 1.0;
        use_active_for_splits = true;
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master = {
        new_status = "master";
        special_scale_factor = 1;
        # no_gaps_when_only = false;
      };

      decoration = {
        rounding = 0;
        # active_opacity = 0.90;
        # inactive_opacity = 0.90;
        # fullscreen_opacity = 1.0;

        blur = {
          enabled = true;
          size = 1;
          passes = 1;
          # size = 4;
          # passes = 2;
          brightness = 1;
          contrast = 1.4;
          ignore_opacity = true;
          noise = 0;
          new_optimizations = true;
          xray = true;
        };

        drop_shadow = true;

        shadow_ignore_window = true;
        shadow_offset = "0 2";
        shadow_range = 20;
        shadow_render_power = 3;
        "col.shadow" = "rgba(00000055)";
      };

      animations = {
        enabled = true;

        bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutCubic, 0.33, 1, 0.68, 1"
          "easeinoutsine, 0.37, 0, 0.63, 1"
        ];

        animation = [
          # Windows
          "windowsIn, 1, 3, easeOutCubic, popin 30%" # window open
          "windowsOut, 1, 3, fluent_decel, popin 70%" # window close.
          "windowsMove, 1, 2, easeinoutsine, slide" # everything in between, moving, dragging, resizing.

          # Fade
          "fadeIn, 1, 3, easeOutCubic" # fade in (open) -> layers and windows
          "fadeOut, 1, 2, easeOutCubic" # fade out (close) -> layers and windows
          "fadeSwitch, 0, 1, easeOutCirc" # fade on changing activewindow and its opacity
          "fadeShadow, 1, 10, easeOutCirc" # fade on changing activewindow for shadows
          "fadeDim, 1, 4, fluent_decel" # the easing of the dimming of inactive windows
          "border, 1, 2.7, easeOutCirc" # for animating the border's color switch speed
          "borderangle, 1, 30, fluent_decel, once" # for animating the border's gradient angle - styles: once (default), loop
          "workspaces, 1, 4, easeOutCubic, fade" # styles: slide, slidevert, fade, slidefade, slidefadevert
        ];
      };
      bind = [
        # assign apps
        # "$term = kitty"
        # "$editor = nvim"
        # "$file = dolphin"
        # "$browser = firefox"

        # Window/Session actions
        "$mainMod, X, killactive," # killactive, kill the window on focus
        "ALT, F4, killactive," # killactive, kill the window on focus
        "$mainMod, delete, exit," # kill hyperland session
        "$mainMod, W, togglefloating," # toggle the window on focus to float
        "$mainMod, G, togglegroup," # toggle the window on focus to float
        "ALT, return, fullscreen," # toggle the window on focus to fullscreen
        "$mainMod, L, exec, swaylock" # lock screen
        "$mainMod, backspace, exec, $scrPath/logoutlaunch.sh 1" # logout menu
        "$CONTROL, ESCAPE, exec, killall waybar || waybar" # toggle waybar

        # Application shortcuts
        "$mainMod, T, exec, kitty" # open terminal
        "$mainMod, F, exec, nemo" # open file manager
        "$mainMod, E, exec, kitty -o background_opacity=1 nvim" # open nvim
        "$mainMod, B, exec, hyprctl dispatch exec 'floorp'" # open browser
        "$CONTROL SHIFT, ESCAPE, exec, $scrPath/sysmonlaunch.sh" # open htop/btop if installed or default to top (system monitor)
        "$mainMod, A, exec, fuzzel" # launch desktop applications

        # Audio control
        ",XF86AudioRaiseVolume,exec, pamixer -i 2"
        ",XF86AudioLowerVolume,exec, pamixer -d 2"
        ",XF86AudioMute,exec, pamixer -t"
        ",XF86AudioPlay,exec, playerctl play-pause"
        ",XF86AudioNext,exec, playerctl next"
        ",XF86AudioPrev,exec, playerctl previous"
        ",XF86AudioStop, exec, playerctl stop"

        # Brightness control
        ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        "$mainMod, XF86MonBrightnessUp, exec, brightnessctl set 100%+"
        "$mainMod, XF86MonBrightnessDown, exec, brightnessctl set 100%-"

        # Screenshot/Screencapture
        "$mainMod, Print, exec, grimblast --notify --cursor --freeze save area ~/Pictures/$(date +'%Y-%m-%d-At-%Ih%Mm%Ss').png"
        ",Print, exec, grimblast --notify --cursor --freeze copy area"

        # Move focus with mainMod + arrow keys
        "ALT, left, movefocus, l"
        "ALT, right, movefocus, r"
        "ALT, up, movefocus, u"
        "ALT, down, movefocus, d"
        "ALT, Tab, movefocus, d"

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

        # Switch workspaces relative to the active workspace with mainMod + CTRL + [←→]
        "ALT SHIFT, right, workspace, r+1"
        "ALT SHIFT, left, workspace, r-1"

        # move to the first empty workspace instantly with mainMod + CTRL + [↓]
        "ALT CTRL, down, workspace, empty"

        # Resize windows
        "SHIFT, right, resizeactive, 30 0"
        "SHIFT, left, resizeactive, -30 0"
        "SHIFT, up, resizeactive, 0 -30"
        "SHIFT, down, resizeactive, 0 30"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Move active window to a relative workspace with mainMod + CTRL + ALT + [←→]
        "$mainMod CTRL ALT, right, movetoworkspace, r+1"
        "$mainMod CTRL ALT, left, movetoworkspace, r-1"

        # Move active window around current workspace with mainMod + SHIFT + CTRL [←→↑↓]
        "SHIFT $CONTROL, left, movewindow, l"
        "SHIFT $CONTROL, right, movewindow, r"
        "SHIFT $CONTROL, up, movewindow, u"
        "SHIFT $CONTROL, down, movewindow, d"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Special workspaces (scratchpad)
        "$mainMod ALT, S, movetoworkspacesilent, special"
        "$mainMod, S, togglespecialworkspace,"

        # Toggle Layout
        "$mainMod, J, togglesplit," # dwindle

        # Move window silently to workspace Super + Alt + [0-9]
        "$mainMod ALT, 1, movetoworkspacesilent, 1"
        "$mainMod ALT, 2, movetoworkspacesilent, 2"
        "$mainMod ALT, 3, movetoworkspacesilent, 3"
        "$mainMod ALT, 4, movetoworkspacesilent, 4"
        "$mainMod ALT, 5, movetoworkspacesilent, 5"
        "$mainMod ALT, 6, movetoworkspacesilent, 6"
        "$mainMod ALT, 7, movetoworkspacesilent, 7"
        "$mainMod ALT, 8, movetoworkspacesilent, 8"
        "$mainMod ALT, 9, movetoworkspacesilent, 9"
        "$mainMod ALT, 0, movetoworkspacesilent, 10"

        # Trigger when the switch is turning off
        ", switch:on:Lid Switch, exec, swaylock && systemctl suspend"

        # clipboard manager
        "$mainMod, V, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"
      ];

      ### original binds
      #
      # bind = [
      #   # show keybinds list
      #   "$mainMod, F1, exec, show-keybinds"
      #
      #   # keybindings
      #   "$mainMod, Return, exec, kitty"
      #   "ALT, Return, exec, kitty --title float_kitty"
      #   "$mainMod SHIFT, Return, exec, kitty --start-as=fullscreen -o 'font_size=16'"
      #   "$mainMod, B, exec, hyprctl dispatch exec '[workspace 1 silent] floorp'"
      #   "$mainMod, Q, killactive,"
      #   "$mainMod, F, fullscreen, 0"
      #   "$mainMod SHIFT, F, fullscreen, 1"
      #   "$mainMod, Space, togglefloating,"
      #   "$mainMod, D, exec, fuzzel"
      #   "$mainMod SHIFT, D, exec, hyprctl dispatch exec '[workspace 4 silent] discord --enable-features=UseOzonePlatform --ozone-platform=wayland'"
      #   "$mainMod SHIFT, S, exec, hyprctl dispatch exec '[workspace 5 silent] SoundWireServer'"
      #   "$mainMod, Escape, exec, swaylock"
      #   "$mainMod SHIFT, Escape, exec, shutdown-script"
      #   "$mainMod, P, pseudo,"
      #   "$mainMod, J, togglesplit,"
      #   "$mainMod, E, exec, nemo"
      #   "$mainMod SHIFT, B, exec, pkill -SIGUSR1 .waybar-wrapped"
      #   "$mainMod, C ,exec, hyprpicker -a"
      #   "$mainMod, W,exec, wallpaper-picker"
      #   "$mainMod SHIFT, W, exec, vm-start"
      #
      #   # screenshot
      #   "$mainMod, Print, exec, grimblast --notify --cursor --freeze save area ~/Pictures/$(date +'%Y-%m-%d-At-%Ih%Mm%Ss').png"
      #   ",Print, exec, grimblast --notify --cursor --freeze copy area"
      #
      #   # switch focus
      #   "$mainMod, left, movefocus, l"
      #   "$mainMod, right, movefocus, r"
      #   "$mainMod, up, movefocus, u"
      #   "$mainMod, down, movefocus, d"
      #
      #   # switch workspace
      #   "$mainMod, 1, workspace, 1"
      #   "$mainMod, 2, workspace, 2"
      #   "$mainMod, 3, workspace, 3"
      #   "$mainMod, 4, workspace, 4"
      #   "$mainMod, 5, workspace, 5"
      #   "$mainMod, 6, workspace, 6"
      #   "$mainMod, 7, workspace, 7"
      #   "$mainMod, 8, workspace, 8"
      #   "$mainMod, 9, workspace, 9"
      #   "$mainMod, 0, workspace, 10"
      #
      #   # same as above, but switch to the workspace
      #   "$mainMod SHIFT, 1, movetoworkspacesilent, 1" # movetoworkspacesilent
      #   "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
      #   "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
      #   "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
      #   "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
      #   "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
      #   "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
      #   "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
      #   "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
      #   "$mainMod SHIFT, 0, movetoworkspacesilent, 10"
      #   "$mainMod CTRL, c, movetoworkspace, empty"
      #
      #   # window control
      #   "$mainMod SHIFT, left, movewindow, l"
      #   "$mainMod SHIFT, right, movewindow, r"
      #   "$mainMod SHIFT, up, movewindow, u"
      #   "$mainMod SHIFT, down, movewindow, d"
      #   "$mainMod CTRL, left, resizeactive, -80 0"
      #   "$mainMod CTRL, right, resizeactive, 80 0"
      #   "$mainMod CTRL, up, resizeactive, 0 -80"
      #   "$mainMod CTRL, down, resizeactive, 0 80"
      #   "$mainMod ALT, left, moveactive,  -80 0"
      #   "$mainMod ALT, right, moveactive, 80 0"
      #   "$mainMod ALT, up, moveactive, 0 -80"
      #   "$mainMod ALT, down, moveactive, 0 80"
      #
      #   # media and volume controls
      #   ",XF86AudioRaiseVolume,exec, pamixer -i 2"
      #   ",XF86AudioLowerVolume,exec, pamixer -d 2"
      #   ",XF86AudioMute,exec, pamixer -t"
      #   ",XF86AudioPlay,exec, playerctl play-pause"
      #   ",XF86AudioNext,exec, playerctl next"
      #   ",XF86AudioPrev,exec, playerctl previous"
      #   ",XF86AudioStop, exec, playerctl stop"
      #   "$mainMod, mouse_down, workspace, e-1"
      #   "$mainMod, mouse_up, workspace, e+1"
      #
      #   # laptop brigthness
      #   ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
      #   ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      #   "$mainMod, XF86MonBrightnessUp, exec, brightnessctl set 100%+"
      #   "$mainMod, XF86MonBrightnessDown, exec, brightnessctl set 100%-"
      #
      #   # clipboard manager
      #   "$mainMod, V, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"
      # ];

      # mouse binding
      bindm = [
        # Move/Resize windows with mainMod + LMB/RMB and dragging
        "ALT, mouse:272, movewindow"
        "ALT, mouse:273, resizewindow"
      ];

      # windowrule
      windowrule = [
        "float,imv"
        "center,imv"
        "size 1200 725,imv"
        "float,mpv"
        "center,mpv"
        "tile,Aseprite"
        "size 1200 725,mpv"
        "float,title:^(float_kitty)$"
        "center,title:^(float_kitty)$"
        "size 950 600,title:^(float_kitty)$"
        "float,audacious"
        "workspace 8 silent, audacious"
        # "pin,wofi"
        # "float,wofi"
        # "noborder,wofi"
        "tile, neovide"
        "idleinhibit focus,mpv"
        "float,udiskie"
        "float,title:^(Transmission)$"
        "float,title:^(Volume Control)$"
        "float,title:^(Firefox — Sharing Indicator)$"
        "move 0 0,title:^(Firefox — Sharing Indicator)$"
        "size 700 450,title:^(Volume Control)$"
        "move 40 55%,title:^(Volume Control)$"
      ];

      # windowrulev2
      windowrulev2 = [
        "float, title:^(Picture-in-Picture)$"
        "opacity 1.0 override 1.0 override, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "opacity 1.0 override 1.0 override, title:^(.*imv.*)$"
        "opacity 1.0 override 1.0 override, title:^(.*mpv.*)$"
        "opacity 1.0 override 1.0 override, class:(Aseprite)"
        "opacity 1.0 override 1.0 override, class:(Unity)"
        "idleinhibit focus, class:^(mpv)$"
        "idleinhibit fullscreen, class:^(firefox)$"
        "float,class:^(zenity)$"
        "center,class:^(zenity)$"
        "size 850 500,class:^(zenity)$"
        "float,class:^(pavucontrol)$"
        "float,class:^(SoundWireServer)$"
        "float,class:^(.sameboy-wrapped)$"
        "float,class:^(file_progress)$"
        "float,class:^(confirm)$"
        "float,class:^(dialog)$"
        "float,class:^(download)$"
        "float,class:^(notification)$"
        "float,class:^(error)$"
        "float,class:^(confirmreset)$"
        "float,title:^(Open File)$"
        "float,title:^(branchdialog)$"
        "float,title:^(Confirm to replace files)$"
        "float,title:^(File Operation Progress)$"

        "opacity 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "maxsize 1 1,class:^(xwaylandvideobridge)$"
        "noblur,class:^(xwaylandvideobridge)$"
      ];

    };

    extraConfig = lib.mkMerge [
      (lib.mkIf (host == "laptop") ''
        # monitor=,preferred,auto,auto
        monitor = eDP-1, 1920x1200, auto, 1.25

        xwayland {
          force_zero_scaling = true
        }
      '')
      (lib.mkIf (host == "desktop") ''
        # monitor=,preferred,auto,auto
        monitor = DP-1,3840x2160@240,auto,1

        xwayland {
          force_zero_scaling = true
        }
      '')
    ];
  };
}
