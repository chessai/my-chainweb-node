{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.sqlite
    pkgs.sysstat
  ];
}
