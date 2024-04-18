{ lib, config, ... }: lib.mkIf config.bchmnn.ai.enable {
  services.ollama = {
    enable = true;
    acceleration = if config.bchmnn.nvidia.enable then "cuda" else null;
  };
}
