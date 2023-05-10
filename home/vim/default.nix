{ pkgs, ... }:

{
  home-manager.users.chessai.programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withNodeJs = false;

    plugins = [
      pkgs.vimPlugins.haskell-vim
      pkgs.vimPlugins.vim-nix
    ];

    extraConfig = builtins.readFile ./vimrc;
  };
}
