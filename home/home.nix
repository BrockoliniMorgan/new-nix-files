{ pkgs, ... }:
{
  programs.alacritty.settings.terminal.osc52 = "CopyPaste";
  programs.bash.initExtra = ''
    eval "$(devenv hook bash)"
  '';
  programs.btop.settings = {
    disable_mouse = true;
    proc_aggregate = true;
    proc_gradient = false;
    proc_per_core = true;
    proc_tree = true;
    swap_disk = false;
    update_ms = 100;
    vim_keys = true;
  };
  # Fix "unsupported browser" google login issues
  programs.qutebrowser.perDomainSettings."https://accounts.google.com/*".content.headers.user_agent =
    "Mozilla/5.0 ({os_info}; rv:135.0) Gecko/20100101 Firefox/135";
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
      hmsf = "${pkgs.home-manager}/bin/home-manager switch --flake ~/new-nix-files -b bkp";
      ngc = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
    };
    username = "brock";
    homeDirectory = "/home/brock";
    stateVersion = "26.05";
  };
}
