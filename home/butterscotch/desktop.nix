{
  config,
  pkgs,
  pkgs-stable,
  ...
}:

{
  home.packages = with pkgs; [
    vrcx
    pkgs-stable.wayvr
    insync
    (import ../../modules/user/insync-dolphin.nix {
      lib = pkgs.lib;
      stdenv = pkgs.stdenv;
      fetchurl = pkgs.fetchurl;
      dpkg = pkgs.dpkg;
    })
  ];

  programs.git.signing = {
    key = "6787CAC34691043E";
    signByDefault = true;
  };
}
