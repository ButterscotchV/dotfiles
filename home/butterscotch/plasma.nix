{ config, pkgs, ... }:

{
  programs.plasma = {
    enable = true;

    kwin = {
      edgeBarrier = 0;
      cornerBarrier = false;
    };

    panels = [
      {
        screen = "all";
        location = "bottom";
        height = 44;
        floating = true;
        widgets = [
          {
            panelSpacer = {
              expanding = true;
            };
          }
          {
            kickoff = { };
          }
          {
            pager = { };
          }
          {
            iconTasks = { };
          }
          {
            panelSpacer = {
              expanding = true;
            };
          }
          "org.kde.plasma.marginsseparator"
          {
            systemTray = { };
          }
          {
            digitalClock = { };
          }
          "org.kde.plasma.showdesktop"
        ];
      }
    ];

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
    };
  };
}
