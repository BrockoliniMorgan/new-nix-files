{ pkgs, ... }:
{
  programs.alacritty.enable = true;
  programs.prismlauncher.enable = true;
  programs.rofi.enable = true;
  programs.waybar.enable = true;
  services.mako.enable = true;
  wayland.windowManager.hyprland.enable = true;

  home.packages = with pkgs; [
    libreoffice
    wineWow64Packages.stableFull
    bitwarden-cli
    kicad
    vesktop
  ];
}
