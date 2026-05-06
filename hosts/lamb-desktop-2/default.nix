{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../../overlays
    ../../overlays/rocm-7900xtx.nix
    ./hardware-configuration.nix
    ./storage.nix
    ../../modules/system
    ../../modules/user
    ../../modules/user/vr.nix
    ../../modules/user/llama-cpp.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Hostname for this system
  networking.hostName = "lamb-desktop-2";

  hardware.enableAllFirmware = true;

  # Enable hardware acceleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.amdgpu = {
    initrd.enable = true;
    opencl.enable = true;
  };

  services.plex = {
    enable = true;
    openFirewall = true;
    user = "butterscotch";
  };
  systemd.services.plex.serviceConfig.ProtectHome = lib.mkForce false;

  environment.systemPackages = with pkgs; [
    insync-dolphin
  ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion.
  system.stateVersion = "26.05";
}
