{
  description = "My NixOS configuratio";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        
        home-manager.nixosModules.default

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.extraSpecialArgs = { inherit inputs; };

          home-manager.users.alexx = import ./home.nix;
        }
      ];
    };
  };
}
