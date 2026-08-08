# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  lib,
  pkgs,
  hostName,
  ...
}:

{
  networking.hostName = hostName;
  networking.networkmanager.enable = true;

  # Allow for wifi forwarding to ethernet
  networking.firewall.allowedTCPPorts = [ 53 ];
  networking.firewall.allowedUDPPorts = [ 53 ];

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Australia/Brisbane";

  services.displayManager.ly.enable = true;
  programs.ssh.startAgent = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.speechd.enable = lib.mkForce false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.fwupd.enable = true;

  users.users.brock = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "dialout"
      "networkmanager"
    ];
    hashedPasswordFile = "/persistent/passwords/brock";
  };

  fonts.packages = [ pkgs.nerd-fonts.martian-mono ];

  hardware = {
    enableRedistributableFirmware = true;
    bluetooth.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  # Graphics card access in btop
  security.wrappers.btop = {
    source = "${lib.getExe pkgs.btop}";
    capabilities = "cap_perfmon=+ep cap_dac_read_search=+ep";
    owner = "root";
    group = "root";
  };

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-substituters = [
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
    flake-registry = "";
    warn-dirty = false;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
