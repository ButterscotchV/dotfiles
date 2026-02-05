{ config, pkgs, ... }:

{
  # Network and hostname
  networking = {
    hostName = "lamb-laptop";
    networkmanager.enable = true;
    wireless.iwd.enable = true;
    networkmanager.wifi.backend = "iwd";
    firewall.enable = true;
    nftables.enable = true;
  };

  # System services
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };
}
