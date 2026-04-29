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
    autosuggestion.enable = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "python"
        "man"
        "gradle"
      ];
    };
  };

  programs.bash.enable = true;
  programs.direnv.enable = true;

  # nom
  programs.nix-your-shell.nix-output-monitor.enable = true;
}
