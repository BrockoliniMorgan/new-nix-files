{ nixpkgsConf, ... }:
{
  nixpkgs = {
    inherit (nixpkgsConf) overlays;
    config = {
      inherit (nixpkgsConf) allowUnfreePackages;
    };
  };
}
