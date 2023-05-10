{ lib, ... }:

{
  home-manager.users.chessai.programs.bash = {
    enable = true;

    historySize = 10000;
    historyFileSize = 50000;

    historyControl = [ "ignoredups" ];
    historyIgnore = [ "ls" "cd" "exit" ];

    shellAliases = {
      ".0" = "cd .";
      ".1" = "cd ..";
      ".2" = "cd ../..";
      ".3" = "cd ../../..";
      ".4" = "cd ../../../..";
    };

    initExtra = lib.mkBefore ''
      export LC_CTYPE="en_US.UTF-8";

      set -o vi
    '';
  };
}
