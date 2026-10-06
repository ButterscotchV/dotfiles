{
  inputs,
  pkgsXr,
  ...
}:

{
  nixpkgs.overlays = [
    # inputs.affinity-nix.overlays.default
    (import ./rnnoise-easyeffects.nix)
    (import ./vr.nix { inherit inputs pkgsXr; })
  ];
}
