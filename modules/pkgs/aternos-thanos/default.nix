{
  lib,
  fetchFromGitHub,
  makeWrapper,
  php84,
}:

php84.buildComposerProject2 (finalAttrs: {
  pname = "thanos";
  version = "3.0.0";

  src = fetchFromGitHub {
    owner = "aternosorg";
    repo = "thanos";
    tag = "v${finalAttrs.version}";
    hash = "sha256-rvTyN+7AGTZ47h6sybnJYOGtcO8UatASOKTxpSB25sc=";
  };

  vendorHash = "sha256-6HQScB5vFQ3E9RA6W4OVM36YRgV5hGEmuFGyuaiH5OQ=";

  nativeBuildInputs = [
    makeWrapper
  ];

  postInstall = ''
    makeWrapper $out/share/php/thanos/thanos.php $out/bin/thanos
  '';

  meta = {
    description = "PHP library and CLI tool for removing unused chunks from Minecraft worlds";
    homepage = "https://github.com/aternosorg/thanos";
    changelog = "https://github.com/aternosorg/thanos/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    mainProgram = "thanos";
    platforms = lib.platforms.unix;
  };
})
