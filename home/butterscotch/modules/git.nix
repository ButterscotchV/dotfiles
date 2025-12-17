{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {
        name = "Butterscotch!";
        email = "bscotchvanilla@gmail.com";
      };
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      credential = {
        helper = "manager";
        "https://github.com".username = "ButterscotchV";
        credentialStore = "cache";
      };
    };
  };
}
