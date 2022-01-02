{ config, pkgs, ... }:
{
  /* Here goes your home-manager config, eg home.packages = [ pkgs.foo ]; */
  programs.git = {
    enable = true;
    userName = "Ali Neishabouri";
    userEmail = "ali.neishabouri@theactigraph.com";
  };

  programs.vim = {
    packageConfigurable = ((pkgs.vim_configurable.override { python = pkgs.python3; guiSupport = false; }));
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline vim-nix ];
    settings = { ignorecase = true; };
    extraConfig = ''
    '';
  };

  imports = [
    "${fetchTarball {url="https://github.com/msteen/nixos-vscode-server/tarball/master"; sha256="00aqwrr6bgvkz9bminval7waxjamb792c0bz894ap8ciqawkdgxp";}}/modules/vscode-server/home.nix"
  ];

  services.vscode-server.enable = true;
}

