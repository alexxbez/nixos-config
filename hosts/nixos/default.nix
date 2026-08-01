{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common
    ./boot.nix
    ./desktop.nix
    ./nvidia.nix
    ./kmonad.nix
    ./gaming.nix
    ../../modules/nixos
    ../../overlays
  ];

  networking.hostName = "nixos"; # Define your hostname.
}
