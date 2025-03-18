# https://nixos.wiki/wiki/Fonts

{ pkgs, ... }: {
  font = {
    enableDefaultPackages = true;
    packages = with pkgs; [ nerdfonts ];
    fontconfig = {
      defaultFonts = {
        serif = [ "PT Mono" ];
        sansSerif = [ "PT Mono" ];
        monospace = [ "PT Mono" ];
      };
    };
  };
}
