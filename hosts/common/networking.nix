{ ... }:

{
  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    5173
    8383
    9090
    8080
  ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
