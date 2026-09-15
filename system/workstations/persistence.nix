{ userName, ... }:
{
  environment.persistence."/persistent".users.${userName}.directories = [
    ".config/vesktop"
    ".config/kicad"
    ".local/share/qutebrowser/webengine"
    ".config/BraveSoftware/Brave-Browser"
    ".local/share/PrismLauncher"
    ".config/Bitwarden CLI"
    ".wine"
  ];
}
