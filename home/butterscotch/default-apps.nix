{ ... }:

let
  archive = "org.kde.ark.desktop";
  audio = "org.kde.haruna.desktop";
  browser = "firefox.desktop";
  image = "org.kde.gwenview.desktop";
  pdf = "org.kde.okular.desktop";
  text = "code.desktop";
  video = "org.kde.haruna.desktop";
in
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # === Archive ===
      "application/x-7z-compressed" = archive;
      "application/x-bzip2" = archive;
      "application/x-compressed-tar" = archive;
      "application/x-gzip" = archive;
      "application/x-rar" = archive;
      "application/x-tar" = archive;
      "application/zip" = archive;

      # === Audio ===
      "audio/aac" = audio;
      "audio/flac" = audio;
      "audio/m4a" = audio;
      "audio/mp3" = audio;
      "audio/mpeg" = audio;
      "audio/ogg" = audio;
      "audio/wav" = audio;
      "audio/x-matroska" = audio;

      # === Document/PDF ===
      "application/epub+zip" = pdf;
      "application/pdf" = pdf;

      # === Image ===
      "image/avif" = image;
      "image/bmp" = image;
      "image/gif" = image;
      "image/heif" = image;
      "image/jpeg" = image;
      "image/png" = image;
      "image/svg+xml" = image;
      "image/tiff" = image;
      "image/webp" = image;

      # === Text/code ===
      "application/json" = text;
      "application/toml" = text;
      "application/xml" = text;
      "application/yaml" = text;
      "text/css" = text;
      "text/csv" = text;
      "text/javascript" = text;
      "text/markdown" = text;
      "text/plain" = text;
      "text/typescript" = text;
      "text/x-c" = text;
      "text/x-c++src" = text;
      "text/x-go" = text;
      "text/x-java" = text;
      "text/x-kotlin" = text;
      "text/x-python" = text;
      "text/x-rust" = text;
      "text/x-shellscript" = text;
      "text/xml" = text;

      # === Video ===
      "video/avi" = video;
      "video/mp2t" = video;
      "video/mp4" = video;
      "video/mpeg" = video;
      "video/ogg" = video;
      "video/quicktime" = video;
      "video/webm" = video;
      "video/x-flv" = video;
      "video/x-matroska" = video;
      "video/x-msvideo" = video;

      # === Web/browser ===
      "application/xhtml+xml" = browser;
      "text/html" = browser;
      "x-scheme-handler/about" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/unknown" = browser;
    };
  };
}
