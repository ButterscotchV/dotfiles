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

  # Configure allowed Nix packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.segger-jlink.acceptLicense = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];

  # Firmware
  hardware.enableAllFirmware = true;
  services.fwupd.enable = true;

  # Shell configuration
  programs.zsh.enable = true;

  services.printing.enable = true;

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  # Binary app support
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  programs.nix-ld.enable = true;

  services.flatpak.enable = true;

  # === Power configuration ===
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
}
