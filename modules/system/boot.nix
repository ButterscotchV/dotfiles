{ pkgs, ... }:

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
      memtest86.enable = true;
    };
  };

  # Select the latest Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
