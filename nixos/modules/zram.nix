{
  zramSwap = {
    enable = true;
    algorithm = "zstd"; #or lz4
    memoryPercent = 100;
    priority = 999;
  };
}
