{ config, pkgs, ... }:

{
  imports = [
    ./discord.nix
    ./openldap.nix
  ];
}
