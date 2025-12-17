# NixOS Dotfiles

A flake-based NixOS and home-manager configuration for a development-focused AMD laptop running KDE Plasma 6.

## Installation

To deploy this configuration on a new machine:

1. Install NixOS with flakes support.
2. Clone or symlink this repository to `/etc/nixos`.
3. Update the `flake.nix` file to point to your new machine's hardware configuration.
4. Run `sudo nixos-rebuild switch --flake .#your-machine-name` to apply the configuration.

## Usage

To format the project, use:

```bash
nix fmt .
```

To check the configuration for errors, run:

```bash
nix flake check
```

## Configuration

### Adding a New Host

1. Generate a hardware configuration for the new host:

    ```bash
    sudo nixos-generate-config --root /mnt > hardware/new-host/default.nix
    ```

2. Add the new host to the `nixosConfigurations` in `flake.nix`.

### Secrets Management

To manage secrets like SSH keys or API tokens, you can create a `secrets` folder in `home/butterscotch/`. This folder is ignored by git.

Example `home/butterscotch/secrets/default.nix`:

```nix
{
  # Example SSH key configuration
  # ssh.main_key.private = "/home/butterscotch/.ssh/id_rsa";
  # ssh.main_key.public = "/home/butterscotch/.ssh/id_rsa.pub";

  # Example credential paths
  # credentials.github_token = builtins.readFile ~/.config/github-token;
}
```

Then, import it in your home-manager configuration. For production use, consider a more robust solution like [agenix](https://github.com/ryantm/agenix) or [sops-nix](https://github.com/Mic92/sops-nix).

### Package Pinning

To pin a package to a specific version, you can override its attributes in your configuration.

Example:

```nix
pkgs.somepackage.overrideAttrs (old: {
  version = "1.2.3";
  src = pkgs.fetchurl {
    url = "https://example.com/package-1.2.3.tar.gz";
    sha256 = "...";
  };
})
```
