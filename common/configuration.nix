{ pkgs, ... }: {

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.autoUpgrade.enable = true;

  environment.systemPackages = with pkgs; [
    python310
    dig
    wget
  ];
  boot.cleanTmpDir = true;
  services.openssh.permitRootLogin = "no";
}
