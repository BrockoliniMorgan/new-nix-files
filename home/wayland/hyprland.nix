{ lib, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    settings =
      let
        lua = lib.generators.mkLuaInline;
      in
      {
        mod._var = "SUPER";
        monitor = [
          {
            output = "";
            mode = "highres";
            position = "auto";
            scale = "1";
          }
          {
            output = "desc:Acer Technologies KA222Q THYSA0018535 (HDMI-A-1)";
            mode = "highres";
            position = "auto";
            scale = "1";
            transform = 1;
          }
        ];
        config = {
          input = {
            repeat_rate = 40;
            repeat_delay = 250;
          };
          ecosystem.no_update_news = true;
          general = {
            gaps_in = 0;
            gaps_out = 0;
            border_size = 0;
          };
          decoration.rounding = 4;
          animations.enabled = false;
          input.touchpad.natural_scroll = true;
        };
        bind = [
          {
            _args = [
              (lua "mod .. \" + Q\"")
              (lua "hl.dsp.window.close()")
            ];
          }
          {
            _args = [
              (lua "mod .. \" + D\"")
              (lua "hl.dsp.exec_cmd(\"${lib.getExe pkgs.rofi} -show drun\")")
            ];
          }
          {
            _args = [
              (lua "mod .. \" + RETURN\"")
              (lua "hl.dsp.exec_cmd(\"${lib.getExe pkgs.alacritty}\")")
            ];
          }
          {
            _args = [
              (lua "mod .. \" + S\"")
              (lua "hl.dsp.exec_cmd(\"${lib.getExe pkgs.qutebrowser}\")")
            ];
          }
        ];
        on._args = [
          "hyprland.start"
          (lua ''
            function()
             hl.exec_cmd("waybar")
            end
          '')
        ];
      };
    # Just using this for functions - can do it in nix, but
    # it's cleaner when looking at the actual lua config file
    extraConfig = ''
      for i = 1, 12 do
        local key = i + 9
        hl.bind(mod .. " + code:" .. key, hl.dsp.focus({workspace = i}))
        hl.bind(mod .. " + SHIFT + code:" .. key, hl.dsp.window.move({workspace = i}))
      end
      local directions = {
        "left",
        "right",
        "up",
        "down",
      };
      local vi_directions = {
        "H",
        "L",
        "K",
        "J",
      };
      for i = 1, 4 do
        local vi_dir = vi_directions[i]
        local dir = directions[i]
        hl.bind(mod .. " + " .. dir, hl.dsp.focus({direction = dir}))
        hl.bind(mod .. " + " .. vi_dir, hl.dsp.focus({direction = dir}))
        hl.bind(mod .. " + SHIFT + " .. vi_dir, hl.dsp.window.move({direction = dir}))
        hl.bind(mod .. " + SHIFT + " .. dir, hl.dsp.window.move({direction = dir}))
      end
    '';
  };
}
