{
  pkgs,
  lib,
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
      (oldAttrs: {
        version = "9205";
        src = pkgs.fetchFromGitHub {
          owner = "ggml-org";
          repo = "llama.cpp";
          rev = "dd7cad7197f991b18ded6aca46ff095972b95318";
          hash = "sha256-nLacNxmdYhwOv4+ssuQrSLY2T6CQlLNeLF9vdmjWqQw=";
          leaveDotGit = true;
          postFetch = ''
            git -C "$out" rev-parse --short HEAD > $out/COMMIT
            find "$out" -name .git -print0 | xargs -0 rm -rf
          '';
        };
        buildInputs = oldAttrs.buildInputs ++ [
          pkgs.rocmPackages.rocwmma
        ];
        npmRoot = "tools/ui";
        npmDepsHash = "sha256-WaEePrEZ7O/7deP2KJhe0AwiSKYA8HOqETmMHUkmBe0=";
        cmakeFlags = (
          # Filter out existing GGML_NATIVE flag
          (lib.filter (x: !(lib.hasInfix "GGML_NATIVE" x)) (oldAttrs.cmakeFlags or [ ]))
          ++ [
            (lib.cmakeBool "GGML_NATIVE" true)
            (lib.cmakeBool "GGML_HIP_ROCWMMA_FATTN" true)
            (lib.cmakeFeature "GPU_TARGETS" "gfx1100;gfx1036")
          ]
        );
        env = (oldAttrs.env or { }) // {
          CPATH =
            let
              oldCPATH = oldAttrs.env.CPATH or "";
            in
            (lib.makeIncludePath [ pkgs.rocmPackages.rocwmma ])
            + (lib.optionalString (oldCPATH != "") ":${oldCPATH}");
          # Disable Nix's march=native stripping
          NIX_ENFORCE_NO_NATIVE = false;
        };
      });
  defaultConfig = {
    # ROCm0 or Vulkan0
    device = "Vulkan0";
    flash-attn = "enabled";
    cache-type-k = "q8_0";
    cache-type-v = "q8_0";
    ctx-checkpoints = "4";
    checkpoint-every-n-tokens = "8192";
    fit = "on";
    chat-template-kwargs = "{\"enable_thinking\":true}";
    mmproj-offload = "disabled";
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
      spec-type = "draft-mtp";
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
      "unsloth/Qwen3.5-122B-A10B-MTP-GGUF:IQ3_XXS" = defaultQwen35MTPConfig // {
        hf-repo = "unsloth/Qwen3.5-122B-A10B-MTP-GGUF:UD-IQ3_XXS";
        c = 80128;
      };
      "unsloth/Qwen3.5-122B-A10B-GGUF:IQ3_XXS" = defaultQwen35Config // {
        hf-repo = "unsloth/Qwen3.5-122B-A10B-GGUF:UD-IQ3_XXS";
        c = 80128;
      };
      "unsloth/Qwen3.6-27B-MTP-GGUF:Q6_K_XL" = defaultQwen36MTPConfig // {
        hf-repo = "unsloth/Qwen3.6-27B-MTP-GGUF:UD-Q6_K_XL";
      };
      "unsloth/Qwen3.6-27B-GGUF:Q4_K_XL" = defaultQwen36Config // {
        hf-repo = "unsloth/Qwen3.6-27B-GGUF:UD-Q4_K_XL";
      };
      "unsloth/Qwen3.6-27B-GGUF:Q3_K_XL" = defaultQwen36Config // {
        hf-repo = "unsloth/Qwen3.6-27B-GGUF:UD-Q3_K_XL";
      };
      "unsloth/Qwen3.6-35B-A3B-MTP-GGUF:Q6_K_XL" = defaultQwen36MTPConfig // {
        hf-repo = "unsloth/Qwen3.6-35B-A3B-MTP-GGUF:UD-Q6_K_XL";
      };
      "unsloth/Qwen3.6-35B-A3B-GGUF:Q4_K_M" = defaultQwen36Config // {
        hf-repo = "unsloth/Qwen3.6-35B-A3B-GGUF:UD-Q4_K_M";
      };
      "unsloth/Qwen3.6-35B-A3B-GGUF:Q3_K_M" = defaultQwen36Config // {
        hf-repo = "unsloth/Qwen3.6-35B-A3B-GGUF:UD-Q3_K_M";
      };
      "unsloth/gemma-4-31B-it-GGUF:Q4_K_XL" = defaultGemma4Config // {
        hf-repo = "unsloth/gemma-4-31B-it-GGUF:UD-Q4_K_XL";
      };
      "unsloth/gemma-4-31B-it-GGUF:IQ3_XXS" = defaultGemma4Config // {
        hf-repo = "unsloth/gemma-4-31B-it-GGUF:UD-IQ3_XXS";
      };
      "unsloth/gemma-4-26B-A4B-it-GGUF:Q4_K_M" = defaultGemma4Config // {
        hf-repo = "unsloth/gemma-4-26B-A4B-it-GGUF:UD-Q4_K_M";
      };
      "unsloth/gemma-4-E4B-it-GGUF:Q8_K_XL" = defaultGemma4Config // {
        hf-repo = "unsloth/gemma-4-E4B-it-GGUF:UD-Q8_K_XL";
      };
      "unsloth/gemma-4-E4B-it-GGUF:Q6_K_XL" = defaultGemma4Config // {
        hf-repo = "unsloth/gemma-4-E4B-it-GGUF:UD-Q6_K_XL";
      };
    };
  };

  containers.llama-cpp-embed = {
    autoStart = true;
    config =
      { ... }:
      {
        services.llama-cpp = {
          enable = true;
          host = "127.0.0.1";
          port = 31587;
          package = llama-cpp-custom;
          extraFlags = [
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
        };
        system.stateVersion = "26.05";
      };
  };

  environment.systemPackages = [
    llama-cpp-custom
  ];
}
