{ pkgs, lib, isDarwin, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza --icons";
    };
    interactiveShellInit = ''
      functions --copy fish_prompt vterm_old_fish_prompt

      function fish_prompt
          printf '\e]51;A%s\e\\' (pwd)
          vterm_old_fish_prompt
      end

      direnv hook fish | source

      COMPLETE=fish prek | source
    '' + lib.optionalString (!isDarwin) ''
      # set -gx LD_LIBRARY_PATH /run/current-system/sw/share/nix-ld/lib $LD_LIBRARY_PATH
      # set -gx PKG_CONFIG_PATH "${pkgs.wayland.dev}/lib/pkgconfig" $PKG_CONFIG_PATH
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
}
