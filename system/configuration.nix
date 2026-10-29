{
  lib,
  pkgs,
  hostName,
  userName,
  ...
}:
{
  networking.hostName = hostName;
  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_AU.UTF-8";

  programs.ssh.startAgent = true;
  virtualisation.docker.enable = true;

  # Enable CUPS to print documents.
  services.printing.drivers = with pkgs; [
    brlaser
  ];

  services.speechd.enable = lib.mkForce false;

  users = {
    mutableUsers = false;
    users.${userName} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "dialout"
        "networkmanager"
      ];
      hashedPasswordFile = "/persistent/passwords/${userName}";
    };
  };

  hardware.enableRedistributableFirmware = true;

  security.wrappers.btop = {
    source = "${lib.getExe pkgs.btop}";
    capabilities = "cap_perfmon=+ep cap_dac_read_search=+ep";
    owner = "root";
    group = "root";
  };

  zramSwap.enable = true;

  # Allow for wifi forwarding to ethernet
  # networking.firewall.allowedTCPPorts = [ 53 ];
  # networking.firewall.allowedUDPPorts = [ 53 ];

  system.stateVersion = "26.05"; # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
}
