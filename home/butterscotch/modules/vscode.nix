{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (
      ps: with ps; [
        cargo
        rustc
        zlib
        openssl.dev
        pkg-config
        temurin-bin-17
        temurin-bin-21
        nodejs
        dotnet-aspnetcore_8
        dotnet-aspnetcore_9
        python3
      ]
    );
  };
}
