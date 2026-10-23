final: prev: {
  alacritty = final.callPackage ./alacritty.nix { };
  hyprland = prev.hyprland.overrideAttrs (
    {
      env,
      ...
    }:
    {
      env = env // {
        NIX_CFLAGS_COMPILE = (env.NIX_CFLAGS_COMPILE or "") + " -Os";
      };
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
  # mako = prev.mako.override {
  #   withFishCompletions = false;
  #   withZshCompletions = false;
  # };
  # systemd = prev.systemd.override { withBootloader = false; };
  ly = prev.ly.override {
    x11Support = false;
  };
}
