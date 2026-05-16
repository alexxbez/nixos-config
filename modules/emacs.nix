{ config, pkgs, ... }:

{
  programs.emacs = {
    enable = true;

    # Wayland-native Emacs
    package = pkgs.emacs-pgtk;

    # Nix-managed Emacs packages go here
    extraPackages =
      epkgs: with epkgs; [
        # example:
        # vertico
        # consult
        # magit
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
