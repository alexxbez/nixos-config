{ ... }:

{
  # Experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;
}
