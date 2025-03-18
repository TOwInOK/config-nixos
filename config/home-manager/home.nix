# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ outputs, ... }: {
  imports = with outputs.homeManagerModules; [ default ];
  home = {
    username = "towinok";
    homeDirectory = "/home/towinok";
    stateVersion =
      "24.05"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  };

  # Включаем Hyprland
  config.hyprland.enable = true;
  config.waylandPkgs.enable = true;
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
