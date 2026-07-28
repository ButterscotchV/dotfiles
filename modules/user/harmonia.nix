{ lib, ... }:

let
  keyPath = "/var/lib/harmonia/lamb-desktop-2.tail11fc37.ts.net-1.secret";
  tlsKeyPath = "/var/lib/harmonia/lamb-desktop-2.tail11fc37.ts.net.key";
in
{
  # From https://github.com/basnijholt/dotfiles/blob/main/configs/nixos/hosts/nix-cache/harmonia.nix
  users.groups.harmonia = { };
  users.users.harmonia = {
    isSystemUser = true;
    group = "harmonia";
    home = "/var/lib/harmonia";
  };

  # Generate a public/private key pair like this:
  # $ nix-store --generate-binary-cache-key cache.yourdomain.tld-1 /var/lib/secrets/harmonia.secret /var/lib/secrets/harmonia.pub
  services.harmonia = {
    cache = {
      enable = true;
      signKeyPaths = [ keyPath ];
      settings = {
        bind = "[::]:49023";
        tls_cert_path = "/var/lib/certs/lamb-desktop-2.tail11fc37.ts.net.crt";
        tls_key_path = tlsKeyPath;
      };
    };

    daemon.enable = true;
  };

  systemd.services.harmonia.serviceConfig.DynamicUser = lib.mkForce false;

  # Ensure Harmonia can read the persistent signing key across service restarts
  systemd.tmpfiles.rules = [
    "d /var/lib/harmonia 0750 harmonia harmonia -"
    "z ${keyPath} 0600 harmonia harmonia -"
    "z ${tlsKeyPath} 0600 harmonia harmonia -"
  ];

  networking.firewall.allowedTCPPorts = [ 49023 ];
}
