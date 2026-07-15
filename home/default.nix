{ inputs, pkgs, ... }:
{
  imports = [
    ./home.nix
    ./theme
    ./packages.nix
    inputs.nvf.homeManagerModules.nvf
    {
      programs.nvf = {
        enable = true;
        defaultEditor = true;
        settings.vim = import ./neovim { inherit pkgs; };
      };
    }
  ];
}
