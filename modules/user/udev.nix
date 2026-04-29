{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.udev;
in
{
  options.services.udev.extraFiles = lib.mkOption {
    type = lib.types.listOf lib.types.path;
    default = [ ];
    description = "List of udev rules files to install";
  };

  config = lib.mkIf (cfg.extraFiles != [ ]) {
    services.udev.packages = [
      (pkgs.runCommandLocal "custom-udev-rules" { } ''
        dest="$out/lib/udev/rules.d"
        mkdir -p "$dest"
        ${lib.concatMapStringsSep "\n" (file: ''
          cp "${file}" "$dest/${baseNameOf file}"
        '') cfg.extraFiles}
      '')
    ];
  };
}
