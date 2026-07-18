{
  # Ok this is a problem if anyone else tries to use
  # my machines/config, but I don't use these modules
  # and they're just taking up RAM and CPU
  # The functionalities they cover are listed next to the module
  boot.blacklistedKernelModules = [
    "btusb" # Bluetooth USB devices
    "mousedev" # Older programs that require PS/2 connections instead of USB mice and keyboards
    "atkbd" # AT and PS/2 keyboard driver
  ];
}
