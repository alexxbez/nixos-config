{ config, lib, pkgs, isDarwin, ... }:

{
  home.packages = with pkgs; [
    typst
  ] ++ lib.optionals (!isDarwin) [
    anki
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
