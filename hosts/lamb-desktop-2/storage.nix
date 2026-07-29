{
  fileSystems."/run/media/butterscotch/Fast Storage" = {
    device = "/dev/disk/by-uuid/e4bddff2-61a0-4069-b830-460c234a55ba";
    fsType = "ext4";
    options = [ "nofail" ];
  };
  fileSystems."/run/media/butterscotch/Slow Storage" = {
    device = "/dev/disk/by-uuid/12664d5d-d2bd-4b91-955b-64a0b131fe3f";
    fsType = "ext4";
    options = [ "nofail" ];
  };
}
