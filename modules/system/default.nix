{ ... }:

{
  imports = [
    ../package-sources.nix
    ./audio.nix
    ./bluetooth.nix
    ./boot.nix
    ./desktop.nix
    ./locale.nix
    ./network.nix
    ./nix-config.nix
    ./packages.nix
    ./udev.nix
    ./virtualisation.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-38.8.4"
    "electron-39.8.10"
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

  services.flatpak.enable = true;
}
