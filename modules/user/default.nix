{ config, pkgs, ... }:

{
  imports = [
    ./steam.nix
  ];

  # User configuration
  users.users.butterscotch = {
    isNormalUser = true;
    description = "Butterscotch!";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "docker"
      "dialout"
    ];
    shell = pkgs.zsh;
  };

  # SlimeVR
  services.udev.extraRules = (builtins.readFile ./69-slimevr-devices.rules);
  networking = {
    firewall.allowedTCPPorts = [ 21110 ];
    firewall.allowedUDPPorts = [
      6969
      8266
    ];
  };
}
