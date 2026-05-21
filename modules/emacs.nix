{ config, pkgs, ... }:
let
  emacs-with-grammars = pkgs.emacs-pgtk.overrideAttrs (old: {
    buildInputs = (old.buildInputs or []) ++ [
      pkgs.tree-sitter-grammars.tree-sitter-typst
    ];
  });
in
{
  programs.emacs = {
    enable = true;
    package = (pkgs.emacsPackagesFor emacs-with-grammars).emacsWithPackages (epkgs: with epkgs; [
      treesit-grammars.with-all-grammars
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
    ]);
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
  };

  home.file.".config/emacs/init.el".source = ../emacs/init.el;
}
