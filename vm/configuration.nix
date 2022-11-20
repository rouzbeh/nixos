{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ../common/configuration.nix ];

  # environment.pathsToLink = [ "/libexec" ];
  environment.systemPackages = with pkgs; [ emacs tmux ];

  virtualisation.docker.enable = true;
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "vm"; # Define your hostname.

  users.users.rouzbeh = {
    isNormalUser = true;
    home = "/home/rouzbeh";
    description = "Ali";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIfTIso0wIp92pUNoBfpCbqnpx8B68GwHusZRE9GRQk ali.neishabouri@theactigraph.com"
    ];
  };

  # Configure swap file. Sizes are in megabytes. Default swap is
  # max(1GB, sqrt(RAM)) = 1024. If you want to use hibernation with
  # this device, then it's recommended that you use
  # RAM + max(1GB, sqrt(RAM)) = 4931.000.
  swapDevices = [{
    device = "/swapfile";
    size = 1024;
  }];
}
