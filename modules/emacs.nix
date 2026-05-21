{ config, pkgs, ... }:
let
  emacs-with-grammars = pkgs.emacs-pgtk.pkgs.withPackages (epkgs: [
    epkgs.treesit-grammars.with-all-grammars
  ]);
in
{
  programs.emacs = {
    enable = true;
    package = emacs-with-grammars;
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
        corfu
        eldoc-box
        jinx
        pdf-tools
        cuda-mode
        rust-mode
        typst-ts-mode
      ];
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
  };

  home.file.".config/emacs/init.el".source = ../emacs/init.el;
}
