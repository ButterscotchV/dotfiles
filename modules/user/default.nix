{ pkgs, ... }:

{
  imports = [
    ./gaming/steam.nix
    ./peripherals/mouse.nix
    ./peripherals/printer.nix
  ];

  # User configuration
  users.users.butterscotch = {
    isNormalUser = true;
    description = "Butterscotch!";
    extraGroups = [
      "audio"
      "dialout"
      "docker"
      "gamemode"
      "networkmanager"
      "video"
      "wheel"
    ];
    shell = pkgs.zsh;
  };
}
