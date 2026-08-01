{ config, lib, pkgs, ... }:

{
  # Experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.settings.auto-optimise-store = true;

  services.envfs.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libpulseaudio
    libGL
    xorg.libX11
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    alsa-lib
    mesa
    fontconfig
    freetype
  ];

  environment.localBinInPath = true;

  # This value being lower than the current NixOS release does NOT mean your system
  # is out of date, out of support, or vulnerable.
  system.stateVersion = "25.11";
}
