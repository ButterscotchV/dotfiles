{
  pkgs,
  pkgsErosanix,
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
    pkgsLocal = import ./pkgs {
      inherit pkgs;
      pkgsErosanix = inputs.erosanix.lib.x86_64-linux;
    };
  };
}
