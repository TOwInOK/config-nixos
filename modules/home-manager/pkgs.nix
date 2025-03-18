{ config, pkgs, lib, ... }:

let
  waylandPackages = with pkgs; [
    wofi
    waybar
    hyprpicker
    cliphist
    satty
    swww
    swaynotificationcenter
  ];
in {
  home.packages = with pkgs;
    [
      gparted
      firefox
      thunderbird
      wineWowPackages.stable
      winetricks
      wineWowPackages.waylandFull
      discord
      telegram-desktop
      obs-studio
      ghostty
      vlc
      spotify
      postman
      pamixer
      pavucontrol
      mangohud
      heroic
      lutris
      gamemode
      brightnessctl
    ] ++ lib.optionals config.waylandPkgs.enable waylandPackages;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = false;
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
    ];

  options = {
    waylandPkgs.enable = lib.mkEnableOption "Enable packages for Wayland";
  };
}
