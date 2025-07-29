{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/master";
  inputs.xremap.url = "github:xremap/nix-flake";
  inputs.waybar-git = {
    url = "github:Alexays/Waybar";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.zen-browser.url = "git+https://codeberg.org/0x57e11a/flake-zen";

  outputs = inputs: {

    nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
				inherit inputs;
			};
      modules =
        [
      	  ./computers/desktop.nix
          inputs.xremap.nixosModules.default
          ./modules/xremap.nix
          ./modules/base.nix
          ./modules/gaming.nix
      	  ./modules/music.nix
        ];
    };

    nixosConfigurations.p15s = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
				inherit inputs;
			};
      modules =
        [
          ./computers/p15s.nix
          inputs.xremap.nixosModules.default
          ./modules/xremap.nix
          ./modules/base.nix
          ./modules/gaming.nix
          ./modules/music.nix
        ];
    };

    nixosConfigurations.t450 = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
				inherit inputs;
			};
      modules =
        [
          ./computers/t450.nix
          inputs.xremap.nixosModules.default
          ./modules/xremap.nix
          ./modules/base.nix
        ];
    };

    nixosConfigurations.xps = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
				inherit inputs;
		};
    modules =
      [
        ./computers/xps.nix
        inputs.xremap.nixosModules.default
        ./modules/xremap.nix
        ./modules/base.nix
        ./modules/development.nix
      ];
    };


    nixosConfigurations.dellp15 = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
				inherit inputs;
		};
    modules =
      [
        ./computers/dellp15.nix
        inputs.xremap.nixosModules.default
        ./modules/xremap.nix
        ./modules/base.nix
        ./modules/development.nix
      ];
    };
  };
}
