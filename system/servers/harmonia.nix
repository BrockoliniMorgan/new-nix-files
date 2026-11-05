{
  config,
  pkgs,
  lib,
  ...
}:
{
  sops.secrets.binary-cache-private = { };
  sops.secrets.cloudflared-key = { };
  services.harmonia.cache.signKeyPaths = [ config.sops.secrets.binary-cache-private.path ];
  systemd.services.cloudflared-tunnel = {
    after = [
      "network.target"
      "network-online.target"
    ];
    wants = [
      "network.target"
      "network-online.target"
    ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      RuntimeDirectory = "cloudflared-tunnel";
      RuntimeDirectoryMode = "0400";

      EnvironmentFile = config.sops.secrets.cloudflared-key.path;
      ExecStart = "${lib.getExe pkgs.cloudflared} tunnel --no-autoupdate run --token $CLOUDFLARED_KEY";
      Restart = "on-failure";
      DynamicUser = true;
    };

  };
}
