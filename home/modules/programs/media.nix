{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    anki
    typst
    zathura
    obs-studio
    reaper
    spotify
    hyprshot
    sfizz-ui
    mangohud
    xiphos
  ];
}
