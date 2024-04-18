{ lib, config, ... }: lib.mkIf config.bchmnn.ai.enable {

  virtualisation = {
    oci-containers = {
      containers = {
        coqui-ai-tts = {
          image = "ghcr.io/coqui-ai/tts:latest";
          autoStart = true;
          ports = ["127.0.0.1:5002:5002"];
          entrypoint = "/bin/bash";
          cmd = [];
        };
      };
    };
  };

}
