{ pkgs, ... }:

{
  # Gaming mouse configuration
  services.ratbagd.enable = true;
  environment.systemPackages = with pkgs; [
    piper
  ];
}
