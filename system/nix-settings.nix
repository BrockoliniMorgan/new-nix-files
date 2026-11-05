{
  nix.settings = {
    auto-optimise-store = true;
    extra-platforms = [
      "aarch64-linux"
      "arm-linux"
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://nix-community.cachix.org"
    ];
    trusted-substituters = [
      "https://cache.brockjmorgan.dev"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.brockjmorgan.dev-1:QMXekPjjwVykyLq0S9E60Tw/bvtoFuuh1AlESybamP0="
    ];
    flake-registry = "";
    warn-dirty = false;
  };
  nix.optimise = {
    automatic = true;
    dates = "daily";
  };

}
