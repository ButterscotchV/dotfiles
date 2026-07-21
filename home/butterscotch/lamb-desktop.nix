{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    alcom
    insync
    unityhub
    vrcx
    wayvr
  ];

  programs.git.signing = {
    key = "6787CAC34691043E";
    signByDefault = true;
  };
}
