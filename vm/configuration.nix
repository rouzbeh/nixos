{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../common/configuration.nix
  ];

  nixpkgs.overlays = [(self: super: {
    alacritty = super.alacritty.overrideAttrs (
      o: rec {
        doCheck = false;
      }
      );
    })
  ];

  # environment.pathsToLink = [ "/libexec" ];
  environment.systemPackages = with pkgs; [
    i3
    alacritty
  ];

  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      i3status
      swayidle
      swaylock
      wl-clipboard
      mako
      wofi
      xterm
    ];
  };

  services.spice-vdagentd.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "vm"; # Define your hostname.

  users.users.rouzbeh = {
    isNormalUser = true;
    home = "/home/rouzbeh";
    description = "Ali";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIfTIso0wIp92pUNoBfpCbqnpx8B68GwHusZRE9GRQk ali.neishabouri@theactigraph.com" ];
  };

  # Configure swap file. Sizes are in megabytes. Default swap is
  # max(1GB, sqrt(RAM)) = 1024. If you want to use hibernation with
  # this device, then it's recommended that you use
  # RAM + max(1GB, sqrt(RAM)) = 4931.000.
  swapDevices = [ { device = "/swapfile"; size = 1024; } ];
}
