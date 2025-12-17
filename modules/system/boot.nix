{ config, pkgs, ... }:

{
  # Configure grub
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      default = "saved";
    };
  };

  # Select the latest Liux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
