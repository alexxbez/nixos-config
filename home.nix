{ config, pkgs, inputs, ... }:

{
  home.username = "alexx";
  home.homeDirectory = "/home/alexx";

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  imports  = [
    inputs.noctalia.homeModules.default
  ];


  programs.noctalia-shell = {
    enable = true;

    settings = {
      bar = {
        density = "compact";
        position = "left";
        showCapsule = false;
      };

      colorSchemes.predefinedScheme = "Monochrome";
    };
  };

  home.packages = with pkgs; [
    chromium

    bun
    neovim
    cmake
    gnumake
    alacritty
    git 
    fzf
    gcc

    nodejs
    typescript
    typescript-language-server

    jetbrains-toolbox
    jetbrains.webstorm
    jetbrains.datagrip

    zed-editor
  ]; 

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
