{ config, lib, ... }:

# https://nixos.wiki/wiki/Nvidia#Determining_the_Correct_Driver_Version

{
    # Nvidia configuration
    hardware.nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
      # of just the bare essentials.
      powerManagement.enable = false;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = true;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of
      # supported GPUs is at:
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
      # Only available from driver 515.43.04+
      open = true;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # prime = {
      #   sync.enable = true;
      #   reverseSync.enable = true;
      #   offload = {
      # 		enable = true;
      # 		enableOffloadCmd = true;
      #  	};
      # };

      # Driver

      ## With let
      # package = let
      #   rcu_patch = fetchpatch {
      #     url =
      #       "https://github.com/gentoo/gentoo/raw/c64caf53/x11-drivers/nvidia-drivers/files/nvidia-drivers-470.223.02-gpl-pfn_valid.patch";
      #     hash = "sha256-eZiQQp2S/asE7MfGvfe6dA/kdCvek9SYa/FFGp24dVg=";
      #   };
      # in config.boot.kernelPackages.nvidiaPackages.mkDriver {
      #   # version = "535.154.05";
      #   # sha256_64bit = "sha256-fpUGXKprgt6SYRDxSCemGXLrEsIA6GOinp+0eGbqqJg=";
      #   # sha256_aarch64 = "sha256-G0/GiObf/BZMkzzET8HQjdIcvCSqB1uhsinro2HLK9k=";
      #   # openSha256 = "sha256-wvRdHguGLxS0mR06P5Qi++pDJBCF8pJ8hr4T8O6TJIo=";
      #   # settingsSha256 = "sha256-9wqoDEWY4I7weWW05F4igj1Gj9wjHsREFMztfEmqm10=";
      #   # persistencedSha256 = "sha256-d0Q3Lk80JqkS1B54Mahu2yY/WocOqFFbZVBh+ToGhaE=";

      #   # version = "550.40.07";
      #   # sha256_64bit = "sha256-KYk2xye37v7ZW7h+uNJM/u8fNf7KyGTZjiaU03dJpK0=";
      #   # sha256_aarch64 = "sha256-AV7KgRXYaQGBFl7zuRcfnTGr8rS5n13nGUIe3mJTXb4=";
      #   # openSha256 = "sha256-mRUTEWVsbjq+psVe+kAT6MjyZuLkG2yRDxCMvDJRL1I=";
      #   # settingsSha256 = "sha256-c30AQa4g4a1EHmaEu1yc05oqY01y+IusbBuq+P6rMCs=";
      #   # persistencedSha256 = "sha256-11tLSY8uUIl4X/roNnxf5yS2PQvHvoNjnd2CB67e870=";

      #   version = "550.142";
      #   sha256_64bit = "sha256-bdVJivBLQtlSU7Zre9oVCeAbAk0s10WYPU3Sn+sXkqE=";
      #   sha256_aarch64 = "sha256-sBp5fcCPMrfrTZTF1FqKo9g0wOWP+5+wOwQ7PLWI6wA=";
      #   openSha256 = "sha256-hjpwTR4I0MM5dEjQn7MKM3RY1a4Mt6a61Ii9KW2KbiY=";
      #   settingsSha256 = "sha256-Wk6IlVvs23cB4s0aMeZzSvbOQqB1RnxGMv3HkKBoIgY=";
      #   persistencedSha256 =
      #     "sha256-yQFrVk4i2dwReN0XoplkJ++iA1WFhnIkP7ns4ORmkFA=";

      #   patches = [ rcu_patch ];
      # };

      ## Simple specific
      #   package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      #   version = "555.58.02";
      #   sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
      #   sha256_aarch64 = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
      #   openSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
      #   settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
      #   persistencedSha256 = lib.fakeSha256;
      # };

      ## From upstream
      package =
        config.boot.kernelPackages.nvidiaPackages.latest; # https://github.com/NixOS/nixpkgs/blob/master/pkgs/os-specific/linux/nvidia-x11/default.nix
    };

    # Enable OpenGL
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      # package = pkgs.mesa.drivers;
      # package32 = pkgs.pkgs.pkgsi686Linux.mesa.drivers;
    };
    # Add to xserver
    services.xserver.videoDrivers = [ "nvidia" ];

    # Enable systemd
    systemd.services.nvidia-udev.enable = true;
}
