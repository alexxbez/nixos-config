{ config, lib, pkgs, inputs, isDarwin, ... }:

{
  home.username = "alexx";
  home.homeDirectory = lib.mkForce (
    if isDarwin then "/Users/alexx" else "/home/alexx"
  );
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  imports = [
    ../modules
  ] ++ (if isDarwin then [ ./darwin.nix ] else [ ./linux.nix ]);
}
