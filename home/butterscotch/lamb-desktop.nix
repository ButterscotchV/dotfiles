{
  pkgs,
  pkgsStable,
  ...
}:

{
  home.packages = with pkgs; [
    # === File management/sync ===
    pkgsStable.insync

    # === VR ===
    wayvr

    # === VRChat ===
    alcom
    unityhub
    vrcx
  ];

  programs.git.signing = {
    key = "6787CAC34691043E";
    signByDefault = true;
  };
}
