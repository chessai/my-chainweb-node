{
  home-manager.users.chessai.programs.ssh = {
    enable = true;

    serverAliveInterval = 20;
    serverAliveCountMax = 6;

    extraConfig = ''
    '';
  };
}
