{ config, pkgs, ... }:
{
  systemd.services."user@1000".serviceConfig.LimitNOFILE = "32768";
  security.pam.loginLimits = [
    { domain = "*"; item = "nofile"; type = "-"; value = "32768"; }
    { domain = "*"; item = "memlock"; type = "-"; value = "32768"; }
  ];
  
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
