{
  pkgs,
  pkgsLocal,
  ...
}:

{
  home.packages = with pkgs; [
    # === Archive ===
    p7zip # 7z
    unzip
    xz
    zip

    # === Audio ===
    pwvucontrol
    audacity
    kdePackages.kwave
    kid3-kde

    # === Communication ===
    discord
    telegram-desktop
    (stoat-desktop.override {
      electron_38 = electron;
    })

    # === Media ===
    krita
    (plex-desktop.override {
      extraEnv = {
        QT_STYLE_OVERRIDE = "default";
      };
    })
    plexamp
    vlc
    spotify
    qbittorrent
    ffmpeg
    handbrake
    pkgsRocm.blender
    pkgsLocal.rebelle
    affinity-v3
    gimp
    darktable
    pkgsLocal.pinga
    pkgsLocal.pingo
    kdePackages.kdenlive
    yt-dlp

    # === CD Ripping ===
    kdePackages.audiocd-kio
    cyanrip

    # === Office ===
    libreoffice-qt
    hunspell # For LibreOffice
    hyphenDicts.en_US # For LibreOffice
    onlyoffice-desktopeditors
    kdePackages.skanpage
    kdePackages.skanlite

    # === Security ===
    bitwarden-desktop
    kdePackages.kleopatra # GPG GUI

    # === Runtimes ===
    bottles
    wineWow64Packages.staging
    winetricks

    # === Desktop, shell, and appearance ===
    nerd-fonts.fira-code
    displaycal
    kdePackages.kfind
    kdePackages.plasma-sdk

    # === Development ===
    git-credential-manager
    github-desktop
    jq # JSON processor
    nix-output-monitor # nom
    nixfmt
    nixd
    nixdoc
    jetbrains.idea
    opencode

    # === Gaming ===
    (prismlauncher.override {
      additionalPrograms = [ ffmpeg ];
      jdks = [
        temurin-jre-bin-8
        temurin-jre-bin-17
        temurin-jre-bin-21
        temurin-jre-bin-25
      ];
    })
    slimevr
    moonlight-qt
    r2modman
    owmods-gui

    # === Networking ===
    proton-vpn

    # === PC Monitoring ===
    mission-center
    resources
    kdePackages.filelight
    qdirstat
  ];
}
