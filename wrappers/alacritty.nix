{ pkgs }:
{
  inherit pkgs;
  settings = {
    terminal.osc52 = "CopyPaste";
    font = {
      normal = {
        family = "MartianMono Nerd Font";
        style = "Mono";
      };
      size = 11;
    };
  };
}
