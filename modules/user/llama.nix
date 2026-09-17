{
  pkgsFast,
  lib,
  ...
}:

let
  llama-package = pkgsFast.llama-cpp-vulkan;
in
{
  environment.systemPackages = [
    llama-package
  ];

  services.llama-cpp = {
    enable = true;
    package = llama-package;

    settings = {
      host = "127.0.0.1";
      port = 31586;
      device = "Vulkan0";
      sleep-idle-seconds = 300;
      api-key-file = "/var/lib/llama-cpp/llama-cpp.list";

      hf-repo = "unsloth/Qwen3.8-27B-GGUF:UD-Q4_K_XL";
      no-mmproj-auto = "";
      # no-mmproj-offload = "";

      reasoning = "on";
      temp = 1.0;
      top-p = 0.95;
      top-k = 20;
      min-p = 0.0;

      flash-attn = "on";
      cache-type-k = "q8_0";
      cache-type-v = "q8_0";

      ctx-size = 96000;
      ctx-checkpoints = 4;
      checkpoint-min-step = 8192;
    };
  };
  systemd.services.llama-cpp.serviceConfig.Environment = [
    "MESA_SHADER_CACHE_DIR=/var/cache/llama-cpp/mesa_shader_cache"
  ];

  services.searx = {
    enable = true;
    redisCreateLocally = true;
    environmentFile = "/home/butterscotch/.config/searxng.env";
    settings = {
      server = {
        bind_address = "127.0.0.1";
        port = 31587;
        limiter = false;
        public_instance = false;
      };
      search = {
        formats = [
          "html"
          "json"
        ];
      };
      engines = lib.mapAttrsToList (name: value: { inherit name; } // value) {
        "brave".disabled = true;
        "google".disabled = true;
        "startpage".disabled = true;
        "wikidata".disabled = true;
      };
    };
  };
}
