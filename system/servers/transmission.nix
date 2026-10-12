{ userName, config, ... }:
{
  services.transmission.settings = {
    download-dir = "/media/transmission";
    proxy_url = config.networking.proxy.default;
    watch-dir-enabled = true;
  };
  users.users.${userName}.extraGroups = [
    "transmission"
  ];
}
