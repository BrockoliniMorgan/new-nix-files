{ pkgs, ... }:
{
  wayland.windowManager.hyprland.enable = true;
  programs.waybar.enable = true;
  programs.alacritty.enable = true;
  programs.bash.enable = true;
  programs.btop.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.home-manager.enable = true;
  programs.qutebrowser.enable = true;
  programs.rofi.enable = true;
  programs.git.enable = true;
  programs.git.lfs.enable = true;
  home.packages = with pkgs; [
    devenv
    vesktop
  ];
}
