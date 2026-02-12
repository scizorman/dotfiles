{
  description = "scizorman's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-wsl,
      nix-darwin,
      home-manager,
      ...
    }:
    {
      nixosConfigurations."powder" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          ./modules/nixos-wsl
          ./hosts/powder
          home-manager.nixosModules.home-manager
        ];
      };

      darwinConfigurations."groomed" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./modules/darwin
          ./hosts/groomed
          home-manager.darwinModules.home-manager
        ];
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-tree;
    };
}
