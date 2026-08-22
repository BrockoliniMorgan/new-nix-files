{
  programs.waybar = {
    settings = {
      bar = {
        layer = "top";
        position = "top";
        modules-left = [ "hyprland/workspaces" ];
        modules-right = [
          "network"
          "cpu"
          "memory"
          "temperature"
          "battery"
          "tray"
        ];
        modules-center = [ "clock" ];
        memory.format = "MEM: {}%";
        cpu.format = "CPU: {usage}%";
        battery.format = "BAT: {}%";
      };
    };
  };
}
