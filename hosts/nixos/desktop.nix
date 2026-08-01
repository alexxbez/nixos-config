{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  hardware.graphics.enable = true;

  programs.hyprland.enable = true;
  programs.xwayland.enable = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  programs.firefox.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim
    wget
    git

    mesa
    libglvnd
    xwayland
    libGL
    glib

    fontconfig
    freetype
    nss

    pipewire.jack

    wl-clipboard

    qmk
    via
  ];

  hardware.keyboard.qmk.enable = true;
  services.udev.packages = [ pkgs.via ];

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
  };

  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
}
