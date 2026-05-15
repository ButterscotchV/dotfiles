{ pkgs, pkgsErosanix, ... }:

{
  rebelle = pkgs.callPackage ./rebelle {
    mkWindowsApp = pkgsErosanix.mkWindowsApp;
    wine = pkgs.wineWow64Packages.stable;
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
}
