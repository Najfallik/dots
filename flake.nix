{
  description = "sikko's flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nix-cachyos-kernel = {
    url = "github:xddxdd/nix-cachyos-kernel/release";
    };
    
    helium-browser.url = "github:schembriaiden/helium-browser-nix-flake";    
  };

  outputs = { self, nixpkgs, nix-cachyos-kernel, ... }@inputs: {
    nixosConfigurations = {
      nix-btw = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		specialArgs = { inherit inputs; };
		modules = [
			./configuration.nix
		];
      };
    };

  };
}
