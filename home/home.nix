{ lib, pkgs, ...}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = let 
      lua = lib.generators.mkLuaInline;
    in {
      mod = {
        _var = "SUPER";
      };
      monitor = {
        output = "";
        mode = "preferred";
        position = "auto";
        scale = "1";
      };
      config = {
        input = {
          repeat_rate = 40;
          repeat_delay = 300;
        };
        ecosystem.no_update_news = true;
        general = {
          gaps_in = 2;
          gaps_out = 4;
          border_size = 0;
        };
        decoration = {
          rounding = 4;
        };
        animations.enabled = false;
        input.touchpad.natural_scroll = true;
      };
      bind = [{
        _args = [
          (lua "mod .. \" + Q\"")
          (lua "hl.dsp.window.close()")
        ];
      } {
        _args = [
          (lua "mod .. \" + RETURN\"")
          (lua "hl.dsp.exec_cmd(\"${lib.getExe pkgs.alacritty}\")")
        ];
      } {
        _args = [
          (lua "mod .. \" + S\"")
          (lua "hl.dsp.exec_cmd(\"${lib.getExe pkgs.palemoon-bin}\")")
        ];
      }];
      on = {
        _args = [
          "hyprland.start"
          (lua ''
           function()
            hl.exec_cmd("waybar")
           end
          '')
        ];
      };
    };
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
  programs.waybar = {
    enable = true;
    settings = {
      bar = {
        layer = "top";
        position = "top";
        modules-left = [ "hyprland/workspaces" ];
        modules-right = [ "network" "cpu" "memory" "temperature" "battery" "tray" ];
        modules-center = [ "clock" ];
        memory.format = "MEM: {}%";
        cpu.format = "CPU: {usage}%";
        battery.format = "BAT: {}%";
      };
    };
  };
  programs.btop.enable = true;
  programs.alacritty.enable = true;
  programs.alacritty.settings.terminal.osc52 = "CopyPaste";
  programs.bash.enable = true;
  programs.home-manager.enable = true;
  programs.rofi.enable = true;
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {
        name = "BrockoliniMorgan";
        email = "brockjamesmorgan@gmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  home = {
    shell.enableShellIntegration = true;
    shellAliases = {
      nrsf = "sudo nixos-rebuild switch --flake ~/new-nix-files";
      hmsf = "${pkgs.home-manager}/bin/home-manager switch --flake ~/new-nix-files";
      ngc = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
    };
    username = "brock";
    homeDirectory = "/home/brock";
    stateVersion = "26.05";
  };
}
