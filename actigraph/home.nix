{ config, pkgs, ... }:
{
  imports = [ ../common/home.nix ];

  home.packages = [
  ];

  home.sessionVariables = {
    BUILD_PREFIX="/tmp";
  };

  programs.git = {
    userEmail = "ali.neishabouri@theactigraph.com";
    lfs.enable = true;
  };

  programs.zsh.initExtra = ''
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

    eval "$(/opt/homebrew/bin/brew shellenv)"
  '';

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
    "*azure.com" =
      {
        user = "azureuser";
        identityFile = "~/.ssh/id_azure";
      };
    "vm" =
      {
        hostname = "192.168.64.2";
        user = "rouzbeh";
        identityFile = "~/.ssh/id_ed25519";
      };
  };
}

