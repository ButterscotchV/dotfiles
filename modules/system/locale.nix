{ pkgs, ... }:

{
  time.timeZone = "America/Toronto";
  i18n = {
    defaultLocale = "en_CA.UTF-8";
    extraLocales = [
      "en_US.UTF-8/UTF-8"
    ];
  };
  environment.systemPackages = with pkgs; [
    # KDE Spellcheck (Sonnet)
    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
    hunspell
    hunspellDicts.en-ca
    hunspellDicts.en-ca-large
    # Spellcheck for LibreOffice
    hyphenDicts.en-gb
    hyphenDicts.en-us
  ];
}
