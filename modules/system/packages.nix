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

  # Macro software
  services.crossmacro = {
    enable = true;
    users = [ "butterscotch" ];
  };
}
