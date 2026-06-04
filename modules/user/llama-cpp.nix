{
  pkgs,
  lib,
  utils,
  config,
  ...
}:

let
  llama-cpp-custom =
    (pkgs.llama-cpp.override {
      cudaSupport = false;
      rocmSupport = true;
      openclSupport = true;
      metalSupport = false;
      vulkanSupport = true;
      blasSupport = true;
      rpcSupport = false;
      rocmGpuTargets = [ "gfx1100" ];
    }).overrideAttrs
      (previousAttrs: {
        # BUILD_NUMBER="$(git rev-list --count HEAD)"
        version = "9501";
        src = pkgs.fetchFromGitHub {
          owner = "ggml-org";
          repo = "llama.cpp";
          rev = "65ef50a0a4bb240211a41d43c957ae6313af6841";
          hash = "sha256-ThC2xCIJ7Nk4awvXJQBTLiDZgh8c7z5qGwc5gYW5TKU=";
          leaveDotGit = true;
          postFetch = ''
            git -C "$out" rev-parse --short HEAD > $out/COMMIT
            find "$out" -name .git -print0 | xargs -0 rm -rf
          '';
        };
        buildInputs = previousAttrs.buildInputs ++ [
          pkgs.rocmPackages.rocwmma
        ];
        npmRoot = "tools/ui";
        npmDepsHash = "sha256-1iM0LGeI9e+gZEHk46lkBe51DxIhiimfAm9o3Z3m9Ik=";
        cmakeFlags = (
          # Filter out existing GGML_NATIVE flag
          (lib.filter (x: !(lib.hasInfix "GGML_NATIVE" x)) (previousAttrs.cmakeFlags or [ ]))
          ++ [
            (lib.cmakeBool "GGML_NATIVE" true)
            (lib.cmakeBool "GGML_HIP_ROCWMMA_FATTN" true)
            (lib.cmakeFeature "GPU_TARGETS" "gfx1100;gfx1036")
          ]
        );
        env = (previousAttrs.env or { }) // {
          CPATH =
            let
              oldCPATH = previousAttrs.env.CPATH or "";
            in
            (lib.makeIncludePath [ pkgs.rocmPackages.rocwmma ])
            + (lib.optionalString (oldCPATH != "") ":${oldCPATH}");
          # Disable Nix's march=native stripping
          NIX_ENFORCE_NO_NATIVE = false;
        };
      });
  defaultConfig = {
    # device = "ROCm0";
    # device = "Vulkan0";
    device = "Vulkan1,Vulkan0";
    main-gpu = "1";
    split-mode = "row";
    fit-target = "64,1024";
    flash-attn = "enabled";
    cache-type-k = "q8_0";
    cache-type-v = "q8_0";
    ctx-checkpoints = "4";
    checkpoint-min-step = "8192";
    fit = "on";
    reasoning = "on";
    # mmproj-offload = "disabled";
    sleep-idle-seconds = "300";
  };
  defaultQwen35Config = (
    defaultConfig
    // {
      temp = "1.0";
      top-p = "0.95";
      top-k = "20";
      min-p = "0.0";
    }
  );
  defaultQwen35MTPConfig = (
    defaultQwen35Config
    // {
      spec-draft-device = "Vulkan0";
      # spec-draft-device = "Vulkan1,Vulkan0";
      spec-type = "draft-mtp";
      spec-draft-n-max = "2";
    }
  );
  defaultQwen36Config = (
    defaultQwen35Config
    // {
      chat-template-kwargs = "{\"preserve_thinking\":true}";
    }
  );
  defaultQwen36MTPConfig = (defaultQwen35MTPConfig // defaultQwen36Config);
  defaultGemma4Config = (
    defaultConfig
    // {
      temp = "1.0";
      top-p = "0.95";
      top-k = "64";
    }
  );
in
{
  # Context length can be specified with `c = len;`
  services.llama-cpp = {
    enable = true;
    host = "0.0.0.0";
    port = 31586;
    package = llama-cpp-custom;
    openFirewall = true;
    extraFlags = [
      "--models-max"
      "1"
    ];
    modelsPreset = {
      "unsloth/Qwen3.5-122B-A10B-GGUF:IQ3_XXS" = defaultQwen35Config // {
        hf-repo = "unsloth/Qwen3.5-122B-A10B-GGUF:UD-IQ3_XXS";
        c = 80128;
      };
      "unsloth/Qwen3.6-27B-MTP-GGUF:Q5_K_XL" = defaultQwen36MTPConfig // {
        hf-repo = "unsloth/Qwen3.6-27B-MTP-GGUF:UD-Q5_K_XL";
      };
      "unsloth/Qwen3.6-27B-GGUF:Q5_K_XL" = defaultQwen36Config // {
        hf-repo = "unsloth/Qwen3.6-27B-GGUF:UD-Q5_K_XL";
      };
      "unsloth/Qwen3.6-35B-A3B-MTP-GGUF:Q5_K_XL" = defaultQwen36MTPConfig // {
        hf-repo = "unsloth/Qwen3.6-35B-A3B-MTP-GGUF:UD-Q5_K_XL";
      };
      "unsloth/Qwen3.6-35B-A3B-GGUF:Q5_K_XL" = defaultQwen36Config // {
        hf-repo = "unsloth/Qwen3.6-35B-A3B-GGUF:UD-Q5_K_XL";
      };
      "unsloth/gemma-4-31B-it-GGUF:Q5_K_XL" = defaultGemma4Config // {
        hf-repo = "unsloth/gemma-4-31B-it-GGUF:UD-Q5_K_XL";
      };
      "unsloth/gemma-4-E4B-it-GGUF:Q5_K_XL" = defaultGemma4Config // {
        hf-repo = "unsloth/gemma-4-E4B-it-GGUF:UD-Q5_K_XL";
      };
    };
  };
  systemd.services.llama-cpp.serviceConfig.Environment = [
    "MESA_SHADER_CACHE_DIR=/var/cache/llama-cpp/mesa_shader_cache"
  ];

  systemd.services.llama-cpp-embed = {
    description = "LLaMA C++ server (embeddings)";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "idle";
      KillSignal = "SIGINT";
      StateDirectory = "llama-cpp-embed";
      CacheDirectory = "llama-cpp-embed";
      WorkingDirectory = "/var/lib/llama-cpp-embed";
      Environment = [
        "LLAMA_CACHE=/var/cache/llama-cpp-embed"
        "MESA_SHADER_CACHE_DIR=/var/cache/llama-cpp-embed/mesa_shader_cache"
      ];

      # Points directly to the server binary inside your package
      ExecStart =
        let
          args = [
            "--host"
            "127.0.0.1"
            "--port"
            "31587"
            "--device"
            "Vulkan1"
            "--no-webui"
            "--embedding"
            "--sleep-idle-seconds"
            "300"
            "--no-mmproj"
            "--hf-repo"
            # Embedding Dimension: 1024
            "jinaai/jina-embeddings-v5-omni-small-retrieval-GGUF:Q6_K"
            # Embedding Dimension: 768
            # "jinaai/jina-embeddings-v5-omni-nano-retrieval-GGUF:Q6_K"
          ];
        in
        "${llama-cpp-custom}/bin/llama-server ${utils.escapeSystemdExecArgs args}";
      Restart = "on-failure";
      RestartSec = 300;

      # for GPU acceleration
      PrivateDevices = false;

      # hardening
      DynamicUser = true;
      CapabilityBoundingSet = "";
      RestrictAddressFamilies = [
        "AF_INET"
        "AF_INET6"
        "AF_UNIX"
      ];
      NoNewPrivileges = true;
      PrivateMounts = true;
      PrivateTmp = true;
      PrivateUsers = true;
      ProtectClock = true;
      ProtectControlGroups = true;
      ProtectHome = true;
      ProtectKernelLogs = true;
      ProtectKernelModules = true;
      ProtectKernelTunables = true;
      ProtectSystem = "strict";
      MemoryDenyWriteExecute = true;
      LockPersonality = true;
      RemoveIPC = true;
      RestrictNamespaces = true;
      RestrictRealtime = true;
      RestrictSUIDSGID = true;
      SystemCallArchitectures = "native";
      SystemCallFilter = [
        "@system-service"
        "~@privileged"
      ];
      SystemCallErrorNumber = "EPERM";
      ProtectProc = "invisible";
      ProtectHostname = true;
      ProcSubset = "pid";
    };
  };

  services.searx = {
    enable = true;
    redisCreateLocally = true;
    environmentFile = "/home/butterscotch/.config/searxng.env";
    limiterSettings = {
      botdetection = {
        ip_limit = {
          filter_link_local = true;
          link_token = true;
        };
        ip_lists = {
          pass_ip = [
            "127.0.0.0/8"
          ];
        };
      };
    };
    settings = {
      server = {
        bind_address = "127.0.0.1";
        port = 31588;
        limiter = false;
        public_instance = false;
      };
      engines = lib.mapAttrsToList (name: value: { inherit name; } // value) {
        "brave".disabled = true;
        "startpage".disabled = true;
        "wikidata".disabled = true;
      };
    };
  };

  environment.systemPackages = [
    llama-cpp-custom
  ];
}
