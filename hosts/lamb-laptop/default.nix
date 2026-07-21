{ ... }:

{
  imports = [
    ../../overlays
    ./hardware-configuration.nix
    ../../modules/system
    ../../modules/user
  ];

  # Hostname for this system
  networking.hostName = "lamb-laptop";

  nix.settings = {
    substituters = [ "https://lamb-desktop-2.tail11fc37.ts.net:49023" ];
    # Replace the key with the content of /var/lib/secrets/harmonia.pub
    trusted-public-keys = [
      "lamb-desktop-2.tail11fc37.ts.net-1:7OhqMX9zIX9XKSPmLa5Nj9U2VEU5ofidi0PRYIL6hH4="
    ];
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion.
  system.stateVersion = "26.05";
}
