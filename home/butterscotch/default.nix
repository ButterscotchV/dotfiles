{ config, pkgs, ... }:

let
in
{
  imports = [
    # ./ssh # Disabled: requires secrets/default.nix
    ./shell.nix
    ./modules
  ];

  home.username = "butterscotch";
  home.homeDirectory = "/home/butterscotch";

  home.stateVersion = "25.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
