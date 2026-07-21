{ pkgs, ... }:

{
  imports = [
    ../../modules/package-sources.nix
    ./packages.nix
    ./shell.nix
    ./plasma.nix
    ./flatpak.nix
  ];

  home.username = "butterscotch";
  home.homeDirectory = "/home/butterscotch";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-qt;
  };

  # Some default programs and settings.
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {
        name = "Butterscotch!";
        email = "bscotchvanilla@gmail.com";
      };
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      credential = {
        helper = "manager";
        "https://github.com".username = "ButterscotchV";
        credentialStore = "gpg";
      };
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (
      ps: with ps; [
        cargo
        dotnet-aspnetcore_10
        dotnet-aspnetcore_11
        dotnet-sdk_10
        dotnet-sdk_11
        mono
        nodejs
        openssl.dev
        pkg-config
        python3
        rustc
        rustup
        temurin-bin-17
        temurin-bin-21
        temurin-bin-25
        zlib
      ]
    );
  };

  services.easyeffects = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];
  };

  programs.obs-studio = {
    enable = true;

    plugins = with pkgs.obs-studio-plugins; [
      obs-backgroundremoval
      obs-pipewire-audio-capture
      wlrobs
      # Optional AMD hardware acceleration
      obs-gstreamer
      obs-vaapi
      obs-vkcapture
    ];
  };
}
