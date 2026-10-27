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
          ]
        );
      };
    };
  };
  config = lib.mkIf cfg.enable {
    services.tor.enable = lib.mkIf (builtins.elem "media" cfg.type);
    services.transmission.enable = lib.mkIf (builtins.elem "media" cfg.type);
    services.pihole-ftl.enable = lib.mkIf (builtins.elem "dns" cfg.type);
    services.pihole-web.enable = lib.mkIf (builtins.elem "dns" cfg.type);
  };
}
