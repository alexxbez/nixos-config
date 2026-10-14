# Nix Configuration

Multi-host flake for `alexx`, sharing a single Home Manager configuration across
NixOS (`nixos`) and macOS (`my-mac`, via nix-darwin).

## Concepts

- **Host** — the machine. Selects the flake output (`nixosConfigurations.nixos`,
  `darwinConfigurations.my-mac`) and sets `networking.hostName`.
- **User** — the login account, `alexx`. Configured once via
  `home-manager.users.alexx` and shared by every host.

## Structure

```
.
├── flake.nix            # entry point: NixOS + nix-darwin outputs
├── flake.lock           # pinned inputs
├── hosts/               # per-host system configuration
│   ├── common/          # shared, cross-platform Nix settings (nix.nix)
│   │   └── ...          # NixOS-only base/locale/networking/users/programs
│   ├── nixos/           # Linux host
│   └── darwin/          # macOS host (nix-darwin + Homebrew casks)
├── home/                # Home Manager configuration (shared)
│   ├── alexx/           # user entry point
│   │   ├── default.nix  # shared, picks linux.nix/darwin.nix by platform
│   │   ├── linux.nix    # Linux-only home settings (noctalia, steam)
│   │   └── darwin.nix   # macOS-only home settings
│   └── modules/         # shared modules
│       ├── linux/       # Linux-only modules (hyprland)
│       └── ...          # shell, editors, kitty, programs, opencode
├── modules/nixos/       # reusable NixOS modules
├── overlays/            # nixpkgs overlays
└── wallpapers/          # wallpaper files
```

### How sharing works

- `flake.nix` imports the same `home/alexx` for both systems, passing an
  `isDarwin` flag through `extraSpecialArgs`.
- Shared modules branch on `isDarwin` for the few platform-specific pieces
  (package lists, kitty display server, Emacs package).
- Whole Linux-only features (Hyprland, noctalia) live under `home/modules/linux`
  and `home/alexx/linux.nix`, imported only when `isDarwin` is false.
- Cross-platform Nix daemon settings live in `hosts/common/nix.nix`; the
  remaining `hosts/common/*` files are NixOS-only.
- Git configuration moved into Home Manager (`home/modules/programs/common.nix`)
  so it is identical on both systems.

### macOS applications

GUI applications are installed with **Homebrew** through the nix-darwin
`homebrew` module, and `nix-homebrew` keeps the Homebrew installation itself
declarative. The Linux-only counterparts of those apps stay in the Nix package
lists. Add or remove casks in `hosts/darwin/default.nix`.

Terminals and CLI/toolchain packages (kitty, editors, language servers, fonts)
remain in Nix because they are versioned with the shared configuration.

## Commands

### Rebuild NixOS

```bash
sudo nixos-rebuild switch --flake .#nixos
```

### Update inputs

```bash
nix flake update
sudo nixos-rebuild switch --flake .#nixos
```

### Check the flake

```bash
nix flake check
```

## macOS (nix-darwin)

Prerequisites on the Mac:

1. Install Nix (multi-user, e.g. the Determinate Systems installer).
2. Install the Xcode Command Line Tools: `xcode-select --install`.

First install:

```bash
nix run nix-darwin -- switch --flake .#my-mac
```

Subsequent rebuilds:

```bash
darwin-rebuild switch --flake .#my-mac
```

Notes:

- Replace `my-mac` in `flake.nix`, `hosts/darwin/default.nix`
  (`networking.*`) with the real hostname if desired.
- `homebrew.onActivation.cleanup = "zap"` removes Homebrew formulae/casks that
  are not declared in this flake. Loosen it to `"uninstall"` or `"none"` if you
  keep other Homebrew packages.
- The login shell is not changed by nix-darwin. To use fish, run
  `chsh -s "$(which fish)"` once (the shell is added to `/etc/shells` by
  `programs.fish.enable`).
- Encryption secrets are not managed here; use a password manager.
