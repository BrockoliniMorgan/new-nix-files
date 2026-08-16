{ pkgs, ... }:
{
  networking.networkmanager.enable = true;
  programs.arp-scan.enable = true;
  programs.evince.enable = true;
  programs.hyprland.enable = true;
  programs.steam.enable = true;
  programs.vim.enable = true;
  services.displayManager.ly.enable = true;
  services.fwupd.enable = true;
  services.libinput.enable = true;
  services.openssh.enable = true;
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    bluez
    btop
    file
    iw
    nettools
    tree
    usbutils
    wget
    wl-clipboard
  ];
}
