{ config, pkgs, ... }:
{
  users.users.vivien = {

    packages = with pkgs; [
      ardour
      guitarix
      yabridge
    ];
  };
} 
