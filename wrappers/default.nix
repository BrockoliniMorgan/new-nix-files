inputs: prev: final: {
  btop = inputs.nix-wrapper-modules.wrappers.btop.wrap (import ./btop.nix { pkgs = final; });
  alacritty = inputs.nix-wrapper-modules.wrappers.alacritty.wrap (
    import ./alacritty.nix { pkgs = final; }
  );
}
