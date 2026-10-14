{ config, lib, pkgs, isDarwin, ... }:

{
  home.packages = with pkgs; [
    typst
    pageedit
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
