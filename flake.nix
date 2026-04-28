{
  description = "NixOS configuration with home-manager";

  inputs = {
    # This is pointing to an unstable release.
    # If you prefer a stable release instead, you can this to the latest number shown here: https://nixos.org/download
    # i.e. nixos-24.11
    # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      home-manager,
      plasma-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      formatter.${system} = pkgs.nixfmt-tree;

      nixosConfigurations = {
        lamb-laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/lamb-laptop

            home-manager.nixosModules.home-manager
            {
              imports = [
                ./hosts/lamb-laptop/users.nix
              ];

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
            }

            nixos-hardware.nixosModules.lenovo-ideapad-s145-15api
          ];
        };

        lamb-desktop-2 = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/lamb-desktop-2

            home-manager.nixosModules.home-manager
            {
              imports = [
                ./hosts/lamb-desktop-2/users.nix
              ];

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
            }
          ];
        };
      };
    };
}
