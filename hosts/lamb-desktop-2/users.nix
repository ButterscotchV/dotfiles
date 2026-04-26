{
  home-manager.users.butterscotch = { config, pkgs, ... }: {
    imports = [
      ../../home/butterscotch
    ];

    home.stateVersion = "25.11";
  };
}
