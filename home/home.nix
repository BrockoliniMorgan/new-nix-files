{ pkgs, ... }:
{
  programs.bash.initExtra = ''
    eval "$(devenv hook bash)"
  '';
  # Fix "unsupported browser" google login issues
  # :set -u https://accounts.google.com/* content.headers.user_agent "Mozilla/5.0 ({os_info}; rv:135.0) Gecko/20100101 Firefox/135"
  programs.qutebrowser.perDomainSettings."https://accounts.google.com/*".content.headers.user_agent =
    "Mozilla/5.0 ({os_info}; rv:135.0) Gecko/20100101 Firefox/135";
  programs.qutebrowser.settings.content.blocking.method = "adblock";
  programs.git.settings = {
    user = {
      name = "BrockoliniMorgan";
      email = "brockjamesmorgan@gmail.com";
    };
    init.defaultBranch = "main";
    pull.rebase = true;
  };
  programs.direnv.config.global.hide_env_diff = true;

  services.mako.settings = {
    default-timeout = 8000;
    max-visible = 5;
  };

  home = {
    shell.enableShellIntegration = true;
    shellAliases = {
      nrsf = "sudo nixos-rebuild switch --flake ~/new-nix-files";
      hmsf = "${pkgs.home-manager}/bin/home-manager switch --flake ~/new-nix-files -b bkp";
      ngc = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
    };
    username = "brock";
    homeDirectory = "/home/brock";
    stateVersion = "26.05";
  };
}
