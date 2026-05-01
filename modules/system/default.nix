{ pkgs, ... }:

{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./boot.nix
    ./desktop.nix
    ./locale.nix
    ./network.nix
    ./nix-config.nix
    ./packages.nix
    ./virtualisation.nix
  ];

  # Shell configuration
  programs.zsh.enable = true;

  services.printing.enable = true;

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
  # Disable default power profiles
  services.power-profiles-daemon.enable = false;
  # Enable auto-cpufreq instead
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

  # Gaming mouse configuration
  services.ratbagd.enable = true;
  environment.systemPackages = with pkgs; [
    piper
  ];
}
