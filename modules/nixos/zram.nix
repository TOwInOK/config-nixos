{ lib, ... }: {
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
    priority = 999;
  };
  swapDevices = lib.mkForce [ ];

  boot.kernel.sysctl = {
      # Более агрессивный swap (по умолчанию 60)
      "vm.swappiness" = 180;
      # Баланс между swapping и file cache
      "vm.vfs_cache_pressure" = 50;
      # Минимальный процент свободной памяти
      "vm.min_free_kbytes" = 65536;
      # Разрешить перезапись swap только когда действительно необходимо
      "vm.page-cluster" = 0;
    };
}
