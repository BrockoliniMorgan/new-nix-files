{ lib, ... }:
{
  boot.initrd.systemd.services.impermanence-btrfs = lib.mkForce { };
}
