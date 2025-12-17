{ config, pkgs, ... }:

{
  # starship - Customizable prompt for any shell
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = "${config.xdg.configHome}/zsh";
    autosuggestion = {
      enable = true;
    };
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "python"
        "man"
      ];
    };
    plugins = [ ];
  };

  programs.bash.enable = true;
  # programs.direnv.enable = true;
}
