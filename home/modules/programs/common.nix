{ config, lib, pkgs, isDarwin, ... }:

{
  home.packages = with pkgs; [
    bun
    neovim
    helix
    cmake
    gnumake
    gcc
    nerd-fonts.hasklug
    nerd-fonts.jetbrains-mono
    libertinus
    eb-garamond
    kitty
    git
    fzf
    clang-tools
    nodejs
    typescript
    typescript-language-server
    pyright
    racket
    tinymist
    codebook
    nil
    javaPackages.compiler.openjdk21
    leiningen
    direnv
    opencode
    luaPackages.fennel
    fennel-ls
    prek
    go
    gopls
    zellij
    dotnet-sdk
    csharp-ls
    omnisharp-roslyn
    mono
    ibm-plex
    atkinson-hyperlegible
    noto-fonts
    safe-rm
    ghc
    fluidsynth
    libqalculate
    android-tools
  ] ++ lib.optionals (!isDarwin) [
    zed-editor
    obsidian
    discord
    kmonad
    localsend
    calibre
    protonup-ng
    sigil
    pageedit
    cisco-packet-tracer_9
    rpi-imager
    wayland
  ];

  fonts.fontconfig.enable = lib.mkIf (!isDarwin) true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "alexxbez";
      user.email = "alexxbez@proton.me";
      init.defaultBranch = "main";
    };
  };
}
