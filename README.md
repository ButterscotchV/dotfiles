# NixOS Dotfiles

A flake-based NixOS and home-manager configuration for AMD systems running KDE Plasma 6.

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

### Adding a New Host

1. Generate a hardware configuration for the new host:

    ```bash
    sudo nixos-generate-config --root /mnt > hosts/new-host/hardware-configuration.nix
    ```

2. Create a `default.nix` and `users.nix` for the new host in `hosts/new-host/`.

3. Add the new host to the `nixosConfigurations` in `flake.nix`.
