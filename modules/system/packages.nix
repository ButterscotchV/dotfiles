{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    dos2unix
    git
    htop
    nano
    openssh
    vim
    wget
  ];
}
