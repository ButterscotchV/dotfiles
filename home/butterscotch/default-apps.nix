{ ... }:

let
  text = "code.desktop";
  video = "haruna.desktop";
in
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Text
      "application/json" = text;
      "application/yaml" = text;
      "text/css" = text;
      "text/javascript" = text;
      "text/markdown" = text;
      "text/plain" = text;
      "text/typescript" = text;
      "text/x-kotlin" = text;

      # Video
      "video/mp2t" = video;
      "video/mp4" = video;
      "video/mpeg" = video;
      "video/ogg" = video;
      "video/webm" = video;
      "video/x-msvideo" = video;
    };
  };
}
