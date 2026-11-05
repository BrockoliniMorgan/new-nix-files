{ lib, config, ... }:
let
  cfg = config.server;
in
{
  options = {
    server = {
      enable = lib.mkEnableOption "Enable server";
      type = lib.mkOption {
        default = [ ];
        type = lib.types.listOf (
          lib.types.enum [
            "media"
            "dns"
            "nix-cache"
          ]
        );
      };
    };
  };
  config = lib.mkIf cfg.enable {
    services.tor.enable = builtins.elem "media" cfg.type;
    services.transmission.enable = builtins.elem "media" cfg.type;
    services.pihole-ftl.enable = builtins.elem "dns" cfg.type;
    services.pihole-web.enable = builtins.elem "dns" cfg.type;
    services.harmonia.cache.enable = builtins.elem "nix-cache" cfg.type;
    systemd.services.cloudflared-tunnel.enable = builtins.elem "nix-cache" cfg.type;
  };
}
