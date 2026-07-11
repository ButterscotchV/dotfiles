{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openssh
    dos2unix
    git
    wget
    vim
  ];
}
