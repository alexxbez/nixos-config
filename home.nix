{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home.username = "alexx";
  home.homeDirectory = "/home/alexx";
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        density = "default";
        position = "left";
        showCapsule = false;

        widgets = {
          left = [
            {
              id = "Launcher";
            }
            {
              id = "Clock";
            }
            {
              id = "SystemMonitor";
            }
          ];

          center = [
            {
              id = "Workspace";
            }
          ];

          right = [
            {
              id = "NotificationHistory";
            }
            {
              id = "Battery";
            }
            {
              id = "Volume";
            }
            {
              id = "Brightness";
            }
            {
              id = "ControlCenter";
            }
          ];
        };
      };
      colorSchemes = {
        useWallpaperColors = false;
        darkMode = false;
        predefinedScheme = "Rose Pine";
      };
    };
  };

  home.file."cache/noctalia/wallpapers.json" = {
    text = builtins.toJSON {
      defaultWallpaper = "/home/alexx/Pictures/Wallpapers/wallpaper.png";
    };
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    chromium
    bun
    neovim
    cmake
    gnumake
    nerd-fonts.hasklug
    nerd-fonts.jetbrains-mono
    kitty
    git
    fzf
    gcc
    nodejs
    typescript
    typescript-language-server
    jetbrains-toolbox
    jetbrains.webstorm
    jetbrains.datagrip
    jetbrains.pycharm
    zed-editor
    anki
    typst
    zathura
    pyright
    racket
    tinymist
    nil
    obs-studio
    cisco-packet-tracer_9
    reaper
  ];

  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11.0;
    };

    settings = {
      disable_ligatures = "cursor";

      cursor_shape = "block";
      shell_integration = "no-cursor";
      cursor_shape_unfocused = "hollow";
      cursor_blink_interval = 1;
      cursor_stop_blinking_after = 3;

      cursor_trail = 1;
      cursor_trail_start_threshold = 1;

      scrollback_lines = 2000;
      scrollback_indicator_opacity = 0.2;
      scrollback_fill_enlarged_window = "yes";

      mouse_hide_wait = 2.0;
      copy_on_select = "a1";
      focus_follows_mouse = "yes";

      sync_to_monitor = "yes";

      window_border_width = "10px";
      draw_minimal_borders = "yes";
      window_margin_width = 0;
      hide_window_decorations = "yes";
      confirm_os_window_close = 0;
      enable_audio_bell = "no";
      window_padding_width = "0 5";

      linux_display_server = "wayland";

      foreground = "#000000";
      background = "#f7f7f7";

      selection_foreground = "#000000";
      selection_background = "#bfdbfe";

      cursor = "#007acc";
      cursor_text_color = "#bfdbfe";

      url_color = "#325cc0";

      active_border_color = "#777777";
      inactive_border_color = "#cccccc";
      bell_border_color = "#e97e57";

      active_tab_foreground = "#000000";
      active_tab_background = "#f7f7f7";

      inactive_tab_foreground = "#444444";
      inactive_tab_background = "#dedede";

      color0 = "#000000";
      color8 = "#777777";

      color1 = "#aa3731";
      color9 = "#f05050";

      color2 = "#448c37";
      color10 = "#60cb00";

      color3 = "#cb9000";
      color11 = "#ffbc5d";

      color4 = "#325cc0";
      color12 = "#007acc";

      color5 = "#7a3e9d";
      color13 = "#e64ce6";

      color6 = "#0083b2";
      color14 = "#00aacb";

      color7 = "#bbbbbb";
      color15 = "#ffffff";
    };

    extraConfig = ''
      map ctrl+j send_text all \x1b[B
      map ctrl+k send_text all \x1b[A
      map shift+cmd+v paste_from_buffer a1
      map ctrl+backspace send_text all \x17
    '';
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "noctalia-shell"
        "hyprctl dispatch workspace 1"
      ];

      monitor = [
        "eDP-1,preferred,auto,1.0"
        "HDMI-A-1,highrr,auto-up,1"
      ];

      workspace = [
        "1, monitor:eDP-2"
        "2, monitor:eDP-2"
        "3, monitor:eDP-2"
        "4, monitor:eDP-2"
        "5, monitor:eDP-2"
        "6, monitor:eDP-2"
        "7, monitor:eDP-2"
        "8, monitor:eDP-2"
        "9, monitor:eDP-2"
        "10, monitor:eDP-2"
        "11, monitor:HDMI-A-1"
        "12, monitor:HDMI-A-1"
        "13, monitor:HDMI-A-1"
        "14, monitor:HDMI-A-1"
        "15, monitor:HDMI-A-1"
        "16, monitor:HDMI-A-1"
        "17, monitor:HDMI-A-1"
        "18, monitor:HDMI-A-1"
        "19, monitor:HDMI-A-1"
        "20, monitor:HDMI-A-1"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 1;
        "col.active_border" = "rgb(EBDBB2)";
        "col.inactive_border" = "rgba(31313600)";
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        active_opacity = 0.9;
        inactive_opacity = 0.7;
        rounding = 20;
        blur = {
          enabled = true;
          size = 10;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
          xray = false;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, once"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = 1;
        disable_hyprland_logo = true;
        vrr = 1;
        vfr = true;
      };

      input = {
        kb_layout = "us,latam";
        kb_options = "grp:alt_shift_toggle";
        repeat_delay = 300;
        repeat_rate = 40;
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          "tap-to-click" = true;
          "tap-and-drag" = true;
          drag_lock = true;
        };
      };

      device = [
        {
          name = "foostan-corne-v4-keyboard";
          kb_layout = "us";
          kb_variant = "altgr-intl";
        }
      ];

      windowrule = [
        "suppress_event maximize, match:class .*"
        "no_focus on, match:class ^$, match:title ^$, match:xwayland true, match:float true, match:fullscreen false, match:pin false"
        "no_initial_focus on, match:class ^jetbrains-.*$, match:float true, match:title (^$|^\\s$|^win\\d+$)"

        "float true, match:title qalc-popup"
        "size 600 400, match:title qalc-popup"
        "center true, match:title qalc-popup"

        # PacketTracer WindowRules
        "no_initial_focus on, match:class PacketTracer"
        "float on, match:class PacketTracer"
        "no_anim on, match:class PacketTracer"
        "no_blur on, match:class PacketTracer"
        "no_dim on, match:class PacketTracer"
        "no_shadow on, match:class PacketTracer"
        "opaque on, match:class PacketTracer"
        "immediate on, match:class PacketTracer"
        "border_size 0, match:class PacketTracer"
        "rounding 0, match:class PacketTracer"
        "decorate 0, match:class PacketTracer"
        "nearest_neighbor on, match:class PacketTracer"
        "xray on, match:class PacketTracer"
        "min_size 1 1, match:class PacketTracer"

        "keep_aspect_ratio on, match:class PacketTracer, match:title Cisco Packet Tracer"
        "focus_on_activate on, match:class PacketTracer, match:title Cisco Packet Tracer"

        # "stayfocused, match:class PacketTracer, match:title Preference"

        "min_size 486 628, match:class PacketTracer, match:title Preference"
        "min_size 486 628, match:class PacketTracer, match:title .*outer.*"
        "min_size 772 700, match:class PacketTracer, match:title .*witch.*"
        "min_size 807 655, match:class PacketTracer, match:title .*PC.*"
        "min_size 791 648, match:class PacketTracer, match:title .*Save File.*"
      ];

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, T, exec, kitty"
        "$mainMod, Q, killactive"
        "$mainMod, B, exec, firefox"
        "$mainMod, V, togglefloating"
        "$mainMod, space, exec, noctalia-shell ipc call launcher toggle"
        "$mainMod, C, exec, kitty --title qalc-popup qalc"
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
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
        "$mainMod CTRL, 1, workspace, 11"
        "$mainMod CTRL, 2, workspace, 12"
        "$mainMod CTRL, 3, workspace, 13"
        "$mainMod CTRL, 4, workspace, 14"
        "$mainMod CTRL, 5, workspace, 15"
        "$mainMod CTRL, 6, workspace, 16"
        "$mainMod CTRL, 7, workspace, 17"
        "$mainMod CTRL, 8, workspace, 18"
        "$mainMod CTRL, 9, workspace, 19"
        "$mainMod CTRL, 0, workspace, 20"
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
        "$mainMod CTRL SHIFT, 1, movetoworkspace, 11"
        "$mainMod CTRL SHIFT, 2, movetoworkspace, 12"
        "$mainMod CTRL SHIFT, 3, movetoworkspace, 13"
        "$mainMod CTRL SHIFT, 4, movetoworkspace, 14"
        "$mainMod CTRL SHIFT, 5, movetoworkspace, 15"
        "$mainMod CTRL SHIFT, 6, movetoworkspace, 16"
        "$mainMod CTRL SHIFT, 7, movetoworkspace, 17"
        "$mainMod CTRL SHIFT, 8, movetoworkspace, 18"
        "$mainMod CTRL SHIFT, 9, movetoworkspace, 19"
        "$mainMod CTRL SHIFT, 0, movetoworkspace, 20"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      binde = [
        "$mainMod SHIFT, l, resizeactive, 10 0"
        "$mainMod SHIFT, h, resizeactive, -10 0"
        "$mainMod SHIFT, k, resizeactive, 0 -10"
        "$mainMod SHIFT, j, resizeactive, 0 10"
        "$mainMod SHIFT, right, resizeactive, 10 0"
        "$mainMod SHIFT, left, resizeactive, -10 0"
        "$mainMod SHIFT, up, resizeactive, 0 -10"
        "$mainMod SHIFT, down, resizeactive, 0 10"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza --icons";
    };
    interactiveShellInit = ''
      set -gx LD_LIBRARY_PATH /run/current-system/sw/share/nix-ld/lib $LD_LIBRARY_PATH
    '';
  };

  programs.zsh = {
    enable = false;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    sessionVariables.EDITOR = "nvim";
    defaultKeymap = "emacs";

    shellAliases = {
      ls = "eza --icons";
    };
  };

  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;

      format = ''
        [╭─](fg:#6b6b6b)[$directory](fg:#6b6b6b)[  $git_branch](fg:#6b6b6b)
        [╰─](fg:#6b6b6b)$character
      '';

      character = {
        success_symbol = "[](bold green)";
        error_symbol = "[](bold red)";
      };

      directory = {
        format = "$path";
        truncation_length = 3;
        home_symbol = "~";
      };

      git_branch = {
        format = "$branch";
      };
    };
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    icons = "auto";
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    options = [
      "--cmd"
      "cd"
    ];
  };
}
