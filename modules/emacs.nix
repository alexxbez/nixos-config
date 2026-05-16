{ config, pkgs, ... }:

{
  programs.emacs = {
    enable = true;

    # Wayland-native Emacs
    package = pkgs.emacs-pgtk;

    # Nix-managed Emacs packages go here
    extraPackages =
      epkgs: with epkgs; [
        use-package
        base16-theme
        ivy
        ivy-rich
        paredit
        counsel
        mood-line
        ligature
        which-key
      ];
  };

  # Emacs daemon
  services.emacs = {
    enable = true;
    defaultEditor = true;
  };

  # Link your init.el into ~/.config/emacs/
  home.file.".config/emacs/init.el".source = ../emacs/init.el;
}
