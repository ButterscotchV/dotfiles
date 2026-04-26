{
  pname,
  source,
  meta,
  binaryName,
  desktopName,
  self,
  # autoPatchelfHook is removed; replaced by buildFHSEnv
  fetchurl,
  makeDesktopItem,
  lib,
  stdenv,
  buildFHSEnv,
  wrapGAppsHook3,
  makeShellWrapper,
  alsa-lib,
  at-spi2-atk,
  at-spi2-core,
  atk,
  cairo,
  cups,
  dbus,
  expat,
  freetype,
  gdk-pixbuf,
  glib,
  gtk3,
  libcxx,
  libdrm,
  libglvnd,
  libnotify,
  libpulseaudio,
  libuuid,
  libva,
  libx11,
  libxscrnsaver,
  libxcomposite,
  libxcursor,
  libxdamage,
  libxext,
  libxfixes,
  libxi,
  libxrandr,
  libxrender,
  libxtst,
  libxcb,
  libxkbcommon,
  libxshmfence,
  libgbm,
  nspr,
  nss,
  pango,
  systemdLibs,
  libappindicator-gtk3,
  libdbusmenu,
  brotli,
  writeShellScript,
  pipewire,
  python3,
  runCommand,
  libunity,
  speechd-minimal,
  wayland,
  branch,
  withOpenASAR ? false,
  openasar,
  withVencord ? false,
  vencord,
  withEquicord ? false,
  equicord,
  withMoonlight ? false,
  moonlight,
  withTTS ? true,
  enableAutoscroll ? false,
  disableUpdates ? true,
  commandLineArgs ? "",
  ...
}:

let
  inherit (source) version;
  isDistro = source.kind == "distro";

  src = if isDistro then
    fetchurl { inherit (source.distro) url hash; }
    else fetchurl { inherit (source) url hash; };

  moduleSrcs = lib.optionalAttrs isDistro (
    lib.mapAttrs (_: mod: fetchurl { inherit (mod) url hash; }) source.modules
  );

  # 1. The Unpacked App (No patching)
  baseApp = stdenv.mkDerivation {
    pname = "${pname}-unwrapped";
    inherit version src;

    nativeBuildInputs = [ brotli ];

    # Disable automatic patching that could modify binaries
    dontPatchELF = true;
    dontStrip = true;
    dontPatchShebangs = true;

    dontBuild = true;
    dontConfigure = true;
    dontUnpack = isDistro;

    installPhase = ''
      mkdir -p $out/opt/${binaryName}
      ${if isDistro then ''
        brotli -d < $src | tar xf - --strip-components=1 -C $out/opt/${binaryName}
        ${lib.concatStringsSep "\n" (lib.mapAttrsToList (name: src: ''
          mkdir -p $out/opt/${binaryName}/modules/${name}
          brotli -d < ${src} | tar xf - --strip-components=1 -C $out/opt/${binaryName}/modules/${name}
        '') moduleSrcs)}
      '' else ''
        mv * $out/opt/${binaryName}
      ''}

      # Apply Mod JS logic here (OpenASAR, Vencord, etc.)
      ${lib.optionalString withOpenASAR "cp -f ${openasar} $out/opt/${binaryName}/resources/app.asar"}
      ${lib.optionalString withVencord ''
        mv $out/opt/${binaryName}/resources/app.asar $out/opt/${binaryName}/resources/_app.asar
        mkdir $out/opt/${binaryName}/resources/app
        echo '{"name":"discord","main":"index.js"}' > $out/opt/${binaryName}/resources/app/package.json
        echo 'require("${vencord}/patcher.js")' > $out/opt/${binaryName}/resources/app/index.js
      ''}
      # ... (repeat for Equicord/Moonlight as in your original postInstall)
    '';
  };

  # 2. The FHS Environment
  fhsEnv = buildFHSEnv {
    name = "${pname}-fhs";
    targetPkgs = pkgs: with pkgs; [
      # All libraries from your original libPath
      alsa-lib at-spi2-atk at-spi2-core atk brotli cairo cups dbus expat
      freetype gdk-pixbuf glib gtk3 libcxx libdrm libgbm libglvnd libnotify
      libpulseaudio libunity libuuid libva libx11 libxcb libxcomposite libxcursor
      libxdamage libxext libxfixes libxi libxkbcommon libxrandr libxrender
      libxshmfence libxscrnsaver libxtst nspr nss pango pipewire
      systemdLibs wayland libappindicator-gtk3 libdbusmenu
    ] ++ lib.optionals withTTS [ speechd-minimal ];

    # The runScript handles the original wrapProgram logic (Ozone, Wayland, etc.)
    runScript = writeShellScript "${binaryName}-wrapper" ''
      # Handle Wayland/Ozone flags
      export NIXOS_OZONE_WL=''${NIXOS_OZONE_WL:-}
      FLAGS="${commandLineArgs}"
      if [[ -n "$WAYLAND_DISPLAY" && -n "$NIXOS_OZONE_WL" ]]; then
        FLAGS="$FLAGS --ozone-platform=wayland --enable-features=WaylandWindowDecorations --enable-wayland-ime=true"
      fi

      exec ${baseApp}/opt/${binaryName}/${binaryName} $FLAGS "$@"
    '';
  };

  desktopItem = makeDesktopItem {
    name = pname;
    exec = pname; # Points to our final wrapper
    icon = pname;
    inherit desktopName;
    genericName = meta.description;
    categories = [ "Network" "InstantMessaging" ];
    mimeTypes = [ "x-scheme-handler/discord" ];
  };

in runCommand pname { inherit meta; } ''
  mkdir -p $out/bin $out/share/applications $out/share/icons/hicolor/256x256/apps

  # Link the FHS wrapper
  ln -s ${fhsEnv}/bin/${pname}-fhs $out/bin/${pname}
  # ln -s ${fhsEnv}/bin/${pname}-fhs $out/bin/${lib.toLower binaryName}

  # Link Desktop Assets
  cp ${desktopItem}/share/applications/* $out/share/applications/
  ln -s ${baseApp}/opt/${binaryName}/discord.png $out/share/icons/hicolor/256x256/apps/${pname}.png
''
