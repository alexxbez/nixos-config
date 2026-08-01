{ ... }:

{
  virtualisation.docker = {
    enable = true;
  };

  users.users.alexx.extraGroups = [ "docker" ];
}
