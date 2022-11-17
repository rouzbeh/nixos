{ config, pkgs, ... }:
{
  imports = [ ../common/home.nix ];

  home.packages =
    let my-R = pkgs.rWrapper.override { packages = with pkgs.rPackages; [ ggplot2 GGIR ]; };
    in
    [
    ];

  home.sessionVariables = {
    BUILD_PREFIX = "/tmp";
    FC = "/Users/ali.neishabouri/.local/homebrew/bin/gfortran"; 
    #CC = "/Users/ali.neishabouri/.local/homebrew/bin/gcc-12"; 
    #CXX = "/Users/ali.neishabouri/.local/homebrew/bin/g++-12"; 
    #PKG_CONFIG = "/Users/ali.neishabouri/.local/homebrew/bin/pkg-config";
    #HDF5_DIR = "/Users/ali.neishabouri/.local/homebrew/opt/hdf5";
    #BLOSC = "/Users/ali.neishabouri/.local/homebrew/opt/c-blosc";
    #LDFLAGS = "-L/Users/ali.neishabouri/.local/homebrew/opt/libomp/lib";
    #CPPFLAGS = "-I/Users/ali.neishabouri/.local/homebrew/opt/libomp/include";
  };

  programs.git = {
    userEmail = "ali.neishabouri@theactigraph.com";
    lfs.enable = true;
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      brew = "~/.local/homebrew/bin/brew";
      az = "~/.local/homebrew/bin/az";
      pyw = "cd ~/workspace/pywear && conda activate actihealth";
      #poetry = "~/.local/homebrew/bin/poetry";
      cpuinfo = "~/.local/homebrew/bin/cpuinfo";
      #pip = "~/.local/homebrew/bin/pip";
      #ninja = "~/.local/homebrew/bin/ninja";
      #cmake = "~/.local/homebrew/bin/cmake";
      #tar = "~/.local/homebrew/bin/gtar";
    };

    initExtra = ''
      # Nix
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
      # End Nix
      # >>> conda initialize >>>
      # !! Contents within this block are managed by 'conda init' !!
      __conda_setup="$('/Users/ali.neishabouri/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
      if [ $? -eq 0 ]; then
          eval "$__conda_setup"
      else
          if [ -f "/Users/ali.neishabouri/miniconda3/etc/profile.d/conda.sh" ]; then
              . "/Users/ali.neishabouri/miniconda3/etc/profile.d/conda.sh"
          else
              export PATH="/Users/ali.neishabouri/miniconda3/bin:$PATH"
          fi
      fi
      unset __conda_setup
      # <<< conda initialize <<<
    '';
  };

  programs.ssh.matchBlocks = {
    "github" =
      {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };
    "github_runner" =
      {
        hostname = "52.179.23.50";
        user = "actigraph";
        identityFile = "~/.ssh/id_azure";
      };
    "dss" =
      {
        hostname = "dssactgraph.westeurope.cloudapp.azure.com";
        user = "azureuser";
        identityFile = "~/.ssh/id_azure";
      };
    "processor" =
      {
        hostname = "20.85.211.30";
        user = "azureuser";
        identityFile = "~/.ssh/id_azure";
      };
    "vm" =
      {
        hostname = "192.168.64.2";
        user = "rouzbeh";
        identityFile = "~/.ssh/id_ed25519";
      };
    "ovh" =
      {
        hostname = "51.89.164.51";
        user = "rouzbeh";
        identityFile = "~/.ssh/id_ed25519";
      };
    "pi" =
      {
        hostname = "192.168.1.2";
        user = "pi";
        identityFile = "~/.ssh/id_ed25519";
      };
  };
}

