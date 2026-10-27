{ pkgs, userName, ... }:
{
  programs.btop.settings = {
    color_theme = "onedark";
    disable_mouse = true;
    proc_aggregate = true;
    proc_gradient = false;
    proc_per_core = true;
    proc_tree = true;
    swap_disk = false;
    update_ms = 100;
    vim_keys = true;
  };
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

  home = {
    shell.enableShellIntegration = true;
    shellAliases = {
      nrsf = "sudo nixos-rebuild switch --flake ~/new-nix-files";
      ngc = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
    };
    username = userName;
    homeDirectory = "/home/${userName}";
    stateVersion = "26.05";
  };
}
