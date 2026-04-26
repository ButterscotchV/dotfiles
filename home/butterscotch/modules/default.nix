{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./shell.nix
  ];

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
        credentialStore = "cache";
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
}
