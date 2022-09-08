{ config, pkgs, ... }:
{
  programs.steam.enable = true;
  users.users.vivien = {

    packages = with pkgs; [
      # Tools
      discord
      # Games launchers
      steam
      heroic
      lutris
    ];
  };
} 
