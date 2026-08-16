{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./home.nix
    ./packages.nix
    ./theme
    ./wayland
    inputs.nvf.homeManagerModules.nvf
  ];
  programs.nvf = {
    defaultEditor = true;
    settings.vim = import ./neovim { inherit pkgs; };
  };
}
