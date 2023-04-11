# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  virtualisation.docker.enable = true;
  users.users.vivien.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    python39Packages.pip
    dbeaver
    rubyPackages_3_1.redis-client

    # LSPs
    sqls
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.eslint
  ];

  users.users.vivien.packages = with pkgs; [
    openvpn
    vscode
    nodejs-16_x
    redis
    postgresql
    leiningen
    maven
  ];
}
