{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    chromium
    nyxt

    inputs.zen-browser.packages."${pkgs.system}".default
    inputs.zen-notes.packages.${pkgs.system}.zennotes-desktop
    inputs.zen-notes.packages.${pkgs.system}.zennotes-server
  ];
}
