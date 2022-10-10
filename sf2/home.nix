{ config, pkgs, ... }:
{
  imports = [ ../common/home.nix ];

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
  };
}

