{ inputs, ... }:
{
  imports = [
    ./home.nix
    ./fonts.nix
    inputs.nvf.homeManagerModules.nvf
  ];
}
