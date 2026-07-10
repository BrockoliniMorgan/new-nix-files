{
  disko.devices.disk.main.content.partitions = {
    luks.size = "500G";
    arch-boot = {
      name = "ARCHBOOT";
      size = "1G";
      type = "EF00";
      priority = 3;
      content = {
        type = "filesystem";
        format = "vfat";
      };
    };
    arch = {
      name = "arch";
      size = "200G";
      priority = 4;
      content = {
        type = "filesystem";
        format = "ext4";
      };
    };
    extra-boot = {
      name = "EXTRABOOT";
      size = "1G";
      type = "EF00";
      priority = 5;
      content = {
        type = "filesystem";
        format = "vfat";
      };
    };
    extra = {
      name = "extra";
      size = "200G";
      priority = 6;
      content = {
        type = "filesystem";
        format = "ext4";
      };
    };
  };
}
