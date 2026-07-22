{ pkgs, ... }:
{
  bell = "visual";
  git.enable = true;
  options.autoindent = true;
  globals.mapLeader = " ";
  syntaxHighlighting = true;
  lsp = {
    enable = true;
    formatOnSave = true;
    null-ls.enable = true;
  };
  binds.whichKey.enable = true;
  visuals = {
    highlight-undo.enable = true;
    indent-blankline.enable = true;
  };
  autocomplete.nvim-cmp.enable = true;
  telescope = {
    enable = true;
    extensions = [
      {
        name = "fzf";
        packages = [ pkgs.vimPlugins.telescope-fzf-native-nvim ];
        setup.fzf.fuzzy = true;
      }
    ];
  };
  options.wrap = false;
  utility.sleuth.enable = true;
  languages = {
    enableFormat = true;
    enableTreesitter = true;
    markdown.enable = true;
    bash.enable = true;
    tex.enable = true;
    python = {
      enable = true;
      lsp.servers = [ "ruff" ];
    };
    clang = {
      enable = true;
      cHeader = true;
    };
    nix = {
      enable = true;
      format.type = [ "nixfmt" ];
      lsp.servers = [ "nixd" ];
    };
  };
}
