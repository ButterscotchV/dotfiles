{ pkgs, nixpkgs-xr, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      proton-ge-rtsp-bin = nixpkgs-xr.packages.${pkgs.stdenv.hostPlatform.system}.proton-ge-rtsp-bin;
    })
  ];
}
