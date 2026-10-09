{
  disko.devices.disk.main.device = "/dev/disk/by-id/nvme-WDC_PC_SN530_SDBPNPZ-512G-1032_212337801768";
  disko.devices.disk.media = {
    type = "disk";
    device = "/dev/disk/by-id/ata-ST1000DM010-2EP102_ZN1RR2CK";
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
}
