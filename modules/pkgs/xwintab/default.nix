{
  lib,
  stdenvNoCC,
  fetchzip,
  autoPatchelfHook,
  libxcb,
}:

stdenvNoCC.mkDerivation rec {
  pname = "xwintab";
  version = "0.5.0";

  src = fetchzip {
    url = "https://github.com/Graham--M/XWinTab/releases/download/v${version}/XWinTab.v${version}.zip";
    sha256 = "sha256-nZ4aiY0ys5b/hP7+kXvUKKmkYSU9H3yTKh4x4+b1Jaw=";
    stripRoot = false;
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    libxcb
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp wintab32.dll $out/
    cp XWinTabHelper.dll.so $out/
    runHook postInstall
  '';

  meta = with lib; {
    description = "XWinTab - X11 to Windows Tablet API bridge for Wine";
    homepage = "https://github.com/Graham--M/XWinTab";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = [ "x86_64-linux" ];
  };
}
