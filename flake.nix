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
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      impermanence,
      disko,
      treefmt-nix,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
      overlays = [
        (import ./overrides)
      ];
      allowUnfreePackages = [
        "steam"
        "steam-unwrapped"
      ];
      pkgs-per-system =
        system:
        import nixpkgs {
          inherit system overlays;
          config.allowUnfreePackages = allowUnfreePackages;
        };

      userName = "brock";
      workstations = {
        vivobook = "x86_64-linux";
        thinkpad = "x86_64-linux";
        desktop = "x86_64-linux";
      };
      servers = {
        nvidia-desktop = "x86_64-linux";
        dell-server = "x86_64-linux";
      };

      createSystem =
        hostName: system:
        lib.nixosSystem {
          inherit system;
          modules = [
            {
              nixpkgs = {
                inherit overlays;
                config.allowUnfreePackages = allowUnfreePackages;
              };
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
                  users.${specialArgs.userName} = ./home;
                  extraSpecialArgs = specialArgs;
                };
              }
            )
          ];
          specialArgs = {
            inherit inputs hostName userName;
          };
        };

      createServer = hostName: system: {
        ${hostName} = (createSystem hostName system).extendModules {
          modules = [
            ./system/servers
          ];
        };
      };
      createWorkstation = hostName: system: {
        ${hostName} = (createSystem hostName system).extendModules {
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
        hostName: system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs-per-system system;
          modules = [
            ./home
          ];
          extraSpecialArgs = {
            inherit inputs userName;
          };
        };

      createHomeWorkstation = hostName: system: {
        "${userName}@${hostName}" = (createHome hostName system).extendModules {
          modules = [
            ./home/workstations
          ];
        };
      };
      createHomeServer = hostName: system: {
        "${userName}@${hostName}" = createHome hostName system;
      };

      treefmtEval = treefmt-nix.lib.evalModule (pkgs-per-system "x86_64-linux") {
        projectRootFile = "flake.nix";
        programs.nixfmt.enable = true;
      };
    in
    {
      nixosConfigurations =
        with lib.attrsets;
        concatMapAttrs createWorkstation workstations // concatMapAttrs createServer servers;
      homeConfigurations =
        with lib.attrsets;
        concatMapAttrs createHomeWorkstation workstations // concatMapAttrs createHomeServer servers;
      formatter.x86_64-linux = treefmtEval.config.build.wrapper;
    };
}
