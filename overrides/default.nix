final: prev: {
  alacritty = prev.alacritty.overrideAttrs (
    {
      buildFeatures ? [ ],
      ...
    }:
    {
      buildFeatures = buildFeatures ++ [
        "--features=wayland"
      ];
    }
  );
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
  # systemd = prev.systemd.override { withBootloader = false; };
}
