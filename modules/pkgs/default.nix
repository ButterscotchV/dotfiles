{
  pkgs,
  libErosanix,
  ...
}:

let
  xwintab = pkgs.callPackage ./xwintab { };
in
{
  rebelle = pkgs.callPackage ./rebelle {
    inherit xwintab;
    mkWindowsApp = libErosanix.mkWindowsApp;
    wine = pkgs.wineWow64Packages.staging;
    makeDesktopIcon = libErosanix.makeDesktopIcon;
    copyDesktopIcons = libErosanix.copyDesktopIcons;
  };

  pinga = pkgs.callPackage ./pinga {
    mkWindowsApp = libErosanix.mkWindowsApp;
    wine = pkgs.wineWow64Packages.stable;
    makeDesktopIcon = libErosanix.makeDesktopIcon;
    copyDesktopIcons = libErosanix.copyDesktopIcons;
  };

  pingo = pkgs.callPackage ./pingo {
    mkDerivation = pkgs.stdenvNoCC.mkDerivation;
    wine = pkgs.wineWow64Packages.stable;
  };

  insync-dolphin = pkgs.callPackage ./insync-dolphin {
    ECM = pkgs.kdePackages.extra-cmake-modules;
  };
}
