{ pkgs, pkgsXr, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      proton-ge-rtsp-bin = pkgsXr.packages.${pkgs.stdenv.hostPlatform.system}.proton-ge-rtsp-bin;
    })
  ];
}
