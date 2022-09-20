{ config, pkgs, ... }:
{  
  users.users.vivien = {
    packages = with pkgs; [
      ardour
      guitarix
      wineWowPackages.stable
      yabridge
      yabridgectl
      qjackctl
    ];
  };

  environment.systemPackages = with pkgs; [
    gxplugins-lv2
  ];
  environment.variables.LV2_PATH = "/run/current-system/sw/lib/lv2";

  security.pam.loginLimits = [
    { domain = "*"; item = "memlock"; type = "-"; value = "unlimited"; }
  ];
} 
