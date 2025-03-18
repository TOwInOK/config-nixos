{ lib, ... }: {
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
    priority = 999;
  };
  swapDevices = lib.mkForce [ ];
}
