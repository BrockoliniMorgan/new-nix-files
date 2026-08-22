{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./home.nix
    ./packages.nix
    inputs.nvf.homeManagerModules.nvf
  ];
  programs.nvf = {
    defaultEditor = true;
    settings.vim = import ./neovim { inherit pkgs; };
  };
}
