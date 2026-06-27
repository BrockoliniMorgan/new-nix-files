{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, impermanence, disko}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    nixosConfigurations.brock-vivobook = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        disko.nixosModules.disko
        impermanence.nixosModules.impermanence
        ./configuration.nix
	./persistence.nix
        ./disko.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.backupFileExtension = "bkp";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.brock = ./home;
        }
      ];
    };
    homeConfigurations.brock = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home
      ];
    };
  };
}
