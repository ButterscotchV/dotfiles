{
  lib,
  stdenv,
  fetchurl,
  dpkg,
}:

# idk why this doesn't work... maybe Dolphin doesn't like it?
# based on https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/in/insync-nautilus/package.nix
stdenv.mkDerivation (finalAttrs: {
  pname = "insync-dolphin";
  version = "3.9.8.60034";

  # Download latest from: https://www.insynchq.com/downloads/linux#dolphin
  src = fetchurl rec {
    urls = [
      "https://cdn.insynchq.com/builds/linux/${finalAttrs.version}/insync-dolphin-kde6_${finalAttrs.version}_all.deb"
    ];
    hash = "sha256-CTYB3ccdtfEFsGrz2e6EY6vKOBA0hss7YqlYCc9kwYo=";
  };

  nativeBuildInputs = [ dpkg ];

  installPhase = ''
    runHook preInstall

    cp -r usr $out

    runHook postInstall
  '';

  meta = {
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ fromSource ];
    license = lib.licenses.unfree;
    homepage = "https://www.insynchq.com";
    description = "This package contains the Python extension and icons for integrating Insync with Dolphin";
  };
})
