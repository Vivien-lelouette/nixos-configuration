# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  virtualisation.docker.enable = true;
  users.users.vivien.extraGroups = [ "docker" ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    python39Packages.pip
    dbeaver
    rubyPackages_3_1.redis-client
    slack

    # LSPs
    sqls
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.eslint
  ];

  users.users.vivien.packages = with pkgs; [
    openvpn
    vscode
    nodejs_20
    redis
    postgresql
    leiningen
    maven
  ];
}
