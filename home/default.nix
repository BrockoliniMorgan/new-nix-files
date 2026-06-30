{ inputs, ... }:
{
  imports = [
    ./home.nix
    ./theme
    inputs.nvf.homeManagerModules.nvf
  ];
}
