{ pkgs, pkgsStable, ... }:

{
  imports = [
    ../../modules/package-sources.nix
    ./packages.nix
    ./shell.nix
    ./plasma.nix
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
        rustc
        rustup
        zlib
        openssl.dev
        pkg-config
        temurin-bin-17
        temurin-bin-21
        nodejs
        mono
        dotnet-sdk_8
        dotnet-sdk_9
        dotnet-sdk_10
        dotnet-sdk_11
        dotnet-aspnetcore_8
        dotnet-aspnetcore_9
        dotnet-aspnetcore_10
        dotnet-aspnetcore_11
        python3
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

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  };

  programs.obs-studio = {
    enable = true;

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      #optional AMD hardware acceleration
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
    ];
  };
}
