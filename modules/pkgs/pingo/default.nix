{
  lib,
  stdenvNoCC,
  runtimeShell,
  wine,
  fetchzip,
}:

stdenvNoCC.mkDerivation rec {
  inherit wine;

  pname = "pingo";
  version = "1.29";

  src = fetchzip {
    url = "https://css-ig.net/bin/pingo.zip";
    sha256 = "sha256-wRgX7F8mIl+j/Rsq+8crdrEqiNEJorxUb6BEMG8VIJE=";
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
    export WINE=${wine}/bin/wine
    export WINEARCH=win64
    export WINEPREFIX="''${XDG_DATA_HOME:-"''${HOME}/.local/share"}/pingo"
    export WINEDLLOVERRIDES="mscoree=" # Disable Mono
    if [ ! -d "$WINEPREFIX" ] || [ ! "$(readlink "$WINEPREFIX/pingo.exe")" -ef "${src}/pingo.exe" ] ; then
      mkdir -p "$WINEPREFIX"
      ln -sf "${src}/pingo.exe" "$WINEPREFIX/pingo.exe"
    fi
    $WINE "$WINEPREFIX/pingo.exe" $@
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
