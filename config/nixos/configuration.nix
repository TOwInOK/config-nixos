# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ inputs, outputs, lib, pkgs, ... }: {
  imports = [ outputs.nixosModules.default ./hardware-configuration.nix ];

  # Flake registry and nix path match flake inputs
  nix = let flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = [ "nix-command" "flakes" ];
    };

    # make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # global
  users.defaultUserShell = pkgs.fish;

  # User configuration
  users.users = {
    towinok = {
      # change it after setup via passwd
      initialPassword = "twk";
      isNormalUser = true;
      useDefaultShell = pkgs.fish;
      extraGroups =
        [ "wheel" "networkmanager" "audio" "docker" "input" "scanner" "lp" ];
    };
  };

  # boot section
  boot = {
    loader.systemd-boot = true;
    loader.efi.canTouchEfiVariables = true;
    kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
  };

  # Networking configuration
  networking.hostName = "twk";
  # Enable nvidia
  hardware.nvidia.enable = true;
  # Enable sound
  sound.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
