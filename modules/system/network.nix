{ config, lib, ... }:

{
  networking = {
    # === WiFi ===
    networkmanager.enable = true;
    wireless.iwd.enable = true;
    networkmanager.wifi.backend = "iwd";

    # === Firewall ===
    nftables.enable = true;
    firewall = {
      enable = true;
      # Always allow traffic from your Tailscale network
      trustedInterfaces = [ config.services.tailscale.interfaceName ];
      # Fix ProtonVPN connecting
      # NixOS firewall will block wg traffic because of rpfilter
      checkReversePath = lib.mkForce false;
    };

    # === DNS ===
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
    networkmanager.dns = "none";
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "client";
  };
  # Force tailscaled to use nftables (Critical for clean nftables-only systems)
  # This avoids the "iptables-compat" translation layer issues.
  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];
}
