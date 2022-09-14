{ config, pkgs, ... }:
{
  users.users.vivien = {

    packages = with pkgs; [
      ardour
      guitarix
      wineWowPackages.stable
      yabridge
      yabridgectl
    ];
  };
} 
