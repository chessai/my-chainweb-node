{ pkgs, lib, ... }:

let
  exa = "${pkgs.exa}/bin/exa";
  bat = "${pkgs.bat}/bin/bat";
  rg = "${pkgs.ripgrep}/bin/rg";
in
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

      ls = "${exa} -G --color auto -a -s type";
      ll = "${exa} -l --color always -a -s type";
      cat = "${bat} -pp --theme=\"Nord\"";
      grep = rg;
      inherit rg;

      gc = "git clone git@github.com:\"$1\"/\"$2\"";
      gd = "git diff";
      gs = "git status";
    };

    initExtra = lib.mkBefore ''
      export LC_CTYPE="en_US.UTF-8";
      export EDITOR="nvim";
      export VISUAL="nvim";

      set -o vi
    '';
  };
}
