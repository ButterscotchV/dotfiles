{ config, pkgs, ... }:

{
  # Time and locale
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";
  i18n.supportedLocales = [
    "en_CA.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];
}
