{ inputs, pkgsXr }:

final: prev: {
  # Patch xrizer for BigWalkVR
  xrizer = pkgsXr.xrizer.overrideAttrs (
    finalAttrs: prevAttrs: {
      patches = [
        (prev.fetchpatch2 {
          url = "https://github.com/exstrim401/xrizer/commit/47031c3abbfd55f49379d4c8764c80a759a5b095.diff?full_index=1";
          hash = "sha256-VNfLtAk6GzI9/xr1pwyphqst3BZDDSdLBvzycanbiiM=";
        })
      ];
    }
  );
  # Patch WiVRn for SlimeVR Rewrite
  wivrn = inputs.wivrn-solarxr.packages.${prev.stdenv.hostPlatform.system}.default.override {
    xrizer = final.xrizer;
  };
}
