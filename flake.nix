{
  description = "A simple NixOS flake";

  inputs = {
    self.submodules = true;
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      ...
    }@inputs:

    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgsStable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
      callPackage = pkgs.callPackage;
    in
    {
      nixosConfigurations = {
        lamb-laptop = lib.nixosSystem rec {
          inherit system;
          specialArgs = {
            inherit inputs pkgsStable;
          };

          modules = [
            {
              environment.systemPackages = [
              ];
            }
            { nixpkgs.overlays = [ ]; }
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.butterscotch = import ./home/butterscotch/default.nix;
              home-manager.extraSpecialArgs = specialArgs;
            }
          ];
        };
      };
    };
}
