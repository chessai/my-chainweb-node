{ config, ... }:

let
  sshPort = 22;
  httpsPort = 443;
  p2pPort = config.services.chainweb-node.p2pPort;
in
{
  networking = {
    firewall = {
      enable = true;
      trustedInterfaces = [ ];
      allowedUDPPorts = [ ];
      allowedTCPPorts = [ sshPort httpsPort p2pPort ];
    };
  };
}
