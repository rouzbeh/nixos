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
        identityFile = "~/.ssh/id_ed25519";
      };
  };

  programs.vim = {
    packageConfigurable = (
      (pkgs.vim_configurable.override {
        python3 = pkgs.python3;
        guiSupport = false;
      })
    );
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline vim-nix ];
    settings = { ignorecase = true; };
    extraConfig = ''
    '';
  };

}

