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
    pkgsXr = inputs.nixpkgs-xr.packages.${system};
    pkgsLocal = import ./pkgs {
      inherit pkgs;
      pkgsErosanix = inputs.erosanix.lib.${system};
      pkgsWine10 = import inputs.nixpkgs-wine-10 {
        inherit system;
        config.allowUnfree = true;
      };
      pkgsProtonGE33 = import inputs.nixpkgs-proton-ge-33 {
        inherit system;
        config.allowUnfree = true;
      };
    };
  };
}
