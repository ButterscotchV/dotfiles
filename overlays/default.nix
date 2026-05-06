{ ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      # Workaround for openldap build failures on i686
      # See: https://github.com/NixOS/nixpkgs/issues/514113
      openldap = prev.openldap.overrideAttrs {
        doCheck = !prev.stdenv.hostPlatform.isi686;
      };
      insync-dolphin = prev.callPackage ./insync-dolphin.nix { };
      # Newer rnnoise model
      easyeffects = prev.easyeffects.override {
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
  ];
}
