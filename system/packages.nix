{ pkgs, ... }:
{
  networking.networkmanager.enable = true;
  programs.arp-scan.enable = true;
  programs.vim.enable = true;
  services.fwupd.enable = true;
  services.openssh.enable = true;
  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
    btop
    file
    iw
    nettools
    sops
    tree
    usbutils
    wget
  ];
}
