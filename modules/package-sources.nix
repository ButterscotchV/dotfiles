{
  pkgs,
  inputs,
  ...
}:

let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  _module.args = {
    pkgsStable = import inputs.nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
    pkgsFast = import inputs.nixpkgs-fast {
      inherit system;
      config.allowUnfree = true;
    };
    pkgsMesa26_2_2 = import inputs.nixpkgs-mesa-26_2_2 {
      inherit system;
      config.allowUnfree = true;
    };
    pkgsXr = inputs.nixpkgs-xr.packages.${system};
    pkgsErosanix = inputs.erosanix.packages.${system};
    pkgsLocal = import ./pkgs {
      inherit pkgs;
      libErosanix = inputs.erosanix.lib.${system};
    };
  };
}
