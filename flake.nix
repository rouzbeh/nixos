{
  # Description, write anything or even nothing
  description = "Ali's NixOS Flake";

  # Input config, or package repos
  inputs = {
    # Nixpkgs, NixOS's official repo
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  # Output config, or config for NixOS system
  outputs = { self, home-manager, nixpkgs, ... }@inputs: {
    # Define a system called "nixos"
    nixosConfigurations."sf2wsl" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./wsl/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nixos = import ./common/home.nix;
        }
      ];
    };


    nixosConfigurations."vps-c2eff6bc" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./ovh/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.rouzbeh = import ./ovh/home.nix;
        }
      ];
    };

    nixosConfigurations."vm" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./vm/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.rouzbeh = import ./actigraph/home.nix;
        }
      ];
    };
    # You can define many systems in one Flake file.
    # NixOS will choose one based on your hostname.
    #
    # nixosConfigurations."nixos2" = nixpkgs.lib.nixosSystem {
    #   system = "x86_64-linux";
    #   modules = [
    #     ./configuration2.nix
    #   ];
    # };
  };
}
