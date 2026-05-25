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
    };
  };

  # Select the latest Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Temporary for 7.0.9
  boot.kernelPatches = [
    {
      name = "bluetooth-btmtk-fix";
      patch = pkgs.fetchurl {
        url = "https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/patch/drivers/bluetooth/btmtk.c?id=162b1adeb057d28ad84fd8a03f3c50cf08db5c62";
        sha256 = "7c2726a17e18e333bacc0fabf7efa72a0b712ae19c67bfd96fb8992dc593bda7";
      };
    }
  ];
}
