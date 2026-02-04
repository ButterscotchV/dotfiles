{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # === Archive ===
    p7zip # 7z
    unzip
    xz
    zip

    # === Audio ===
    easyeffects
    pwvucontrol

    # === Browser ===
    firefox

    # === Communication ===
    discord
    telegram-desktop

    # === Media ===
    krita
    (plex-desktop.override {
      extraEnv = {
        QT_STYLE_OVERRIDE = "default";
      };
    })
    vlc
    spotify
    qbittorrent

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
    gtk3
    gtk4
    nerd-fonts.fira-code
    oh-my-zsh

    # === Development ===
    git-credential-manager
    github-desktop
    jq # JSON processor
    nix-output-monitor # nom
    nixfmt-rfc-style # nixfmt

    # === IDE ===
    jetbrains.idea

    # === Gaming ===
    (prismlauncher.override {
      additionalPrograms = [ ffmpeg ];
      jdks = [
        temurin-jre-bin-8
        temurin-jre-bin-17
        temurin-jre-bin-21
      ];
    })
    slimevr
  ];
}
