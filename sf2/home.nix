{ config, pkgs, ... }:
{
  imports = [ ../common/home.nix ];
  home.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };


  home.packages = with pkgs; [
    wasabiwallet
    bitwarden
    neovim
    firefox
    emacs
    git
    vlc
  ];

  programs.git = {
    userEmail = "ali@neishabouri.net";
  };

  programs.ssh.matchBlocks = {
    "github" =
      {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_sf2";
      };
    "ovh" =
      {
        hostname = "51.89.164.51";
        user = "rouzbeh";
        identityFile = "~/.ssh/id_sf2";
      };
    "pi" =
      {
        hostname = "192.168.1.2";
        user = "pi";
        identityFile = "~/.ssh/id_sf2";
      };
  };
}

