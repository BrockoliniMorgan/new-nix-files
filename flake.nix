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
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, impermanence, disko, ... }@inputs: 
  let
    inherit (nixpkgs) lib;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "steam" "steam-unwrapped" ];
    pkgs-per-system = system: import nixpkgs {
      inherit system;
      config.allowUnfreePredicate = allowUnfreePredicate;
    };
    systems = [
      {
        hostName = "vivobook";
        system = "x86_64-linux";
      }
      {
        hostName = "thinkpad";
        system = "x86_64-linux";
      }
      {
        hostName = "desktop";
        system = "x86_64-linux";
      }
    ];
    createSystem = { hostName, system }: {
      ${hostName} = lib.nixosSystem {
        inherit system;
        modules = [
          {
            nixpkgs.config.allowUnfreePredicate = allowUnfreePredicate;
          }
          disko.nixosModules.disko
          impermanence.nixosModules.impermanence
          home-manager.nixosModules.home-manager
          ./hardware
          ./system
          (
            { specialArgs, ... }:
            {
              home-manager = {
                backupFileExtension = "bkp";
                useGlobalPkgs = true;
                useUserPackages = true;
                users.brock = ./home;
                extraSpecialArgs = specialArgs;
              };
            }
          )
        ];
        specialArgs = {
          inherit inputs hostName;
        };
      };
    };
    createHome = { hostName, system }: {
      "brock@${hostName}" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs-per-system system;
        modules = [
          ./home
        ];
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };

  in {
    nixosConfigurations = builtins.foldl' (acc: new: acc // new) { } (lib.map createSystem systems);
    homeConfigurations = builtins.foldl' (acc: new: acc // new) { } (lib.map createHome systems);
  };
}
