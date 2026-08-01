{ pkgs, ... }:

{
  # Kmonad
  boot.kernelModules = [ "uinput" ];

  users.groups.uinput = { };
  users.groups.input = { };
  users.users.alexx.extraGroups = [ "input" "uinput" ];

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  environment.etc."kmonad/main.kbd".text = ''
    (defcfg
      ;; if this ever breaks, use 'sudo evtest'
      input  (device-file "/dev/input/by-id/usb-ASUSTek_Computer_Inc._N-KEY_Device-event-mouse")
      output (uinput-sink "KMonad Virtual Keyboard")
      fallthrough true
      allow-cmd false
    )

    (defsrc
      caps
      lctrl
    )

    (deflayer base
      @caps-ctrl-esc
      lctrl
    )

    (defalias
      caps-ctrl-esc (tap-hold 150 esc lctrl)
    )
  '';

  systemd.services.kmonad = {
    description = "KMonad keyboard remapping";

    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-udevd.service" ];

    serviceConfig = {
      ExecStart = "${pkgs.kmonad}/bin/kmonad /etc/kmonad/main.kbd";
      Restart = "always";
      RestartSec = 3;

      DynamicUser = false;
    };
  };
}
