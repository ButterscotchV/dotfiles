{
  description = "NixOS configuration with home-manager";

  inputs = {
    # This is pointing to an unstable release.
    # If you prefer a stable release instead, you can this to the latest number shown here: https://nixos.org/download
    # i.e. nixos-24.11
    # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      nixos-hardware,
      home-manager,
      plasma-manager,
      nixpkgs-xr,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      formatter.${system} = pkgs.nixfmt-tree;

      nixosConfigurations = {
        lamb-laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit pkgs-stable;
            inherit nixpkgs-xr;
          };
          modules = [
            ./overlays/xr-pkgs.nix
            ./hosts/lamb-laptop
            home-manager.nixosModules.home-manager
            {
              imports = [
                ./hosts/lamb-laptop/users.nix
              ];
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
              home-manager.extraSpecialArgs = { inherit pkgs-stable; };
            }
            nixos-hardware.nixosModules.lenovo-ideapad-s145-15api
          ];
        };

        lamb-desktop-2 = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit pkgs-stable;
            inherit nixpkgs-xr;
          };
          modules = [
            ./overlays/xr-pkgs.nix
            ./hosts/lamb-desktop-2
            home-manager.nixosModules.home-manager
            {
              imports = [
                ./hosts/lamb-desktop-2/users.nix
              ];
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
              home-manager.extraSpecialArgs = { inherit pkgs-stable; };
            }
            nixos-hardware.nixosModules.common-cpu-amd
            nixos-hardware.nixosModules.common-cpu-amd-pstate
            nixos-hardware.nixosModules.common-cpu-amd-raphael-igpu
            nixos-hardware.nixosModules.common-gpu-amd
            nixos-hardware.nixosModules.common-gpu-intel-disable
            nixos-hardware.nixosModules.common-gpu-nvidia-disable
            nixos-hardware.nixosModules.common-pc
            nixos-hardware.nixosModules.common-pc-ssd
          ];
        };
      };
    };
}
