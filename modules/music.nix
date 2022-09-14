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

  environment.systemPackages = with pkgs; [
    gxplugins-lv2
  ];
  environment.variables.LV2_PATH = "/run/current-system/sw/lib/lv2";
} 
