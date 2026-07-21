{
  lib,
  config,
  pkgs,
  ...
}:

{
  services.plex = {
    enable = true;
    openFirewall = true;
    user = "butterscotch";
  };
  systemd.services.plex.serviceConfig =
    let
      pidFile = "${config.services.plex.dataDir}/Plex Media Server/plexmediaserver.pid";
    in
    {
      # Allow access to home directory
      ProtectHome = lib.mkForce false;
      # Fix "A stop job is running for Plex Media Server" preventing system shutdown
      KillSignal = lib.mkForce "SIGKILL";
      Restart = lib.mkForce "no";
      TimeoutStopSec = 10;
      ExecStop = pkgs.writeShellScript "plex-stop" ''
        ${pkgs.procps}/bin/pkill --signal 15 --pidfile "${pidFile}"

        # Wait until Plex service has been shutdown
        # by checking if the PID file is gone
        while [ -e "${pidFile}" ]; do
          sleep 0.1
        done

        ${pkgs.coreutils}/bin/echo "Plex Media Server shutdown successful"
      '';
      PIDFile = lib.mkForce "";
    };
}
