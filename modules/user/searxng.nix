{
  lib,
  ...
}:

{
  services.searx = {
    enable = true;
    redisCreateLocally = true;
    environmentFile = "/home/butterscotch/.config/searxng.env";
    settings = {
      server = {
        bind_address = "127.0.0.1";
        port = 31588;
        limiter = false;
        public_instance = false;
      };
      search = {
        formats = [
          "html"
          "json"
        ];
      };
      engines = lib.mapAttrsToList (name: value: { inherit name; } // value) {
        "brave".disabled = true;
        "startpage".disabled = true;
        "wikidata".disabled = true;
      };
    };
  };
}
