{ ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      rocmPackages = prev.rocmPackages.overrideScope (
        fs: ps: {
          clr = ps.clr.override { localGpuTargets = [ "gfx1100" ]; };
        }
      );
    })
  ];
}
