{ pkgs, ... }:

{
  imports = [
    ./gaming/steam.nix
    ./peripherals/mouse.nix
    ./peripherals/printer.nix
    ./peripherals/rgb.nix
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

  environment.systemPackages = with pkgs; [
    bitwarden-desktop
  ];

  # Macro software
  services.crossmacro = {
    enable = true;
    users = [ "butterscotch" ];
  };
}
