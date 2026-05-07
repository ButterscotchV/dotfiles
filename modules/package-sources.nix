{
  pkgs,
  config,
  inputs,
  ...
}:

{
  _module.args = {
    pkgsStable = import inputs.nixpkgs-stable {
      inherit (pkgs.stdenv.hostPlatform) system;
      config.allowUnfree = true;
    };
    pkgsXr = inputs.nixpkgs-xr;
    pkgsErosanix = inputs.erosanix;
  };
}
