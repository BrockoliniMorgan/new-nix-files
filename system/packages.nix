{ pkgs, ... }:
{
  programs.hyprland.enable = true;
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    bluez
    btop
    dnsmasq
    file
    nftables
    tree
    vim
    wget
    wl-clipboard
  ];
}
