{ pkgs, ... }:

{
  # Enables support for SANE scanners
  hardware.sane = {
    enable = true;
    brscan5 = {
      enable = true;
      netDevices = {
        HL-L2465DW = {
          model = "HL-L2465DW";
          nodename = "BRW046874F1F9FA.local";
        };
      };
    };
  };

  # Add Brother printer drivers
  services.printing.drivers = [
    pkgs.brlaser
    pkgs.brgenml1lpr
    pkgs.brgenml1cupswrapper
  ];
}
