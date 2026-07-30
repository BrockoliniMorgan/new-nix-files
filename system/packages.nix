{ pkgs, ... }:
{
  programs.hyprland.enable = true;
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    bluez
    tree
    vim
    file
    wget
    wl-clipboard
    nftables
    dnsmasq
  ];
}
