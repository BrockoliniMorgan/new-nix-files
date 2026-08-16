{ pkgs, ... }:
{
  programs.alacritty.enable = true;
  programs.bash.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.home-manager.enable = true;
  programs.nvf.enable = true;
  programs.prismlauncher.enable = true;
  programs.qutebrowser.enable = true;
  programs.rofi.enable = true;
  programs.waybar.enable = true;
  services.mako.enable = true;
  wayland.windowManager.hyprland.enable = true;
  home.packages = with pkgs; [
    bitwarden-cli
    devenv
    kicad
    vesktop
  ];
}
