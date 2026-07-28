{
  fileSystems."/run/media/butterscotch/Fast Storage" = {
    device = "/dev/disk/by-uuid/01D92E29F0340C60";
    fsType = "ntfs3";
    options = [ "nofail" ];
  };
  fileSystems."/run/media/butterscotch/Slow Storage" = {
    device = "/dev/disk/by-uuid/12664d5d-d2bd-4b91-955b-64a0b131fe3f";
    fsType = "ext4";
    options = [ "nofail" ];
  };
}
