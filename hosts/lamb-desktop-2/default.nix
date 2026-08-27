{
  pkgsLocal,
  pkgsMesa26_1_2,
  ...
}:

{
  imports = [
    ../../overlays
    ../../overlays/rocm-desktop.nix
    ./hardware-configuration.nix
    ./storage.nix
    ../../modules/system
    ../../modules/user
    ../../modules/user/harmonia.nix
    ../../modules/user/plex.nix
    ../../modules/user/gaming/vr.nix
  ];

  # Hostname for this system
  networking.hostName = "lamb-desktop-2";

  # Enable hardware acceleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    # Mesa 26.1.6: Crashes plasmashell and Chromium apps
    # Mesa 26.2.0: Seems worse and crashes Firefox and Chromium apps
    # Mesa 26.1.3: Also crashing occasionally
    # Mesa 26.1.2: Working well, Steam crashes occasionally, may be unrelated
    # 2026-08-20: Mesa 26.2.1 got some promising updates, trying it now
    # 2026-08-27: Reverted to Mesa 26.1.2
    package = pkgsMesa26_1_2.mesa;
    package32 = pkgsMesa26_1_2.pkgsi686Linux.mesa;
  };
  # This option is already set by nixos-hardware#common-gpu-amd
  # hardware.amdgpu.initrd.enable = lib.mkDefault true;
  hardware.amdgpu.opencl.enable = true;

  environment.systemPackages = [
    pkgsLocal.insync-dolphin
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
