{ ... }:

{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/plain" = "code.desktop";
      "application/json" = "code.desktop";
      "text/markdown" = "code.desktop";
      "text/javascript" = "code.desktop";
      "text/css" = "code.desktop";
      "text/typescript" = "code.desktop";
      "text/x-kotlin" = "code.desktop";
      "application/yaml" = "code.desktop";
    };
  };
}
