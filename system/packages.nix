{ pkgs, ... }:
{
  programs.hyprland.enable = true;
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    mako
    tree
    vim
    wget
    wl-clipboard
    nftables
    dnsmasq
  ];
}
