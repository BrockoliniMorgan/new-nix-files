{ userName, ... }:
{
  environment.persistence."/persistent".users.${userName}.directories = [
    ".config/vesktop"
    ".config/kicad"
    ".local/share/qutebrowser/webengine"
    ".config/BraveSoftware"
    ".local/share/PrismLauncher"
    ".local/share/Steam"
    ".wine"
  ];
}
