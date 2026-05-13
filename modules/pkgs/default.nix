{ pkgs, pkgsErosanix, ... }:

{
  rebelle = pkgs.callPackage ./rebelle {
    lib = pkgs.lib;
    mkWindowsApp = pkgsErosanix.mkWindowsApp;
    wine = pkgs.wineWow64Packages.stable;
    fetchurl = pkgs.fetchurl;
    makeDesktopItem = pkgs.makeDesktopItem;
    makeDesktopIcon = pkgsErosanix.makeDesktopIcon;
    copyDesktopItems = pkgs.copyDesktopItems;
    copyDesktopIcons = pkgsErosanix.copyDesktopIcons;
  };

  pinga = pkgs.callPackage ./pinga {
    lib = pkgs.lib;
    mkWindowsApp = pkgsErosanix.mkWindowsApp;
    wine = pkgs.wineWow64Packages.stable;
    fetchzip = pkgs.fetchzip;
    makeDesktopItem = pkgs.makeDesktopItem;
    makeDesktopIcon = pkgsErosanix.makeDesktopIcon;
    copyDesktopItems = pkgs.copyDesktopItems;
    copyDesktopIcons = pkgsErosanix.copyDesktopIcons;
  };

  pingo = pkgs.callPackage ./pingo {
    lib = pkgs.lib;
    mkDerivation = pkgs.stdenvNoCC.mkDerivation;
    runtimeShell = pkgs.runtimeShell;
    wine = pkgs.wineWow64Packages.stable;
    fetchzip = pkgs.fetchzip;
  };
}
