{ ... }:

{
  # Enable XWayland for X11 compatibility
  programs.xwayland.enable = true;

  # Set up our display manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Enable KDE desktop
  services.desktopManager.plasma6.enable = true;

  # Configure Flatpak portals
  # (see: https://flatpak.github.io/xdg-desktop-portal/)
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };

  # Run Chromium and Electron stuff in Wayland native mode
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
