{ ... }:

{
  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Git configuration
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "alexxbez";
        email = "alexxbez@proton.me";
      };
      init.defaultBranch = "main";
    };
  };

  # Start ssh agent
  # programs.ssh.startAgent = true;
  # apparently gnome ssh agent is already on
}
