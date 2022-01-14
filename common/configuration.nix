{ pkgs, ... }: {

  nix = {
    package = pkgs.nixUnstable; # or versioned attributes like nix_2_4
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system.autoUpgrade.enable = true;

  environment.systemPackages = with pkgs; [
    python310
  ];
  boot.cleanTmpDir = true;
  services.openssh.permitRootLogin = "no";

}
