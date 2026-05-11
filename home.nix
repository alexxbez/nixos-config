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
