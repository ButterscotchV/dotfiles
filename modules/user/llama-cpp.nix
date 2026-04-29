{
  config,
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
      (oldAttrs: rec {
        version = "8975";
        src = pkgs.fetchFromGitHub {
          owner = "ggml-org";
          repo = "llama.cpp";
          rev = "59237bfbbc13723a5942082d278f477f2edcf4df";
          hash = "sha256-ro3JKdTE5yI/AOFGBJ3yltnS10LYtBHnA8dzrLeSUo4=";
          leaveDotGit = true;
          postFetch = ''
            git -C "$out" rev-parse --short HEAD > $out/COMMIT
            find "$out" -name .git -print0 | xargs -0 rm -rf
          '';
        };
        buildInputs = oldAttrs.buildInputs ++ [
          pkgs.rocmPackages.rocwmma
        ];
        npmDepsHash = "sha256-iYJB0z2YHG8OzEA9EwHUZrDa5obr5m2sbnIH+of28o0=";
        cmakeFlags = (
          # Filter out existing GGML_NATIVE flag
          (lib.filter (x: !(lib.hasInfix "GGML_NATIVE" x)) (oldAttrs.cmakeFlags or [ ]))
          ++ [
            (lib.cmakeBool "GGML_NATIVE" true)
            (lib.cmakeBool "GGML_HIP_ROCWMMA_FATTN" true)
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
    chat-template-kwargs = "{\"preserve_thinking\":true}";
    no-mmproj = "enabled";
    sleep-idle-seconds = "300";
  };
  defaultQwen36Config = (
    defaultConfig
    // {
      temp = "1.0";
      top-p = "0.95";
      top-k = "20";
      min-p = "0.0";
    }
  );
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
  services.llama-cpp = {
    enable = true;
    host = "0.0.0.0";
    port = 8080;
    package = llama-cpp-custom;
    openFirewall = true;
    extraFlags = [
      "--models-max"
      "1"
    ];
    modelsPreset = {
      "unsloth/Qwen3.6-27B-GGUF:Q4_K_XL" = (
        defaultQwen36Config
        // {
          hf-repo = "unsloth/Qwen3.6-27B-GGUF:UD-Q4_K_XL";
          # c = "128000";
        }
      );
      "unsloth/Qwen3.6-27B-GGUF:Q3_K_XL" = (
        defaultQwen36Config
        // {
          hf-repo = "unsloth/Qwen3.6-27B-GGUF:UD-Q3_K_XL";
          # c = "128000";
        }
      );
      "unsloth/Qwen3.6-35B-A3B-GGUF:Q4_K_M" = (
        defaultQwen36Config
        // {
          hf-repo = "unsloth/Qwen3.6-35B-A3B-GGUF:UD-Q4_K_M";
          # c = "65536";
        }
      );
      "unsloth/Qwen3.6-35B-A3B-GGUF:Q3_K_M" = (
        defaultQwen36Config
        // {
          hf-repo = "unsloth/Qwen3.6-35B-A3B-GGUF:UD-Q3_K_M";
          # c = "65536";
        }
      );
      "unsloth/gemma-4-31B-it-GGUF:Q4_K_XL" = (
        defaultGemma4Config
        // {
          hf-repo = "unsloth/gemma-4-31B-it-GGUF:UD-Q4_K_XL";
          # c = "65536";
        }
      );
      "unsloth/gemma-4-31B-it-GGUF:IQ3_XXS" = (
        defaultGemma4Config
        // {
          hf-repo = "unsloth/gemma-4-31B-it-GGUF:UD-IQ3_XXS";
          # c = "65536";
        }
      );
      "unsloth/gemma-4-26B-A4B-it-GGUF:Q4_K_M" = (
        defaultGemma4Config
        // {
          hf-repo = "unsloth/gemma-4-26B-A4B-it-GGUF:UD-Q4_K_M";
          # c = "65536";
        }
      );
      "unsloth/gemma-4-E4B-it-GGUF:Q8_K_XL" = (
        defaultGemma4Config
        // {
          hf-repo = "unsloth/gemma-4-E4B-it-GGUF:UD-Q8_K_XL";
          # c = "65536";
        }
      );
      "unsloth/gemma-4-E4B-it-GGUF:Q6_K_XL" = (
        defaultGemma4Config
        // {
          hf-repo = "unsloth/gemma-4-E4B-it-GGUF:UD-Q6_K_XL";
          # c = "65536";
        }
      );
    };
  };

  environment.systemPackages = with pkgs; [
    llama-cpp-custom
  ];
}
