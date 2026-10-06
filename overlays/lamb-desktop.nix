{ ... }:

{
  nixpkgs.overlays = [
    (import ./rocm.nix)
  ];
}
