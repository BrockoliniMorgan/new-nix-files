{ userName, ... }:
{
  services.transmission.settings.download-dir = "/media/transmission";
  users.users.${userName}.extraGroups = [
    "transmission"
  ];
}
