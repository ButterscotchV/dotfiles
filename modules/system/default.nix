{ pkgs, ... }:

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

  # Enables support for SANE scanners
  hardware.sane = {
    enable = true;
    # Disabled because it seems to crash
    # brscan4 = {
    #   enable = true;
    #   netDevices = {
    #     HL-L2465DW = {
    #       model = "HL-L2465DW";
    #       nodename = "BRW046874F1F9FA.local";
    #     };
    #   };
    # };
    brscan5 = {
      enable = true;
      netDevices = {
        HL-L2465DW = {
          model = "HL-L2465DW";
          nodename = "BRW046874F1F9FA.local";
        };
      };
    };
  };

  # Add Brother printer drivers
  services.printing.drivers = [
    pkgs.brlaser
    pkgs.brgenml1lpr
    pkgs.brgenml1cupswrapper
  ];
}
