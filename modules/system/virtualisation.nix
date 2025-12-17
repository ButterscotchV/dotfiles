{ config, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    logDriver = "json-file";
    extraOptions = "--log-opt max-size=10m --log-opt max-file=3";
  };
}
