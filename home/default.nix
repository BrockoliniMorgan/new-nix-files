{ inputs, pkgs, ... }:
{
  imports = [
    ./home.nix
    ./packages.nix
    ./theme
    ./wayland
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
