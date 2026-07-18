{ pkgs, ... }:
{
  programs.hyprland.enable = true;
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    bluez
    mako
    tree
    vim
    wget
    wl-clipboard
    nftables
    dnsmasq
  ];
}
