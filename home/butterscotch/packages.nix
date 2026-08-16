{
  pkgs,
  pkgsLocal,
  pkgsErosanix,
  pkgsStable,
  ...
}:

{
  home.packages = with pkgs; [
    # === Archive ===
    p7zip
    unzip
    xz
    zip

    # === Audio ===
    audacity
    kdePackages.kwave
    kid3-kde
    pwvucontrol

    # === Communication ===
    discord
    stoat-desktop
    telegram-desktop

    # === Media ===
    ffmpeg
    handbrake
    haruna
    kdePackages.kamoso
    kdePackages.kdenlive
    pkgsRocm.blender
    plex-desktop
    plexamp
    qbittorrent
    spotify
    vlc
    yt-dlp

    # === Art/image editing ===
    # TEMP 2026-08-16: Affinity is not downloading correctly
    # affinity-v3
    darktable
    gimp
    imagemagick
    inkscape
    krita
    pkgsLocal.pinga
    pkgsLocal.pingo
    pkgsLocal.rebelle

    # === CD ripping ===
    kdePackages.audiocd-kio
    # TEMP 2026-08-16: Cyanrip fails to build
    pkgsStable.cyanrip

    # === Office ===
    hunspell # Spellchecking for LibreOffice
    hyphenDicts.en_CA
    hyphenDicts.en_US
    kdePackages.skanlite
    kdePackages.skanpage
    libreoffice-qt
    onlyoffice-desktopeditors

    # === Security ===
    bitwarden-desktop
    kdePackages.kleopatra # GPG GUI

    # === Desktop, shell, and appearance ===
    displaycal
    kdePackages.kfind
    kdePackages.plasma-sdk
    nerd-fonts.fira-code

    # === Development ===
    git-credential-manager
    github-desktop
    jetbrains.idea
    jq # JSON processor
    nixd # Nix language server
    nixdoc
    nixfmt
    nrfconnect

    # === Gaming ===
    moonlight-qt
    owmods-gui
    (prismlauncher.override {
      additionalPrograms = [ ffmpeg ];
      jdks = [
        temurin-jre-bin-8
        temurin-jre-bin-17
        temurin-jre-bin-21
        temurin-jre-bin-25
      ];
    })
    r2modman
    slimevr

    # === Networking ===
    proton-vpn

    # === PC monitoring/management ===
    kdePackages.filelight
    kdePackages.ksystemlog
    mission-center
    nix-tree
    pkgsErosanix.mkwindowsapp-tools
    qdirstat
    resources

    # === Browsers ===
    google-chrome
  ];
}
