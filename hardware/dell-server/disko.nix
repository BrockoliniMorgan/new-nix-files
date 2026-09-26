{ lib, ... }:
{
  disko.devices = {
    disk.boot = {
      type = "disk";
      device = "/dev/disk/by-id/usb-Generic_Flash_Disk_DE2D52CC-0:0";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "100%";
            type = "EF00";
            priority = 1;
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
        };
      };
    };
    disk.media = {
      type = "disk";
      device = "/dev/disk/by-id/wwn-0x6782bcb066ea22002b73317509810e85";
      content = {
        type = "gpt";
        partitions = {
          luks = {
            size = "100%";
            priority = 3;
            content = {
              type = "luks";
              name = "cryptmedia";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/media";
              };
            };
          };
        };
      };
    };
    disk.main = lib.mkForce {
      type = "disk";
      device = "/dev/disk/by-id/wwn-0x6782bcb066ea22002b73321212d7c64c";
      content = {
        type = "gpt";
        partitions = {
          luks = {
            size = "100%";
            priority = 2;
            content = {
              type = "luks";
              name = "cryptroot";
              content = {
                type = "lvm_pv";
                vg = "root";
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      root = {
        type = "lvm_vg";
        lvs = {
          nix = {
            size = "200G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/nix";
              mountOptions = [
                "defaults"
              ];
            };
          };
          persistent = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/persistent";
            };
          };
        };
      };
    };
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [ "size=10G" "mode=755" ];
    };
  };
}
