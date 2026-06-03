{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    vrcx
    wayvr
    insync
    unityhub
    alcom
  ];

  programs.git.signing = {
    key = "6787CAC34691043E";
    signByDefault = true;
  };
}
