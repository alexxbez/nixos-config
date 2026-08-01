# NixOS Configuration

Single-user NixOS flake for `alexx` on the host `nixos`, with a placeholder for future nix-darwin.

## Structure

```
.
├── flake.nix            # entry point
├── flake.lock           # pinned inputs
├── hosts/               # per-host configuration
│   ├── common/          # shared NixOS base
│   └── nixos/           # current host
├── home/                # home-manager configuration
│   ├── alexx/           # user entry point
│   └── modules/         # shared home-manager modules
├── modules/nixos/       # reusable NixOS modules
├── overlays/            # nixpkgs overlays
└── wallpapers/          # wallpaper files
```

## Commands

### Rebuild NixOS

```bash
sudo nixos-rebuild switch --flake .#nixos
```

### Update all flake inputs

```bash
nix flake update
sudo nixos-rebuild switch --flake .#nixos
```

### Update a single input

```bash
nix flake lock --update-input nixpkgs
sudo nixos-rebuild switch --flake .#nixos
```

### Check the flake

```bash
nix flake check
```

## macOS (future)

Replace `my-mac` with the actual hostname in `flake.nix`, then run:

```bash
darwin-rebuild switch --flake .#my-mac
```

For the first nix-darwin install, bootstrap with:

```bash
nix run nix-darwin -- switch --flake .#my-mac
```

## Notes

- Home-manager is used as a NixOS module, so `nixos-rebuild` handles both system and user config.
- The `nixos` host name is defined in `hosts/nixos/default.nix`.
- Secrets are not managed in this repo; use a password manager if needed.
