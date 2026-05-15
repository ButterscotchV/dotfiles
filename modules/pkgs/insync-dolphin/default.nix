{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  qt6,
  ECM,
  kdePackages,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "insync-dolphin";
  version = "master";

  src = fetchFromGitHub {
    owner = "insynchq";
    repo = "dolphin-insync-plugin";
    rev = "master";
    sha256 = "sha256-WgkfIf8RY4mO+JS2EPBFXuJNBM/TQV91uPKOjl0y9qM=";
  };

  nativeBuildInputs = [ cmake ];

  dontWrapQtApps = true;

  # The plugin requires Qt6 and KDE Frameworks
  buildInputs = [
    qt6.qtbase
    ECM
    kdePackages.kio
  ];

  postInstall = ''
    mkdir -p $out/share
    cp -r ${./share}/* $out/share
  '';

  meta = {
    platforms = [ "x86_64-linux" ];
    license = lib.licenses.unfree;
    homepage = "https://github.com/insynchq/dolphin-insync-plugin";
    description = "Dolphin integration for Insync";
  };
})
