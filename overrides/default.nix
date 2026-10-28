final: prev:
let
  inherit (prev) lib;
in
{
  alacritty = final.callPackage ./alacritty.nix { };
  hyprland = (prev.hyprland.override { withUWSM = false; }).overrideAttrs (
    {
      env ? { },
      cmakeFlags ? [ ],
      ...
    }:
    {
      env = env // {
        NIX_CFLAGS_COMPILE = (env.NIX_CFLAGS_COMPILE or "") + " -Os";
      };
      cmakeFlags = cmakeFlags ++ [ (lib.cmakeBool "NO_HYPRPM" true) ];
    }
  );
  rofi-unwrapped = prev.rofi-unwrapped.override { x11Support = false; };
  tree = prev.tree.overrideAttrs (
    {
      makeFlags ? [ ],
      ...
    }:
    {
      makeFlags = makeFlags ++ [ "CFLAGS=-Os" ];
    }
  );
  waybar = prev.waybar.override {
    niriSupport = false;
    cavaSupport = false;
    jackSupport = false;
    pulseSupport = false;
    pipewireSupport = false;
    sndioSupport = false;
    mpdSupport = false;
  };
  mako = prev.mako.override {
    withFishCompletions = false;
    withZshCompletions = false;
  };
  # systemd = prev.systemd.override { withBootloader = false; };
  ly = prev.ly.override {
    x11Support = false;
  };
}
