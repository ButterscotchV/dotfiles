{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (prismlauncher.override {
      additionalPrograms = [ ffmpeg ];
      jdks = [
        temurin-jre-bin-8
        temurin-jre-bin-17
        temurin-jre-bin-21
      ];
    })

    lutris
    parsec-bin
    slimevr
  ];
}
