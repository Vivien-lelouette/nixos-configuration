{ config, pkgs, ... }:
{  
  users.users.vivien = {
    packages = with pkgs; [
      ardour
      wineWowPackages.stable
      yabridge
      yabridgectl
      qjackctl
    ];
  };

  environment.systemPackages = with pkgs; [
    a2jmidid
    guitarix
    gxplugins-lv2
    lsp-plugins
    surge-XT
    cardinal
    mda_lv2
    x42-plugins
    fluidsynth
    soundfont-fluid
    sfizz
  ];
  environment.variables.LV2_PATH = "/run/current-system/sw/lib/lv2";

  security.pam.loginLimits = [
    { domain = "*"; item = "memlock"; type = "-"; value = "unlimited"; }
  ];
}
