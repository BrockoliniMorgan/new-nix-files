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
  tree = prev.pkgsStatic.tree.overrideAttrs (
    {
      makeFlags ? [ ],
      env ? { },
      ...
    }:
    {
      makeFlags = makeFlags ++ [ "CFLAGS=-Os" ];

      # Important for static pkgs - reduced binary size from 95K with
      # dynamic linking or 165K with static linking to 81K
      env.NIX_CFLAGS_COMPILE = (env.NIX_CFLAGS_COMPILE or "") + " -flto";
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
    systemdMinimal = final.systemdLibs;
  };
  # systemd = prev.systemd.override { withBootloader = false; };
  ly = prev.ly.override {
    x11Support = false;
  };
  # pipewire = prev.pipewire.override { x11Support = false; };
  xdg-desktop-portal-gtk = prev.xdg-desktop-portal-gtk.overrideAttrs (
    {
      mesonFlags ? [ ],
      buildInputs ? [ ],
      ...
    }:
    {
      mesonFlags = mesonFlags ++ [
        (lib.mesonEnable "wallpaper" false)
        (lib.mesonEnable "settings" false)
      ];
      buildInputs = lib.remove "gsettings-desktop-schemas" (lib.remove "gnome-desktop" buildInputs);
    }
  );
}
