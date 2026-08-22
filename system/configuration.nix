{
  lib,
  pkgs,
  hostName,
  ...
}:
{
  networking.hostName = hostName;
  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_AU.UTF-8";

  programs.ssh.startAgent = true;
  virtualisation.docker.enable = true;

  documentation.nixos.enable = false;

  # Enable CUPS to print documents.
  services.printing.drivers = with pkgs; [
    brlaser
  ];

  services.speechd.enable = lib.mkForce false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
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

  security.wrappers.btop = {
    source = "${lib.getExe pkgs.btop}";
    capabilities = "cap_perfmon=+ep cap_dac_read_search=+ep";
    owner = "root";
    group = "root";
  };

  nix.settings = {
    auto-optimise-store = true;
    extra-platforms = [
      "aarch64-linux"
      "arm-linux"
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    flake-registry = "";
    warn-dirty = false;
  };

  # Allow for wifi forwarding to ethernet
  networking.firewall.allowedTCPPorts = [ 53 ];
  networking.firewall.allowedUDPPorts = [ 53 ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}
