{ config, pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;
    wireless.iwd.enable = true;
    networkmanager.wifi.backend = "iwd";
    firewall.enable = true;
    nftables.enable = true;

    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
    networkmanager.dns = "none";
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };
}
