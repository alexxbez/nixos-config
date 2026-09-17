{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    chromium
    nyxt

    inputs.zen-browser.packages."${pkgs.system}".default
  ];
}
