{ config, pkgs, inputs, ... }:

{
  home.username = "alexx";
  home.homeDirectory = "/home/alexx";
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  imports = [
    inputs.noctalia.homeModules.default
    ../modules
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        density = "default";
        position = "left";
        showCapsule = false;

        widgets = {
          left = [
            {
              id = "Launcher";
            }
            {
              id = "Clock";
            }
            {
              id = "SystemMonitor";
            }
          ];

          center = [
            {
              id = "Workspace";
            }
          ];

          right = [
            {
              id = "NotificationHistory";
            }
            {
              id = "Battery";
            }
            {
              id = "Volume";
            }
            {
              id = "Brightness";
            }
            {
              id = "ControlCenter";
            }
          ];
        };
      };
      colorSchemes = {
        useWallpaperColors = false;
        darkMode = true;
        predefinedScheme = "Monochrome";
      };
    };
  };

  home.file."cache/noctalia/wallpapers.json" = {
    text = builtins.toJSON {
      defaultWallpaper = "/home/alexx/Pictures/Wallpapers/wallpaper.png";
    };
  };
}
