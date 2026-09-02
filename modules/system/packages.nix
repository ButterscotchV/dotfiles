{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    dos2unix
    git
    nano
    openssh
    vim
    wget
  ];
}
