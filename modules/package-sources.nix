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
    pkgsFast = import inputs.nixpkgs-fast {
      inherit system;
      config.allowUnfree = true;
    };
    # pkgsStable = import inputs.nixpkgs-stable {
    #   inherit system;
    #   config.allowUnfree = true;
    # };
    pkgsXr = inputs.nixpkgs-xr.packages.${system};
    pkgsErosanix = inputs.erosanix.packages.${system};
    pkgsLocal = import ./pkgs {
      inherit pkgs;
      libErosanix = inputs.erosanix.lib.${system};
    };
  };
}
