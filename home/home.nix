{ pkgs, userName, ... }:
{
  programs.bash.initExtra = ''
    eval "$(devenv hook bash)"
  '';
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
    username = userName;
    homeDirectory = "/home/${userName}";
    stateVersion = "26.05";
  };
}
