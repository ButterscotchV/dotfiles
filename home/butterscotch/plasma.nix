{ ... }:

{
  programs.plasma = {
    enable = true;

    kwin = {
      edgeBarrier = 0;
      cornerBarrier = false;

      effects.shakeCursor.enable = false;
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
            kickoff = {
              icon = "steam_icon_1677310";
              showButtonsFor.custom = [
                "suspend"
                "reboot"
                "shutdown"
              ];
            };
          }
          {
            pager = { };
          }
          {
            iconTasks = {
              launchers = [
                "preferred://filemanager"
                "applications:spotify.desktop"
                "applications:firefox.desktop"
                "applications:org.telegram.desktop.desktop"
                "applications:discord.desktop"
              ];
            };
          }
          {
            panelSpacer = {
              expanding = true;
            };
          }
          "org.kde.plasma.marginsseparator"
          {
            systemTray = {
              items.extra = [
                "org.kde.plasma.notifications"
                "org.kde.plasma.mediacontroller"
                "org.kde.plasma.devicenotifier"
                "org.kde.plasma.manage-inputmethod"
                "org.kde.plasma.cameraindicator"
                "org.kde.kscreen"
                "org.kde.plasma.battery"
                "org.kde.plasma.printmanager"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.keyboardlayout"
                "org.kde.plasma.keyboardindicator"
                "org.kde.plasma.volume"
                "org.kde.plasma.clipboard"
                "org.kde.plasma.brightness"
                "org.kde.plasma.bluetooth"
              ];
            };
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
      wallpaper = [
        ../../displays/wallpapers/1.png
        ../../displays/wallpapers/2.png
      ];
    };
  };
}
