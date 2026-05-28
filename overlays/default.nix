{ inputs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      # Workaround for openldap build failures on i686
      # See: https://github.com/NixOS/nixpkgs/issues/514113
      openldap = prev.openldap.overrideAttrs {
        doCheck = !prev.stdenv.hostPlatform.isi686;
      };
      # Newer rnnoise model
      rnnoise =
        (prev.rnnoise.override {
          modelUrl = "https://media.xiph.org/rnnoise/models/rnnoise_data-0a8755f8e2d834eff6a54714ecc7d75f9932e845df35f8b59bc52a7cfe6e8b37.tar.gz";
          modelHash = "sha256-CodV+OLYNO/2pUcU7MfXX5ky6EXfNfi1m8UqfP5uizc=";
        }).overrideAttrs
          {
            src = prev.fetchFromGitLab {
              domain = "gitlab.xiph.org";
              owner = "xiph";
              repo = "rnnoise";
              rev = "70f1d256acd4b34a572f999a05c87bf00b67730d";
              sha256 = "sha256-fkSy7Sqnx0yLfGLciHf8PaptzFVzFAeRrhE4R5z8hSw=";
            };
            patches = [ ];
          };
      # From https://github.com/NixOS/nixpkgs/pull/524960
      github-desktop = prev.github-desktop.overrideAttrs {
        postConfigure = ''
          yarnOfflineCache="$cacheRoot" runHook yarnConfigHook

          pushd app
          yarnOfflineCache="$cacheApp" runHook yarnConfigHook
          popd

          yarn --cwd app/node_modules/desktop-notifications run install

          # use git from nixpkgs instead of an automatically downloaded one by dugite
          gitRoot=app/node_modules/dugite/git
          makeWrapper ${prev.lib.getExe prev.git} "$gitRoot/bin/git" \
            --prefix PATH : ${prev.lib.makeBinPath [ prev.git-lfs ]}

          mkdir -p "$gitRoot/libexec/git-core"

          for script in ${prev.git}/libexec/git-core/*; do
            ln -s "$script" "$gitRoot/libexec/git-core/$(basename "$script")"
          done

          # exception: printenvz needs `node-gyp` configure first for some reason
          pushd node_modules/printenvz
          node node_modules/.bin/node-gyp configure
          popd

          declare -a natives=(
            app/node_modules/fs-admin
            app/node_modules/keytar
            app/node_modules/desktop-trampoline
            app/node_modules/windows-argv-parser
            node_modules/printenvz
          )
          for native in "''${natives[@]}"; do
            yarn --offline --cwd $native build
          done

          # exception: desktop-trampoline doesn't include `node-gyp rebuild` in its build script anymore
          pushd app/node_modules/desktop-trampoline
          node-gyp rebuild
          popd

          yarn compile:script

          touch electron
          zip -0Xqr electron-v${prev.electron.version}-${prev.stdenv.hostPlatform.node.platform}-${prev.stdenv.hostPlatform.node.arch}.zip electron
          rm electron

          substituteInPlace script/build.ts \
            --replace-fail "return packager({" "return packager({electronZipDir:\"$(pwd)\",electronVersion: \"${prev.electron.version}\","
        '';
      };
    })
    inputs.affinity-nix.overlays.default
  ];
}
