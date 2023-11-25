{ config, inputs, pkgs, ... }: {
	xsession.windowManager.i3 = {
		enable = true;
		config = {
			assigns = {
				"4" = [{ class = "^discord"; }];
			};
			modifier = "Mod4";
			terminal = "wezterm";
			startup = [
				{ command = "discord"; }
			];
			workspaceAutoBackAndForth = true;
		};
	};
	xsession.windowManager.awesome = {
		enable = false;
		luaModules = with pkgs.luaPackages; [
			luarocks
			luadbi-mysql
			lgi
		];
	};

	wayland.windowManager.sway = {
		enable = true;
		config = {
			menu = "rofi -show drun";
			terminal = "wezterm";
			assigns = {
				"2" = [{ app_id = "^firefox$"; }];
				"4" = [{ app_id = "^discord$"; }];
			};
			keybindings = let
				cfg = config.wayland.windowManager.sway.config;
			in {
				"${cfg.modifier}+Return" = "exec ${cfg.terminal}";
				# "${cfg.modifier}+Shift+q" = "quit";
				"${cfg.modifier}+Shift+q" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
				"${cfg.modifier}+Shift+c" = "kill";
				"${cfg.modifier}+d" = "exec ${cfg.menu}";

				"${cfg.modifier}+${cfg.left}" = "focus left";
				"${cfg.modifier}+${cfg.down}" = "focus down";
				"${cfg.modifier}+${cfg.up}" = "focus up";
				"${cfg.modifier}+${cfg.right}" = "focus right";

				"${cfg.modifier}+Left" = "focus left";
				"${cfg.modifier}+Down" = "focus down";
				"${cfg.modifier}+Up" = "focus up";
				"${cfg.modifier}+Right" = "focus right";

				"${cfg.modifier}+Shift+${cfg.left}" = "move left";
				"${cfg.modifier}+Shift+${cfg.down}" = "move down";
				"${cfg.modifier}+Shift+${cfg.up}" = "move up";
				"${cfg.modifier}+Shift+${cfg.right}" = "move right";

				"${cfg.modifier}+Shift+Left" = "move left";
				"${cfg.modifier}+Shift+Down" = "move down";
				"${cfg.modifier}+Shift+Up" = "move up";
				"${cfg.modifier}+Shift+Right" = "move right";

				"${cfg.modifier}+b" = "splith";
				"${cfg.modifier}+v" = "splitv";
				"${cfg.modifier}+f" = "fullscreen toggle";
				"${cfg.modifier}+a" = "focus parent";

				"${cfg.modifier}+s" = "layout stacking";
				"${cfg.modifier}+w" = "layout tabbed";
				"${cfg.modifier}+e" = "layout toggle split";

				"${cfg.modifier}+Shift+space" = "floating toggle";
				"${cfg.modifier}+space" = "focus mode_toggle";

				"${cfg.modifier}+1" = "workspace number 1";
				"${cfg.modifier}+2" = "workspace number 2";
				"${cfg.modifier}+3" = "workspace number 3";
				"${cfg.modifier}+4" = "workspace number 4";
				"${cfg.modifier}+5" = "workspace number 5";
				"${cfg.modifier}+6" = "workspace number 6";
				"${cfg.modifier}+7" = "workspace number 7";
				"${cfg.modifier}+8" = "workspace number 8";
				"${cfg.modifier}+9" = "workspace number 9";

				"${cfg.modifier}+Shift+1" = "move container to workspace number 1";
				"${cfg.modifier}+Shift+2" = "move container to workspace number 2";
				"${cfg.modifier}+Shift+3" = "move container to workspace number 3";
				"${cfg.modifier}+Shift+4" = "move container to workspace number 4";
				"${cfg.modifier}+Shift+5" = "move container to workspace number 5";
				"${cfg.modifier}+Shift+6" = "move container to workspace number 6";
				"${cfg.modifier}+Shift+7" = "move container to workspace number 7";
				"${cfg.modifier}+Shift+8" = "move container to workspace number 8";
				"${cfg.modifier}+Shift+9" = "move container to workspace number 9";

				"${cfg.modifier}+Shift+minus" = "move scratchpad";
				"${cfg.modifier}+minus" = "scratchpad show";


				"${cfg.modifier}+r" = "mode resize";

				"Print" = "exec ${pkgs.grim}/bin/grim";

				"XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 1%+";
				"XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 1%-";

				"Shift+XF86AudioMute" = "exec pamixer --default-source --toggle-mute";
				"XF86AudioMute" = "exec pamixer --toggle-mute";
				"Shift+XF86AudioRaiseVolume" = "exec pamixer --default-source --increase 1 --allow-boost";
				"XF86AudioRaiseVolume" = "exec pamixer --increase 1 --allow-boost";
				"Shift+XF86AudioLowerVolume" = "exec pamixer --default-source --decrease 1 --allow-boost";
				"XF86AudioLowerVolume" = "exec pamixer --decrease 1 --allow-boost";
			};
			floating.criteria = [
				{
					title = "^Picture-in-Picture$";
					app_id = "^firefox$";
				}
				{
					title = "[Ee]xtension.*[Tt]ree\\s[Ss]tyle\\s[Tt]ab.*[Cc]lose\\s[Tt]abs";
					app_id = "^firefox$";
				}
			];
			window.commands = [
				{
					criteria = {
						app_id = "^pavucontrol$";
					};
					command = "move window to scratchpad";
				}
				{
					criteria = {
						title = "^Picture-in-Picture$";
						app_id = "^firefox$";
					};
					command = "sticky enable";
				}
			];
			modifier = "Mod4";
			input = {
				"type:touchpad" = {
					tap = "enabled";
					drag = "enabled";
					drag_lock = "enabled";
					middle_emulation = "enabled";
				};
			};
			startup = [
				{ command = "discord"; }
				{ command = "pavucontrol"; }
				# { command = ""; }
				{ command = "$(home-manager generations | head -1 | awk '{print $7 \"/specialisation/wayland\"}')"; }
			];
			output = {
				eDP-1 = {
					bg = "~/repo/wallpapers/1682160.jpg fill";
				};
			};
		};
	};
	wayland.windowManager.hyprland = {
		enable = true;
		# extraConfig = config.hyprland.config.file;
		extraConfig = (builtins.readFile ../hamburgir.d/hypr/hyprland.conf);
		plugins = [
			# inputs.hy3.packages.x86_64-linux.hy3
		];
	};
}
