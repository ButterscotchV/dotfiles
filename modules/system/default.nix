{ config, pkgs, ... }:

{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./boot.nix
    ./desktop.nix
    ./locale.nix
    ./packages.nix
    ./network.nix
    ./nix-config.nix
    ./packages.nix
    ./virtualisation.nix
  ];

  # Shell configuration
  programs.zsh.enable = true;

  services.printing.enable = true;

  # Security settings
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  # AppImage binary format support
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Power configuration
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
}
