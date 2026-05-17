{ ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      rocmPackages = prev.rocmPackages.overrideScope (
        fs: ps: {
          # gfx1100 = Radeon RX 7900 XTX
          # gfx1036 (gfx1030) = Ryzen 7 9800X3D iGPU (may need `HSA_OVERRIDE_GFX_VERSION=10.3.0`)
          clr = ps.clr.override { localGpuTargets = [ "gfx1100;gfx1030" ]; };
        }
      );
    })
  ];
}
