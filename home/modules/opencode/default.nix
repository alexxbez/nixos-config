{ pkgs, ... }:

{
  xdg.configFile."opencode/AGENTS.md".text = ''
      # Global OpenCode Instructions

      Environment:
      - I use Nixos and therefore Nix
      - You may find any needed shell in `/home/alexx/Workspace/Shells`.
      - Do not recommend apt, dnf, pacman, brew, or other system package managers.
      - When additional tools are required, you may add them to the specific shell.
      - Prefer reproducible Nix-based solutions.

      General:
      - Keep commands compatible with NixOS.
      - If a dependency is missing, you may add it to the relevant shell.
      '';
}
