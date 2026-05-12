{
  stdenv,
  lib,
  mkDerivation,
  runtimeShell,
  wine,
  fetchurl,
  unzip,
}:

mkDerivation rec {
  inherit wine;

  pname = "pingo";
  version = "1.25.41";

  src = fetchurl {
    url = "https://css-ig.net/bin/pingo-win64.zip";
    sha256 = "sha256-USK06A+shvkFdpXrVE0pOZPyIv8Uqk98hlPoSkuDOag=";
  };

  nativeBuildInputs = [
    wine
  ];

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cat <<'EOF' > $out/bin/pingo
    #!${runtimeShell}
    export PATH=${wine}/bin:$PATH
    export WINEARCH=win64
    export WINEPREFIX="''${XDG_DATA_HOME:-"''${HOME}/.local/share"}/pingo"
    export WINEDLLOVERRIDES="mscoree=" # disable mono
    if [ ! -d "$WINEPREFIX" ] ; then
      mkdir -p "$WINEPREFIX"
      unzip ${src} -d "$WINEPREFIX/drive_c"
    fi
    wine "$WINEPREFIX/drive_c/pingo.exe" $@
    EOF
    chmod +x $out/bin/pingo

    runHook postInstall
  '';

  meta = with lib; {
    description = "pingo is an experimental lossless and lossy image optimizer (PNG, JPEG, WebP, APNG) designed to be used for web context.";
    homepage = "https://css-ig.net/pingo";
    license = licenses.unfree;
    maintainers = with maintainers; [ ];
    platforms = [ "x86_64-linux" ];
  };
}
