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
        alabaster-themes
        ivy
        ivy-rich
        paredit
        enhanced-evil-paredit
        counsel
        mood-line
        ligature
        which-key
        helpful
        evil
        evil-collection
        evil-surround
        evil-commentary
        undo-tree
        general
        vterm
        org
        org-bullets
        visual-fill-column
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
