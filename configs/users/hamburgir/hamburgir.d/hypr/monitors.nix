{ config, ... }: {
    wayland.windowManager.hyprland.extraConfig = ''
        monitor=,preferred,auto,1
        monitor=eDP-1,preferred,auto,1.20
    '';
}
