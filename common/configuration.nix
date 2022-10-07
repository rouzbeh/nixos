{ pkgs, ... }: {

  nix = {
    package = pkgs.nix_2_6;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  imports = [
    (fetchTarball { url = "https://github.com/msteen/nixos-vscode-server/tarball/master"; sha256 = "1qga1cmpavyw90xap5kfz8i6yz85b0blkkwvl00sbaxqcgib2rvv"; })
  ];

  services.vscode-server.enable = true;
  system.autoUpgrade.enable = true;

  environment.systemPackages = with pkgs; [
    python310
    dig
    wget
    openssl
  ];
  boot.cleanTmpDir = true;
  services.openssh.permitRootLogin = "no";

}
