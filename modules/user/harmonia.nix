{ ... }:

{
  # Generate a public/private key pair like this:
  # $ nix-store --generate-binary-cache-key cache.yourdomain.tld-1 /var/lib/secrets/harmonia.secret /var/lib/secrets/harmonia.pub
  services.harmonia = {
    cache = {
      enable = true;
      signKeyPaths = [ "/var/lib/secrets/harmonia.secret" ];
      settings = {
        bind = "[::]:49023";
        tls_cert_path = "/home/butterscotch/Certs/lamb-desktop-2.tail11fc37.ts.net.crt";
        tls_key_path = "/home/butterscotch/Certs/lamb-desktop-2.tail11fc37.ts.net.key";
      };
    };

    daemon.enable = true;
  };

  networking.firewall.allowedTCPPorts = [ 49023 ];
}
