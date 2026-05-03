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
  ];

  programs.git.signing = {
    key = "6787CAC34691043E";
    signByDefault = true;
  };
}
