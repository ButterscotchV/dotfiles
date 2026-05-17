{ ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      rocmPackages = prev.rocmPackages.overrideScope (
        fs: ps: {
          # gfx1100 = Radeon RX 7900 XTX
          # gfx1036 = Ryzen 7 9800X3D iGPU
          clr = ps.clr.override { localGpuTargets = [ "gfx1100;gfx1036" ]; };
        }
      );
    })
  ];
}
