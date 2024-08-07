{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/master";
  inputs.xremap.url = "github:xremap/nix-flake";

  # TODO remove when this issue is fixed : https://github.com/NixOS/nixpkgs/issues/330889
  inputs.dbeaver-last.url = "github:nixos/nixpkgs/4d10225ee46c0ab16332a2450b493e0277d1741a";

  outputs = { self, nixpkgs, xremap, dbeaver-last }: {

    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [
      	  ./computers/desktop.nix
          xremap.nixosModules.default
          ./modules/xremap.nix
          ./modules/base.nix
          ./modules/gaming.nix
      	  ./modules/music.nix
        ];
    };

    nixosConfigurations.p15s = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [
          ./computers/p15s.nix
          xremap.nixosModules.default
          ./modules/xremap.nix
          ./modules/base.nix
          ./modules/gaming.nix
          ./modules/music.nix
        ];
    };

    nixosConfigurations.t450 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [
          ./computers/t450.nix
          xremap.nixosModules.default
          ./modules/xremap.nix
          ./modules/base.nix
        ];
    };

    nixosConfigurations.xps = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        ./computers/xps.nix
        xremap.nixosModules.default
        ./modules/xremap.nix
        ./modules/base.nix
        ./modules/development.nix
      ];
      # TODO remove when this issue is fixed : https://github.com/NixOS/nixpkgs/issues/330889
      specialArgs = { inherit dbeaver-last; };
    };
  };
}
