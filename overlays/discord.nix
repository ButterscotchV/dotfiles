{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      discord =
        (final.callPackage (
          final.fetchFromGitHub {
            owner = "FlameFlag";
            repo = "nixpkgs";
            rev = "flameflag/push-vmswpuqmvzpt";
            hash = "sha256-3yen/J8OZp06riulNo6MU/KQYwlxwc+EAH/0GeYJJbs=";
          }
          + "/pkgs/applications/networking/instant-messengers/discord/default.nix"
        ) { }).discord;
    })
  ];
}
