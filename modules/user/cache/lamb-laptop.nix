{ ... }:

{
  nix.settings = {
    substituters = [ "https://lamb-desktop-2.tail11fc37.ts.net:49023" ];
    trusted-public-keys = [
      # Key from lamb-desktop-2 with the content of /var/lib/secrets/harmonia.pub
      "lamb-desktop-2.tail11fc37.ts.net-1:7OhqMX9zIX9XKSPmLa5Nj9U2VEU5ofidi0PRYIL6hH4="
    ];
  };
}
