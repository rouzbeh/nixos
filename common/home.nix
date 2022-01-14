{ config, pkgs, ... }:
{

  home.packages = [ pkgs.nixpkgs-fmt pkgs.graphviz pkgs.htop pkgs.nix ];

  /* Here goes your home-manager config, eg home.packages = [ pkgs.foo ]; */
  programs.git = {
    enable = true;
    userName = "Ali Neishabouri";
  };

  programs.vim = {
    packageConfigurable = (
      (pkgs.vim_configurable.override {
        python = pkgs.python3;
        guiSupport = false;
      })
    );
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline vim-nix ];
    settings = { ignorecase = true; };
    extraConfig = ''
    '';
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
    initExtraBeforeCompInit = ''
      ZSH_DISABLE_COMPFIX=true
    '';
  };

  programs.ssh = {
    enable = true;
    compression = true;
  };
}

