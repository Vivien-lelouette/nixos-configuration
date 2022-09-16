{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {

    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [
      	  ./computers/desktop.nix
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
          ./modules/base.nix
        ];
    };
  };
}
