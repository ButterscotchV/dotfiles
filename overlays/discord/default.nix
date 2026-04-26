{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      discord = (final.callPackage ./src { }).discord;
    })
  ];
}
