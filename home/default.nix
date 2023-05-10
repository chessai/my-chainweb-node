{ config, pkgs, lib, ... }:

{
  imports = [
    ./bash
    ./git
    ./jq
    ./ssh
    ./vim
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  home-manager.users.chessai = {
    nixpkgs.config = {
      allowUnfree = true;
    };

    # fails to build on upgrades sometimes
    manual.manpages.enable = false;

    home.stateVersion = "22.11";

    home.packages = [
      pkgs.gist
      pkgs.nix-prefetch-git
      pkgs.silver-searcher
      pkgs.rsync
      pkgs.tcpdump
      pkgs.tree
      pkgs.wget
    ];
  };
}
