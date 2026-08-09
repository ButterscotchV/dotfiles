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
    # pkgsStable = import inputs.nixpkgs-stable {
    #   inherit system;
    #   config.allowUnfree = true;
    # };
    # pkgsFast = import inputs.nixpkgs-fast {
    #   inherit system;
    #   config.allowUnfree = true;
    # };
    pkgsKernel7_1_5 = import inputs.nixpkgs-kernel-7_1_5 {
      inherit system;
      config.allowUnfree = true;
    };
    pkgsMesa26_1_3 = import inputs.nixpkgs-mesa-26_1_3 {
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
