{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bun
    neovim
    helix
    cmake
    gnumake
    nerd-fonts.hasklug
    nerd-fonts.jetbrains-mono
    libertinus
    eb-garamond
    kitty
    git
    fzf
    gcc
    clang-tools
    nodejs
    typescript
    typescript-language-server
    zed-editor
    pyright
    racket
    tinymist
    codebook
    nil
    javaPackages.compiler.openjdk21
    leiningen
    obsidian
    kmonad
    localsend
    wayland
    direnv
    discord
    calibre
    protonup-ng
    opencode
    luaPackages.fennel
    fennel-ls
    prek
    unityhub
    go
  ];

  fonts.fontconfig.enable = true;
}
