{
  pkgs,
  inputs,
  lib,
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
    pkgsXr = inputs.nixpkgs-xr.packages.${system};
    pkgsErosanix = inputs.erosanix.packages.${system};
    pkgsLocal = import ./pkgs {
      inherit pkgs;
      libErosanix = inputs.erosanix.lib.${system};
    };
    wivrnSolarXR = inputs.wivrn-solarxr.packages.${system}.default.overrideAttrs (
      finalAttrs: prevAttrs: {
        cmakeFlags = (lib.filter (flag: !lib.hasInfix "GIT_TAG" flag) prevAttrs.cmakeFlags) ++ [
          (lib.cmakeFeature "GIT_DESC" "v${prevAttrs.version}-0-g${
            builtins.substring 0 8 finalAttrs.version
          }")
          (lib.cmakeFeature "GIT_COMMIT" finalAttrs.version)
        ];
      }
    );
  };
}
