{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dos2unix
    git
    wget
    vim
  ];
}
