{
  ...
}:

{
  services.wivrn = {
    enable = true;
    openFirewall = true;

    # Run WiVRn as a systemd service on startup
    autoStart = true;

    # You should use the default configuration (which is no configuration), as that works the best out of the box.
    # However, if you need to configure something see https://github.com/WiVRn/WiVRn/blob/master/docs/configuration.md for configuration options and https://mynixos.com/nixpkgs/option/services.wivrn.config.json for an example configuration.
  };

  # SlimeVR
  services.udev.extraFiles = [
    ./69-slimevr-devices.rules
  ];
  # GUI -> 21110/TCP
  networking = {
    firewall.allowedUDPPorts = [
      6969
      8266
    ];
  };
}
