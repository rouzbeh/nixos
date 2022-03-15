{ pkgs, ... }: {

  nix = {
    package = pkgs.nixUnstable; # or versioned attributes like nix_2_4
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  imports = [
    (fetchTarball { url = "https://github.com/msteen/nixos-vscode-server/tarball/master"; sha256 = "00aqwrr6bgvkz9bminval7waxjamb792c0bz894ap8ciqawkdgxp"; })
  ];

  services.vscode-server.enable = true;
  system.autoUpgrade.enable = true;

  environment.systemPackages = with pkgs; [
    python310
  ];
  boot.cleanTmpDir = true;
  services.openssh.permitRootLogin = "no";

}
