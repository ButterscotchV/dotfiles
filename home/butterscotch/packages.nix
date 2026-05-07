{
  config,
  pkgs,
  pkgs-stable,
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
    pkgsRocm.blender

    # === CD Ripping ===
    kdePackages.audiocd-kio
    cyanrip

    # === Office ===
    libreoffice-qt
    hunspell # For LibreOffice
    hyphenDicts.en_US # For LibreOffice
    onlyoffice-desktopeditors

    # === Security ===
    bitwarden-desktop
    kdePackages.kleopatra # GPG GUI

    # === Runtimes ===
    bottles

    # === Desktop, shell, and appearance ===
    nerd-fonts.fira-code
    displaycal
    kdePackages.kfind

    # === Development ===
    git-credential-manager
    (pkgs-stable.github-desktop.overrideAttrs (oldAttrs: {
      postFixup = ''
        wrapProgram "$out/bin/github-desktop" \
          --add-flags "--ozone-platform=x11"
      '';
    }))
    jq # JSON processor
    nix-output-monitor # nom
    nixfmt
    jetbrains.idea

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

    # === Networking ===
    proton-vpn
  ];
}
