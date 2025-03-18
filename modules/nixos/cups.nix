{ pkgs, ... }: {
  # https://nixos.wiki/wiki/Printing
  #
  # airprinting + printer by hp
  # avaiable on http://localhost:631
  services.printing = {
    enable = true;
    drivers = with pkgs; [ hplip ];
    listenAddresses = [ "*:631" ];
    allowFrom = [ "all" ];
    browsing = true;
    defaultShared = true;
    openFirewall = true;
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };

  };
  # scanner
  hardware.sane = {
    enable = true;
    extraBackends = with pkgs; [ sane-airscan hplipWithPlugin ];
    # shutdown default backend
    disabledDefaultBackends = [ "escl" ];
  };
  services.ipp-usb.enable = true;
}
