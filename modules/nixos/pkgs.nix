{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # git
    # btop # top
    # yazi # tui file manager
    # zoxide # cd on rust
    # helix # editor
    # vim
    # oxker # docker tui
    # carapace # argument complitter
    # zram-status # Utility to monitor and manage zram devices
  ];
}
