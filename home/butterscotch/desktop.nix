{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    vrcx
  ];

  programs.git.signing = {
    key = "6787CAC34691043E";
    signByDefault = true;
  };
}
