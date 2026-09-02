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
      # Patch xrizer for BigWalkVR
      xrizer = pkgsXr.xrizer.overrideAttrs {
        src = prev.fetchFromGitHub {
          owner = "exstrim401";
          repo = "xrizer";
          rev = "47031c3abbfd55f49379d4c8764c80a759a5b095";
          sha256 = "sha256-z8v8s7AK/Z+acsYHx66h0dMNG1qcR/J7g3ynKMxWpNA=";
        };
      };
    })
    inputs.affinity-nix.overlays.default
  ];
}
