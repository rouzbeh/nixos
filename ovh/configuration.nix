{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./common/configuration.nix
  ];

  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;

  users.users.rouzbeh = {
    isNormalUser = true;
    home = "/home/rouzbeh";
    description = "Ali";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKJmsbjo48XbCi8lLWxmebX/8By15nxTV5xXS4+ODU08 SurfaceBook2" ];
  };

  services.fail2ban.enable = true;

  # enable NAT
  networking.nat.enable = true;
  networking.nat.externalInterface = "ens3";
  networking.nat.internalInterfaces = [ "wg0" ];
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };

  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = [ "10.0.0.1/24" ];

      # The port that WireGuard listens to. Must be accessible by the client.
      listenPort = 51820;

      # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
      # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
      postSetup = [
        "${pkgs.iptables}/bin/iptables -A FORWARD -i %i -j ACCEPT"
        "${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -o ens3 -j MASQUERADE"
        "${pkgs.iptables}/bin/iptables -A FORWARD -o %i -j ACCEPT"
      ];

      # This undoes the above command
      postShutdown = [
        "${pkgs.iptables}/bin/iptables -D FORWARD -i %i -j ACCEPT"
        "${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -o ens3 -j MASQUERADE"
        "${pkgs.iptables}/bin/iptables -D FORWARD -o %i -j ACCEPT"
      ];

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = "/home/rouzbeh/wg_private";

      peers = [
        # List of allowed peers.
        {
          # Ali
          publicKey = "mxHtvEtEs9seVNPIy48yXrrDAx7FZnqNYOcaLb1XNCs=";
          allowedIPs = [ "10.0.0.2/32" ];
        }
        {
          # Pedro
          publicKey = "YUnY6U6wP+U6o+7BpVvahOiJD7AH4HgfveQ0Rx9a03w=";
          allowedIPs = [ "10.0.0.3/32" ];
        }
        {
          # Anastasia
          publicKey = "POl6eZdIevWBd7iY1mfzpCaLxkNI3cnbFBQyroI5hFs=";
          allowedIPs = [ "10.0.0.4/32" ];
        }
        {
          # Will
          publicKey = "pcldPJfHUqk1YfPXwtUXXZq5opVjE/lxoGiXMX5/9Qk=";
          allowedIPs = [ "10.0.0.5/32" ];
        }
        {
          # iPhone
          publicKey = "m29b2Nuta2LAe0HjvRgxR6lWCAJURmsVKmpGmkUOiX0=";
          allowedIPs = [ "10.0.0.6/32" ];
        }
      ];
    };
  };

}
