{ config, pkgs, ... }:

{
  imports = [
    ./discord
    ./openldap.nix
  ];
}
