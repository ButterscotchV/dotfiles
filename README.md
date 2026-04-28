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
nix fmt
```

To check the configuration for errors, run:

```bash
nix flake check
```

## Configuration

### Adding a New Host

1. Generate a hardware configuration for the new host:

    ```bash
    sudo nixos-generate-config --root /mnt > hosts/new-host/default.nix
    ```

2. Add the new host to the `nixosConfigurations` in `flake.nix`.

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
