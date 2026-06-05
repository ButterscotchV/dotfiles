{
  pkgs,
  pkgsErosanix,
  pkgsWine10,
  pkgsProtonGE33,
  ...
}:

let
  xwintab = pkgs.callPackage ./xwintab { };
in
{
  inherit xwintab;

  rebelle = pkgs.callPackage ./rebelle {
    inherit xwintab;
    mkWindowsApp = pkgsErosanix.mkWindowsApp;
    wine = pkgsWine10.wineWow64Packages.staging;
    makeDesktopIcon = pkgsErosanix.makeDesktopIcon;
    copyDesktopIcons = pkgsErosanix.copyDesktopIcons;
  };

  pinga = pkgs.callPackage ./pinga {
    mkWindowsApp = pkgsErosanix.mkWindowsApp;
    wine = pkgs.wineWow64Packages.stable;
    makeDesktopIcon = pkgsErosanix.makeDesktopIcon;
    copyDesktopIcons = pkgsErosanix.copyDesktopIcons;
  };

  pingo = pkgs.callPackage ./pingo {
    mkDerivation = pkgs.stdenvNoCC.mkDerivation;
    wine = pkgs.wineWow64Packages.stable;
  };

  insync-dolphin = pkgs.callPackage ./insync-dolphin {
    ECM = pkgs.kdePackages.extra-cmake-modules;
  };

  proton-ge-rtsp-bin = pkgs.callPackage ./proton-ge-rtsp-bin {
    proton-ge-bin = pkgsProtonGE33.proton-ge-bin;
  };
}
