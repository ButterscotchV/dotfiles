{ config, pkgs, ... }:

{
  imports = [
    ./slimevr
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

  # No idea what this was for...
  networking.firewall.allowedUDPPorts = [
    35903
  ];
}
