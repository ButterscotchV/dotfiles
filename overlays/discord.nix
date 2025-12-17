{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      discord =
        (final.callPackage (
          final.fetchFromGitHub {
            owner = "ButterscotchV";
            repo = "nixpkgs";
            rev = "discord-fhsenv";
            hash = "sha256-FwgLg3uMRaOqUDtJTCklJGNep4RpHZ/hOAibNLujU0Y=";
          }
          + "/pkgs/applications/networking/instant-messengers/discord/default.nix"
        ) { }).discord;
    })
  ];
}
