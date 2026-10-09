{ userName, ... }:
{
  environment.persistence."/persistent".users.${userName}.directories = [
    "/var/lib/transmission/watchdir"
    "/var/lib/transmission/.incomplete"
  ];
}
