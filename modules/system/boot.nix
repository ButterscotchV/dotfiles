{ pkgs, lib, ... }:

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
  boot.kernelPackages = pkgs.linuxPackagesFor (
    pkgs.linuxKernel.kernels.linux_7_0.override {
      argsOverride = rec {
        src = pkgs.fetchurl {
          url = "mirror://kernel/linux/kernel/v${lib.versions.major version}.x/linux-${version}.tar.xz";
          sha256 = "sha256-y6REQKpXr/18ISQdxbwjSw31PEmfj/w+vCkN0zkKdSM=";
        };
        version = "7.0.6";
        modDirVersion = "7.0.6";
      };
    }
  );
}
