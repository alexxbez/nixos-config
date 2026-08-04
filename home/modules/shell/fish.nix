{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza --icons";
    };
    interactiveShellInit = ''
      # set -gx LD_LIBRARY_PATH /run/current-system/sw/share/nix-ld/lib $LD_LIBRARY_PATH
      # set -gx PKG_CONFIG_PATH "${pkgs.wayland.dev}/lib/pkgconfig" $PKG_CONFIG_PATH

       functions --copy fish_prompt vterm_old_fish_prompt

       function fish_prompt
           printf '\e]51;A%s\e\\' (pwd)
           vterm_old_fish_prompt
       end

      direnv hook fish | source

      COMPLETE=fish prek | source
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
