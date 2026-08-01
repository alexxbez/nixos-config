{ ... }:

{
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

      foreground = "#bbbbbb";
      background = "#191919";

      selection_foreground = "#191919";
      selection_background = "#404040";

      cursor = "#c9c9c9";
      cursor_text_color = "#191919";

      url_color = "#66a5ad";

      active_border_color = "#6099c0";
      inactive_border_color = "#3d3839";

      bell_border_color = "#de6e7c";
      visual_bell_color = "none";

      wayland_titlebar_color = "#191919";
      macos_titlebar_color = "#191919";

      active_tab_foreground = "#191919";
      active_tab_background = "#bbbbbb";

      inactive_tab_foreground = "#8e8e8e";
      inactive_tab_background = "#2c2c2c";

      tab_bar_background = "#191919";
      tab_bar_margin_color = "none";

      mark1_foreground = "#191919";
      mark1_background = "#6099c0";

      mark2_foreground = "#191919";
      mark2_background = "#b279a7";

      mark3_foreground = "#191919";
      mark3_background = "#819b69";

      color0 = "#191919";
      color8 = "#3d3839";

      color1 = "#de6e7c";
      color9 = "#e8838f";

      color2 = "#819b69";
      color10 = "#8bae68";

      color3 = "#b77e64";
      color11 = "#d68c67";

      color4 = "#6099c0";
      color12 = "#61abda";

      color5 = "#b279a7";
      color13 = "#cf86c1";

      color6 = "#66a5ad";
      color14 = "#65b8c1";

      color7 = "#bbbbbb";
      color15 = "#8e8e8e";
    };

    extraConfig = ''
      map ctrl+j send_text all \x1b[B
      map ctrl+k send_text all \x1b[A
      map shift+cmd+v paste_from_buffer a1
      map ctrl+backspace send_text all \x17
    '';
  };
}
