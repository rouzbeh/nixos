{ config, pkgs, ... }: {
  home.stateVersion = "22.05";
  home.packages = [
    pkgs.unzip
    pkgs.p7zip
    pkgs.nixpkgs-fmt
    pkgs.graphviz
    pkgs.htop
    pkgs.gh
    (pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-medium enumitem lastpage latexindent beamer wrapfig capt-of
        adjustbox titling collectbox upquote environ tcolorbox;
    })
  ];

  # Here goes your home-manager config, eg home.packages = [ pkgs.foo ];
  programs.git = {
    enable = true;
    userName = "Ali Neishabouri";
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "vi-mode" ];
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

