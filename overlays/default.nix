{ ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      # Workaround for openldap build failures on i686
      # See: https://github.com/NixOS/nixpkgs/issues/514113
      openldap = prev.openldap.overrideAttrs {
        doCheck = !prev.stdenv.hostPlatform.isi686;
      };
      insync-dolphin = prev.callPackage ./insync-dolphin.nix { };
    })
  ];
}
