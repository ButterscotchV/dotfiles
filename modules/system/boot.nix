{ pkgsKernel7_1_5, ... }:

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
  boot.kernelPackages = pkgsKernel7_1_5.linuxPackages_latest;
}
