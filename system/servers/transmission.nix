{ userName, config, ... }:
{
  services.transmission.settings = {
    download-dir = "/media/transmission";
    proxy_url = "socks5h://localhost:9050";
    watch-dir-enabled = true;
  };
  users.users.${userName}.extraGroups = [
    "transmission"
  ];
}
