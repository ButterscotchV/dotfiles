{ ... }:

{
  # Workaround for openldap build failures on i686
  # See: https://github.com/NixOS/nixpkgs/issues/514113
  nixpkgs.overlays = [
    (_: prev: {
      openldap = prev.openldap.overrideAttrs {
        doCheck = !prev.stdenv.hostPlatform.isi686;
      };
    })
  ];
}
