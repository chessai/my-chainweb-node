std:

{ pkgs, ... }:

let
  users = {
    chessai = std.list.map import [
      ./bash
      ./git
      ./jq
      ./ssh
      (./vim { inherit (pkgs) vimPlugins; })
    ];
  };

  mkHomeUser = name: imports: {
    home-manager.users."${name}" = std.
      inherit (  
    };
  };
in
{
  home-manager.users.
}
