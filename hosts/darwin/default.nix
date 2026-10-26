{ pkgs, ... }:

{
  imports = [
    ../common/nix.nix
  ];

  nix = {
    gc = {
      automatic = true;
      interval = [
        {
          Weekday = 7;
          Hour = 3;
          Minute = 15;
        }
      ];
      options = "--delete-older-than 30d";
    };
    optimise.automatic = true;
  };

  system.stateVersion = 7;
  system.primaryUser = "alexx";

  programs.fish.enable = true;
  programs.zsh.enable = true;

  environment.shells = [
    pkgs.fish
  ];

  time.timeZone = "America/Mexico_City";

  networking = {
    computerName = "my-mac";
    hostName = "my-mac";
    localHostName = "my-mac";
  };

  security.pam.services.sudo_local = {
    enable = true;
    touchIdAuth = true;
  };

  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllExtensions = true;

    trackpad = {
      Clicking = true;
      Dragging = true;
      DragLock = true;
    };    

    NSGlobalDomain = {
      AppleShowAllExtensions = true;

      KeyRepeat = 2;
      InitialKeyRepeat = 13;
      ApplePressAndHoldEnabled = false;
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    swapCapsLockAndEscape = true;
  };

  power = {
    sleep.display = "never";
  };

  nix-homebrew = {
    enable = true;
    user = "alexx";
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
    enableFishIntegration = true;
    enableZshIntegration = true;

    brews = [
      "swiftlint"
      "swiftformat"
    ];
    
    casks = [
      # "anki"
      "calibre"
      "discord"
      "obs"
      # "obsidian"
      # "raspberry-pi-imager"
      "sigil"
      "spotify"
      "zed"
      "zen"
      "google-chrome"
      "kitty"
      "ghostty"
      "nikitabobko/tap/aerospace"
      "docker-desktop"
    ];
  };
}
