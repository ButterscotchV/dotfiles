{ config, ... }:

let
  userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0";
in
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

  home.shellAliases = {
    # Easy NixOS tools
    nixos-switch = "nixos-rebuild switch --sudo";
    nixos-boot = "nixos-rebuild boot --sudo";
    nixos-size = "nix path-info --json --all --json-format 1 | jq 'map(.narSize) | add' | numfmt --to=iec-i --suffix=B";
    nixos-clean = "nix-collect-garbage -d && sudo nix-collect-garbage -d && nix store optimise";
    nixos-repair = "sudo nix-store --verify --check-contents --repair";

    # Utility
    idea-bg = "nohup idea . >/dev/null 2>&1 &";
    yt-dlp-auto = "yt-dlp --embed-metadata --embed-subs --sub-lang 'en' -f bv\*+ba/b";
    yt-dlp-auto-b = "yt-dlp-auto --cookies-from-browser firefox --user-agent '${userAgent}'";
    yt-dlp-audio = "yt-dlp --embed-metadata -f ba -x";
    yt-dlp-audio-b = "yt-dlp-audio --cookies-from-browser firefox --user-agent '${userAgent}'";
  };
}
