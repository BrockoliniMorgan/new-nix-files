{ pkgs, ... }:
{
  programs.bash.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.home-manager.enable = true;
  programs.nvf.enable = true;
  programs.btop.enable = true;
  programs.tmux.enable = true;

  home.packages = with pkgs; [ devenv ];
}
