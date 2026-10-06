{
  pkgs,
  libErosanix,
  ...
}:

let
  xwintab = pkgs.callPackage ./xwintab { };
in
{
  aternos-thanos = pkgs.callPackage ./aternos-thanos { };

  rebelle = pkgs.callPackage ./rebelle {
    inherit xwintab libErosanix;
    wine = pkgs.wineWow64Packages.staging;
  };

  pinga = pkgs.callPackage ./pinga {
    inherit libErosanix;
    wine = pkgs.wineWow64Packages.stable;
  };

  pingo = pkgs.callPackage ./pingo {
    wine = pkgs.wineWow64Packages.stable;
  };

  insync-dolphin = pkgs.callPackage ./insync-dolphin {
    ECM = pkgs.kdePackages.extra-cmake-modules;
  };
}
