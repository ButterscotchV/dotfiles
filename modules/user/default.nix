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
  networking = {
    firewall.allowedTCPPorts = [ 21110 ];
    firewall.allowedUDPPorts = [
      6969
      8266
    ];
  };
}
