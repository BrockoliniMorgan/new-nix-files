{ pkgs, ... }:
{
  programs.hyprland.enable = true;
  programs.steam.enable = true;
  programs.evince.enable = true;
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  services.displayManager.ly.enable = true;
  services.libinput.enable = true;

  documentation.nixos.enable = false;

  fonts.packages = [ pkgs.nerd-fonts.martian-mono ];

  environment.systemPackages = with pkgs; [ wl-clipboard ];
}
