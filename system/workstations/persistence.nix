{ userName, ... }:
{
  environment.persistence."/persistent".users.${userName}.directories = [
    ".config/vesktop"
    ".config/kicad"
    ".local/share/qutebrowser/webengine"
    ".local/share/PrismLauncher"
    ".config/Bitwarden CLI"
    ".wine"
  ];
}
