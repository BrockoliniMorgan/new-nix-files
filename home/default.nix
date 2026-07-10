{ inputs, pkgs, ... }:
{
  imports = [
    ./home.nix
    ./theme
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
