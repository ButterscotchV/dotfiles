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
        "docker"
        "docker-compose"
      ];
    };
  };

  programs.bash.enable = true;

  environment.shellAliases = {
    idea-bg = "nohup idea . >/dev/null 2>&1 &";
    nixos-switch = "nixos-rebuild switch --sudo |& nom";
    nixos-boot = "nixos-rebuild boot --sudo |& nom";
  };
}
