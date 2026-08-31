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
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-wrapper-modules = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      impermanence,
      disko,
      treefmt-nix,
      sops-nix,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
      allowUnfreePackages = [
        "steam"
        "steam-unwrapped"
      ];
      overlays = [
        (import ./wrappers inputs)
      ];
      pkgs-per-system =
        system:
        import nixpkgs {
          inherit system overlays;
          config.allowUnfreePackages = allowUnfreePackages;
        };
      userName = "brock";
      workstations = [
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
      servers = [
        {
          hostName = "nvidia-desktop";
          system = "x86_64-linux";
        }
      ];
      createSystem =
        { hostName, system }:
        lib.nixosSystem {
          inherit system;
          modules = [
            {
              nixpkgs.config.allowUnfreePackages = allowUnfreePackages;
              nixpkgs.overlays = overlays;
            }
            disko.nixosModules.disko
            impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops
            ./hardware
            ./system
            (
              { specialArgs, ... }:
              {
                home-manager = {
                  backupFileExtension = "bkp";
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.${userName} = ./home;
                  extraSpecialArgs = specialArgs;
                };
              }
            )
          ];
          specialArgs = {
            inherit inputs hostName userName;
          };
        };
      createServer = details: {
        ${details.hostName} = createSystem details;
      };
      createWorkstation = details: {
        ${details.hostName} = (createSystem details).extendModules {
          modules = [
            ./system/workstations
            {
              home-manager.users.${userName}.imports = [
                ./home/workstations
              ];
            }
          ];
        };
      };
      createHome =
        { system, ... }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs-per-system system;
          modules = [
            ./home
          ];
          extraSpecialArgs = {
            inherit inputs userName;
          };
        };

      createHomeWorkstation = details: {
        "${userName}@${details.hostName}" = (createHome details).extendModules {
          modules = [
            ./home/workstations
          ];
        };
      };
      createHomeServer = details: {
        "${userName}@${details.hostName}" = createHome details;
      };

      treefmtEval = treefmt-nix.lib.evalModule (pkgs-per-system "x86_64-linux") {
        projectRootFile = "flake.nix";
        programs.nixfmt.enable = true;
      };
      applyToList = function: list: builtins.foldl' (acc: new: acc // new) { } (map function list);

    in
    {
      nixosConfigurations =
        applyToList createWorkstation workstations // applyToList createServer servers;
      homeConfigurations =
        applyToList createHomeWorkstation workstations // applyToList createHomeServer servers;
      formatter.x86_64-linux = treefmtEval.config.build.wrapper;
    };
}
