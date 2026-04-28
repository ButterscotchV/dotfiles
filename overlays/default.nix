{ config, pkgs, ... }:

{
  imports = [
    ./openldap.nix
  ];
}
