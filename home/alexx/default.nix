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

  programs.noctalia = {
    enable = true;
    settings = ./noctalia-full-config.toml;
  };

  home.file."cache/noctalia/wallpapers.json" = {
    text = builtins.toJSON {
      defaultWallpaper = "/home/alexx/Pictures/Wallpapers/wallpaper.png";
    };
  };
}
