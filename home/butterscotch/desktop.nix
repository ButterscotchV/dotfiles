{
  config,
  pkgs,
  pkgsStable,
  ...
}:

{
  home.packages = with pkgs; [
    vrcx
    pkgsStable.wayvr
    insync
  ];

  programs.git.signing = {
    key = "6787CAC34691043E";
    signByDefault = true;
  };
}
