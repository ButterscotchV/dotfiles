{
  inputs,
  pkgsXr,
  ...
}:

{
  nixpkgs.overlays = [
    (final: prev: {
      easyeffects = prev.easyeffects.overrideAttrs {
        # Newer rnnoise model
        rnnoise =
          (prev.rnnoise.override {
            modelUrl = "https://media.xiph.org/rnnoise/models/rnnoise_data-0a8755f8e2d834eff6a54714ecc7d75f9932e845df35f8b59bc52a7cfe6e8b37.tar.gz";
            modelHash = "sha256-CodV+OLYNO/2pUcU7MfXX5ky6EXfNfi1m8UqfP5uizc=";
          }).overrideAttrs
            {
              src = prev.fetchFromGitLab {
                domain = "gitlab.xiph.org";
                owner = "xiph";
                repo = "rnnoise";
                rev = "70f1d256acd4b34a572f999a05c87bf00b67730d";
                sha256 = "sha256-fkSy7Sqnx0yLfGLciHf8PaptzFVzFAeRrhE4R5z8hSw=";
              };
              patches = [ ];
            };
      };
    })
    (final: prev: {
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
      wivrn =
        (inputs.wivrn-solarxr.packages.${prev.stdenv.hostPlatform.system}.default.override {
          xrizer = final.xrizer;
        }).overrideAttrs
          (
            finalAttrs: prevAttrs: {
              cmakeFlags = (prev.lib.filter (flag: !prev.lib.hasInfix "GIT_TAG" flag) prevAttrs.cmakeFlags) ++ [
                (prev.lib.cmakeFeature "GIT_DESC" "v${prevAttrs.version}-0-g${
                  builtins.substring 0 8 finalAttrs.version
                }")
                (prev.lib.cmakeFeature "GIT_COMMIT" finalAttrs.version)
              ];
            }
          );
    })
    inputs.affinity-nix.overlays.default
  ];
}
