{ pkgs, pkgsErosanix, ... }:

{
  rebelle = pkgs.callPackage ./rebelle {
    stdenv = pkgs.stdenv;
    lib = pkgs.lib;
    mkWindowsApp = pkgsErosanix.mkWindowsApp;
    wine = pkgs.proton-ge-bin;
    fetchurl = pkgs.fetchurl;
    makeDesktopItem = pkgs.makeDesktopItem;
    makeDesktopIcon = pkgsErosanix.makeDesktopIcon;
    copyDesktopItems = pkgs.copyDesktopItems;
    copyDesktopIcons = pkgsErosanix.copyDesktopIcons;
  };

  pinga = pkgs.callPackage ./pinga {
    stdenv = pkgs.stdenv;
    lib = pkgs.lib;
    mkWindowsApp = pkgsErosanix.mkWindowsApp;
    wine = pkgs.proton-ge-bin;
    fetchurl = pkgs.fetchurl;
    makeDesktopItem = pkgs.makeDesktopItem;
    makeDesktopIcon = pkgsErosanix.makeDesktopIcon;
    copyDesktopItems = pkgs.copyDesktopItems;
    copyDesktopIcons = pkgsErosanix.copyDesktopIcons;
    unzip = pkgs.unzip;
  };
}
