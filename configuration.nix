# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  programs.hyprland.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  # Set your time zone.
  time.timeZone = "America/Mexico_City";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.settings.auto-optimise-store = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  services.envfs.enable = true;

  programs.nix-ld.enable = true;
  environment.localBinInPath = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  hardware.graphics.enable = true;

  programs.xwayland.enable = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Git configuration
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "alexxbez";
        email = "alexxbez@proton.me";
      };
      init.defaultBranch = "main";
    };
  };

  # Start ssh agent
  # programs.ssh.startAgent = true;
  # apparently gnome ssh agent is already on

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alexx = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "input"
      "uinput"
      "audio"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  # might need for keyboard, idk
  # services.libinput.enable = true;

  # Noctalia pre-built binaries
  # nix.settings = {
  #   extra-substituters = [ "https://noctalia.cachix.org" ];
  #   extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  # };

  # xdg.portal = {
  #   enable = true;
  #
  #   extraPortals = with pkgs; [
  #     xdg-desktop-portal-gnome
  #   ];
  # };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
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

    inputs.zen-browser.packages."${pkgs.system}".default

    wl-clipboard
  ];

  virtualisation.docker = {
    enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    5173
    8383
    9090
    8080
  ];

  # Kmonad
  boot.kernelModules = [ "uinput" ];

  users.groups.uinput = { };
  users.groups.input = { };

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  environment.etc."kmonad/main.kbd".text = ''
    (defcfg
      ;; if this ever breaks, use 'sudo evtest'
      input  (device-file "/dev/input/by-id/usb-ASUSTek_Computer_Inc._N-KEY_Device-event-mouse")
      output (uinput-sink "KMonad Virtual Keyboard")
      fallthrough true
      allow-cmd false
    )

    (defsrc
      caps
      lctrl
    )

    (deflayer base
      @caps-ctrl-esc
      lctrl
    )

    (defalias
      caps-ctrl-esc (tap-hold 150 esc lctrl)
    )
  '';

  systemd.services.kmonad = {
    description = "KMonad keyboard remapping";

    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-udevd.service" ];

    serviceConfig = {
      ExecStart = "${pkgs.kmonad}/bin/kmonad /etc/kmonad/main.kbd";
      Restart = "always";
      RestartSec = 3;

      DynamicUser = false;
    };
  };

  # NVIDIA
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "i915.fastboot=1"
  ];

  boot.initrd.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];

  specialisation = {
    gaming.configuration = {
      hardware.nvidia = {
        prime.sync.enable = lib.mkForce true;
        prime.offload = {
          enable = lib.mkForce false;
          enableOffloadCmd = lib.mkForce false;
        };
      };
    };
  };

  systemd.services.nvidia-resume.enable = true;

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  programs.gamemode.enable = true;

  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}
