{
  pkgs,
  ...
}:

{
  # TODO: Runs as root? Can't run WayVR automatically if from autoStart - 2026-04-28
  #  Edit: I've added WayVR to this service's config, see if that works! - 2026-07-20
  services.wivrn = {
    enable = true;
    openFirewall = true;

    # Run WiVRn as a systemd service on startup
    autoStart = true;

    # You should use the default configuration (which is no configuration), as that works the best out of the box.
    # However, if you need to configure something see https://github.com/WiVRn/WiVRn/blob/master/docs/configuration.md for configuration options and https://mynixos.com/nixpkgs/option/services.wivrn.config.json for an example configuration.
    config.json = {
      application = [ pkgs.wayvr ];
    };
  };

  # SlimeVR
  services.udev.extraFiles = [
    ./69-slimevr-devices.rules
  ];
  # Tracker server: 6969/UDP
  # Tracker OTA server: 8266/UDP/TCP
  # GUI: 21110/TCP (local)
  networking = {
    firewall.allowedUDPPorts = [
      6969
      8266
    ];
    firewall.allowedTCPPorts = [
      8266
    ];
  };
}
