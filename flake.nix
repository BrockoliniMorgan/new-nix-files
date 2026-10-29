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
        nvidia-desktop = {
          system = "x86_64-linux";
          type = [ "media" ];
        };
        dell-server = {
          system = "x86_64-linux";
          type = [ "media" ];
        };
      };

      createSystem =
        hostName: system:
        lib.nixosSystem {
          inherit system;
          modules = [
            disko.nixosModules.disko
            impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            ./hardware
            ./system
            ./home/nixos-home.nix
          ];
          specialArgs = {
            inherit inputs hostName userName;
            nixpkgsConf = {
              inherit overlays allowUnfreePackages;
            };
          };
        };

      createServer = hostName: { system, type }: {
        ${hostName} = (createSystem hostName system).extendModules {
          modules = [
            ./system/servers
            {
              server = { inherit type; };
            }
          ];
        };
      };
      createWorkstation = hostName: system: {
        ${hostName} = (createSystem hostName system).extendModules {
          modules = [
            ./system/workstations
            ./home/workstations/nixos-home.nix
          ];
        };
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

      formatter.x86_64-linux = treefmtEval.config.build.wrapper;
    };
}
