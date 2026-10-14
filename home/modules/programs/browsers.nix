{ config, lib, pkgs, inputs, isDarwin, ... }:

{
  home.packages = lib.optionals (!isDarwin) (with pkgs; [
    chromium
    nyxt

    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
  ]);
}
