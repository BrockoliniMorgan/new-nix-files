{ lib, ... }:
{
  fileSystems."/persistent".neededForBoot = true;
  fileSystems."/nix".neededForBoot = true;
  disko.devices.disk.main = {
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        esp = {
          name = "ESP";
          size = "2G";
          type = "EF00";
          priority = 1;
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        };
        luks = {
          name = "luks";
          size = lib.mkDefault "100%";
          priority = 2;
          content = {
            type = "luks";
            name = "cryptroot";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/root" = {
                  mountOptions = [
                    "subvol=root"
                    "noatime"
                  ];
                  mountpoint = "/";
                };
                "/persistent" = {
                  mountOptions = [
                    "subvol=persist"
                    "noatime"
                  ];
                  mountpoint = "/persistent";
                };
                "/nix" = {
                  mountOptions = [
                    "subvol=nix"
                    "noatime"
                  ];
                  mountpoint = "/nix";
                };
              };
            };
          };
        };
      };
    };
  };
}
