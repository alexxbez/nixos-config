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
              id = "ControlCenter";
            }
          ];
        };
      };
      colorSchemes = {
        useWallpaperColors = false;
        predefinedScheme = "Gruvbox";
      };
    };
  };

  home.file."cache/noctalia/wallpapers.json" = {
    text = builtins.toJSON {
      defaultWallpaper = "/home/alexx/Pictures/Wallpapers/wallpaper.png";
    };
  };

  programs.niri.settings = {

    input = {
      keyboard = {
        numlock = true;
        xkb = {
          options = "caps:swapescape";
          variant = "altgr-intl";
        };

        repeat-delay = 325;
        repeat-rate = 50;
      };
      touchpad = {
        tap = true;
        drag-lock = true;
        natural-scroll = true;

      };

      focus-follows-mouse.enable = true;
    };

    layout = {
      gaps = 12;
      center-focused-column = "never";

      preset-column-widths = [
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
      ];

      default-column-width.proportion = 0.5;

      focus-ring = {
        enable = true;
        width = 1;
        active.color = "#7fc8ff";
        inactive.color = "#505050";
      };

      border = {
        enable = false;
        width = 0;
        active.color = "#ffc87f";
        inactive.color = "#505050";
        urgent.color = "#9b0000";
      };

      shadow = {
        enable = false;
        softness = 30;
        spread = 5;
        offset = {
          x = 0;
          y = 5;
        };
        color = "#00000070";
      };
    };

    hotkey-overlay.skip-at-startup = false;

    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

    animations.enable = true;

    spawn-at-startup = [
      { argv = [ "noctalia-shell" ]; }
    ];

    window-rules = [
      # General windows rules
      {
        geometry-corner-radius = {
          bottom-left = 20.0;
          bottom-right = 20.0;
          top-left = 20.0;
          top-right = 20.0;
        };

        clip-to-geometry = true;
      }

      # WezTerm initial configure bug workaround
      {
        matches = [ { app-id = "^org\\.wezfurlong\\.wezterm$"; } ];
        default-column-width = { };
      }
      # Firefox PiP floating
      {
        matches = [
          {
            app-id = "firefox$";
            title = "^Picture-in-Picture$";
          }
        ];
        open-floating = true;
      }

      {
        matches = [ { app-id = "^foot$"; } ];
        opacity = 1.0;
      }
    ];

    binds =
      with {
        sh = s: {
          spawn = [
            "sh"
            "-c"
            s
          ];
        };
      }; {
        "Mod+Shift+Slash".action.show-hotkey-overlay = [ ];
        "Mod+T".action.spawn = "kitty";
        "Super+Space".action.spawn-sh = "noctalia-shell ipc call launcher toggle";
        "Super+W".action.spawn-sh = "noctalia-shell ipc call wallpaper toggle";
        "Super+Alt+L".action.spawn-sh = "noctalia-shell ipc call lockScreen lock";
        "Super+Alt+S" = {
          allow-inhibiting = false;
          action = sh "pkill orca || exec orca";
        };

        "Super+B".action.spawn = "firefox";

        # Volume
        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0";
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          action = sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };
        "XF86AudioMicMute" = {
          allow-when-locked = true;
          action = sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        };

        # Media
        "XF86AudioPlay" = {
          allow-when-locked = true;
          action = sh "playerctl play-pause";
        };
        "XF86AudioStop" = {
          allow-when-locked = true;
          action = sh "playerctl stop";
        };
        "XF86AudioPrev" = {
          allow-when-locked = true;
          action = sh "playerctl previous";
        };
        "XF86AudioNext" = {
          allow-when-locked = true;
          action = sh "playerctl next";
        };

        # Brightness
        "XF86MonBrightnessUp" = {
          allow-when-locked = true;
          action.spawn = [
            "brightnessctl"
            "--class=backlight"
            "set"
            "+10%"
          ];
        };
        "XF86MonBrightnessDown" = {
          allow-when-locked = true;
          action.spawn = [
            "brightnessctl"
            "--class=backlight"
            "set"
            "10%-"
          ];
        };

        # Overview / window management
        "Mod+O" = {
          repeat = false;
          action.toggle-overview = [ ];
        };
        "Mod+Q" = {
          repeat = false;
          action.close-window = [ ];
        };

        # Focus movement
        "Mod+Left".action.focus-column-left = [ ];
        "Mod+Down".action.focus-window-down = [ ];
        "Mod+Up".action.focus-window-up = [ ];
        "Mod+Right".action.focus-column-right = [ ];
        "Mod+H".action.focus-column-left = [ ];
        "Mod+J".action.focus-window-down = [ ];
        "Mod+K".action.focus-window-up = [ ];
        "Mod+L".action.focus-column-right = [ ];

        # Move windows
        "Mod+Ctrl+Left".action.move-column-left = [ ];
        "Mod+Ctrl+Down".action.move-window-down = [ ];
        "Mod+Ctrl+Up".action.move-window-up = [ ];
        "Mod+Ctrl+Right".action.move-column-right = [ ];
        "Mod+Ctrl+H".action.move-column-left = [ ];
        "Mod+Ctrl+J".action.move-window-down = [ ];
        "Mod+Ctrl+K".action.move-window-up = [ ];
        "Mod+Ctrl+L".action.move-column-right = [ ];

        # First/last
        "Mod+Home".action.focus-column-first = [ ];
        "Mod+End".action.focus-column-last = [ ];
        "Mod+Ctrl+Home".action.move-column-to-first = [ ];
        "Mod+Ctrl+End".action.move-column-to-last = [ ];

        # Monitor focus
        "Mod+Shift+Left".action.focus-monitor-left = [ ];
        "Mod+Shift+Down".action.focus-monitor-down = [ ];
        "Mod+Shift+Up".action.focus-monitor-up = [ ];
        "Mod+Shift+Right".action.focus-monitor-right = [ ];
        "Mod+Shift+H".action.focus-monitor-left = [ ];
        "Mod+Shift+J".action.focus-monitor-down = [ ];
        "Mod+Shift+K".action.focus-monitor-up = [ ];
        "Mod+Shift+L".action.focus-monitor-right = [ ];

        # Move to monitor
        "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = [ ];
        "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = [ ];
        "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = [ ];
        "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = [ ];
        "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = [ ];
        "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = [ ];
        "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = [ ];
        "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = [ ];

        # Workspaces
        "Mod+Page_Down".action.focus-workspace-down = [ ];
        "Mod+Page_Up".action.focus-workspace-up = [ ];
        "Mod+U".action.focus-workspace-down = [ ];
        "Mod+I".action.focus-workspace-up = [ ];
        "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = [ ];
        "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = [ ];
        "Mod+Ctrl+U".action.move-column-to-workspace-down = [ ];
        "Mod+Ctrl+I".action.move-column-to-workspace-up = [ ];
        "Mod+Shift+Page_Down".action.move-workspace-down = [ ];
        "Mod+Shift+Page_Up".action.move-workspace-up = [ ];
        "Mod+Shift+U".action.move-workspace-down = [ ];
        "Mod+Shift+I".action.move-workspace-up = [ ];

        # Workspace by number
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
        "Mod+Ctrl+1".action.move-column-to-workspace = 1;
        "Mod+Ctrl+2".action.move-column-to-workspace = 2;
        "Mod+Ctrl+3".action.move-column-to-workspace = 3;
        "Mod+Ctrl+4".action.move-column-to-workspace = 4;
        "Mod+Ctrl+5".action.move-column-to-workspace = 5;
        "Mod+Ctrl+6".action.move-column-to-workspace = 6;
        "Mod+Ctrl+7".action.move-column-to-workspace = 7;
        "Mod+Ctrl+8".action.move-column-to-workspace = 8;
        "Mod+Ctrl+9".action.move-column-to-workspace = 9;

        # Wheel scrolling
        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          action.focus-workspace-down = [ ];
        };
        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          action.focus-workspace-up = [ ];
        };
        "Mod+Ctrl+WheelScrollDown" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-down = [ ];
        };
        "Mod+Ctrl+WheelScrollUp" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-up = [ ];
        };
        "Mod+WheelScrollRight".action.focus-column-right = [ ];
        "Mod+WheelScrollLeft".action.focus-column-left = [ ];
        "Mod+Ctrl+WheelScrollRight".action.move-column-right = [ ];
        "Mod+Ctrl+WheelScrollLeft".action.move-column-left = [ ];
        "Mod+Shift+WheelScrollDown".action.focus-column-right = [ ];
        "Mod+Shift+WheelScrollUp".action.focus-column-left = [ ];
        "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = [ ];
        "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = [ ];

        # Column/window sizing
        "Mod+BracketLeft".action.consume-or-expel-window-left = [ ];
        "Mod+BracketRight".action.consume-or-expel-window-right = [ ];
        "Mod+Comma".action.consume-window-into-column = [ ];
        "Mod+Period".action.expel-window-from-column = [ ];
        "Mod+R".action.switch-preset-column-width = [ ];
        "Mod+Shift+R".action.switch-preset-window-height = [ ];
        "Mod+Ctrl+R".action.reset-window-height = [ ];
        "Mod+F".action.maximize-column = [ ];
        "Mod+Shift+F".action.fullscreen-window = [ ];
        "Mod+M".action.maximize-window-to-edges = [ ];
        "Mod+Ctrl+F".action.expand-column-to-available-width = [ ];
        "Mod+C".action.center-column = [ ];
        "Mod+Ctrl+C".action.center-visible-columns = [ ];
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        # Floating / tabbed
        "Mod+V".action.toggle-window-floating = [ ];
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [ ];
        "Mod+W".action.toggle-column-tabbed-display = [ ];

        # Screenshots
        "Mod+S".action.screenshot = [ ];
        "Ctrl+Print".action.screenshot-screen = [ ];
        "Alt+Print".action.screenshot-window = [ ];

        # Misc
        "Mod+Escape" = {
          allow-inhibiting = false;
          action.toggle-keyboard-shortcuts-inhibit = [ ];
        };
        "Mod+Shift+E".action.quit = [ ];
        "Ctrl+Alt+Delete".action.quit = [ ];
        "Mod+Shift+P".action.power-off-monitors = [ ];
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
  ];

  programs.kitty = {
    enable = true;

    font = {
      name = "Hasklug Nerd Font Mono";
      size = 11.0;
    };

    extraConfig = ''
      disable_ligatures cursor

      # arrow mapping
      map ctrl+j send_text all \x1b[B
      map ctrl+k send_text all \x1b[A

      # cursor customization 
      cursor_shape block
      shell_integration no-cursor
      cursor_shape_unfocused hollow
      cursor_blink_interval 1
      cursor_stop_blinking_after 3

      cursor_trail 1
      cursor_trail_start_threshold 1

      # Scrollback 
      scrollback_lines 2000
      scrollback_indicator_opacity 0.2
      scrollback_fill_enlarged_window yes

      # Mouse
      mouse_hide_wait 2.0
      copy_on_select a1
      map shift+cmd+v paste_from_buffer a1
      focus_follows_mouse yes

      # Performance
      sync_to_monitor yes

      # Windows
      window_border_width 10px
      draw_minimal_borders yes
      window_margin_width 0
      hide_window_decorations yes
      confirm_os_window_close 0
      enable_audio_bell no
      window_padding_width 0 5

      linux_display_server wayland

      # Colors
      cursor #928374
      cursor_text_color background
      url_color #83a598
      visual_bell_color #8ec07c
      bell_border_color #8ec07c

      active_border_color #d3869b
      inactive_border_color #665c54

      foreground #ebdbb2
      background #282828
      selection_foreground #928374
      selection_background #ebdbb2

      active_tab_foreground #fbf1c7
      active_tab_background #665c54
      inactive_tab_foreground #a89984
      inactive_tab_background #3c3836

      color0  #665c54
      color8  #7c6f64
      color1  #cc241d
      color9  #fb4934
      color2  #98971a
      color10 #b8bb26
      color3  #d79921
      color11 #fabd2f
      color4  #458588
      color12 #83a598
      color5  #b16286
      color13 #d3869b
      color6  #689d6a
      color14 #8ec07c
      color7  #a89984
      color15 #bdae93

      map ctrl+backspace send_text all \x17
    '';
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      bind = [ "$mod, T, exec, kitty" ];
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
