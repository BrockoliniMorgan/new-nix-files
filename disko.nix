{ ... }:
{
  fileSystems."/persistent".neededForBoot = true;
  fileSystems."/nix".neededForBoot = true;
  disko.devices.disk.main = {
    device = "/dev/disk/by-id/nvme-INTEL_SSDPEKNU512GZ_BTKA10910LW0512A";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        esp = {
          name = "ESP";
          size = "2G";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        };
        luks = {
          name = "luks";
          size = "100%";
          content = {
            type = "luks";
            name = "cryptroot";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/root" = {
                  mountOptions = [ "subvol=root" "noatime" ];
                  mountpoint = "/";
                };
                "/persistent" = {
                  mountOptions = [ "subvol=persist" "noatime" ];
                  mountpoint = "/persistent";
                };
                "/nix" = {
                  mountOptions = [ "subvol=nix" "noatime" ];
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
