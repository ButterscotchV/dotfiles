{ config, pkgs, ... }:

{
  services.udev.extraRules = (builtins.readFile ./69-slimevr-devices.rules);
  networking = {
    firewall.allowedTCPPorts = [ 21110 ];
    firewall.allowedUDPPorts = [
      6969
      8266
    ];
  };
}
