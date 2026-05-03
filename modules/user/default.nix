{ pkgs, ... }:

{
  imports = [
    ./udev.nix
    ./steam.nix
    ./drawing-tablet.nix
  ];

  # User configuration
  users.users.butterscotch = {
    isNormalUser = true;
    description = "Butterscotch!";
    extraGroups = [
      "audio"
      "dialout"
      "docker"
      "networkmanager"
      "video"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  # SlimeVR
  services.udev.extraFiles = [
    ./69-slimevr-devices.rules
  ];
  networking = {
    firewall.allowedTCPPorts = [ 21110 ];
    firewall.allowedUDPPorts = [
      6969
      8266
    ];
  };
}
