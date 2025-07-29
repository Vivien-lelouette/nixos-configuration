# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  virtualisation.docker.enable = true;
  users.users.vivien.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    slack
    # TODO remove when this issue is fixed : https://github.com/NixOS/nixpkgs/issues/330889
    # dbeaver-last.legacyPackages.x86_64-linux.pkgs.dbeaver-bin
    dbeaver-bin

    docker
    docker-compose
    rubyPackages_3_1.redis-client

    ruby

    python311Packages.pip

    eslint_d

    # LSPs
    emacs-lsp-booster
    sqls
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.eslint
    phpactor

    # vagrant
    rsync
 ];

  users.users.vivien.packages = with pkgs; [
    openvpn
    vscode
    nodejs_20
    redis
    postgresql
    pgformatter
    leiningen
    maven
  ];
}
