{
  description = "NixOS configuration with home-manager";

  inputs = {
    # This is pointing to an unstable release.
    # If you prefer a stable release instead, you can this to the latest number shown here: https://nixos.org/download
    # i.e. nixos-24.11
    # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";
    # nixpkgs-fast.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nixpkgs-mesa-26_1_2.url = "github:NixOS/nixpkgs/3e41b24abd260e8f71dbe2f5737d24122f972158";
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    erosanix = {
      url = "github:emmanuelrosa/erosanix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.url = "github:NixOS/flake-compat";
    };
    affinity-nix = {
      url = "github:mrshmllow/affinity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/latest";
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
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-tree;

      nixosConfigurations = {
        lamb-laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
          };
          modules = with nixos-hardware.nixosModules; [
            ./hosts/lamb-laptop
            home-manager.nixosModules.home-manager
            {
              imports = [
                ./hosts/lamb-laptop/users.nix
              ];
              home-manager = {
                extraSpecialArgs = { inherit inputs; };
                useGlobalPkgs = true;
                useUserPackages = true;
                sharedModules = [ plasma-manager.homeModules.plasma-manager ];
              };
            }
            lenovo-ideapad-s145-15api
          ];
        };

        lamb-desktop-2 = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
          };
          modules = with nixos-hardware.nixosModules; [
            ./hosts/lamb-desktop-2
            home-manager.nixosModules.home-manager
            {
              imports = [
                ./hosts/lamb-desktop-2/users.nix
              ];
              home-manager = {
                extraSpecialArgs = { inherit inputs; };
                useGlobalPkgs = true;
                useUserPackages = true;
                sharedModules = [ plasma-manager.homeModules.plasma-manager ];
              };
            }
            common-cpu-amd
            common-cpu-amd-pstate
            common-cpu-amd-raphael-igpu
            common-gpu-amd
            common-gpu-intel-disable
            common-gpu-nvidia-disable
            common-pc
            common-pc-ssd
            "${nixos-hardware}/common/wifi/mediatek/mt7925"
            "${nixos-hardware}/common/wifi/mediatek/mt7925/iwd.nix"
          ];
        };
      };
    };
}
