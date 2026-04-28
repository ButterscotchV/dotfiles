{ config, pkgs, ... }:

{
  imports = [
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
        dotnet-aspnetcore_8
        dotnet-aspnetcore_9
        dotnet-aspnetcore_10
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
  };
}
