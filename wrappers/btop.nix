{ pkgs, ... }:
{
  inherit pkgs;
  settings = {
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
}
