{ config, pkgs, ... }:
{
  programs.steam.enable = true;

  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
      userServices = true;
    };
  };

  environment.systemPackages = with pkgs; [
    sunshine
  ];

  security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+p";
    source = "${pkgs.sunshine}/bin/sunshine"; 
  };

  systemd.user.services.sunshine = {
    description = "sunshine";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${config.security.wrapperDir}/sunshine";
    }; 
  };

  networking.firewall.allowedTCPPortRanges = [
    { from = 47984; to = 47984; }
    { from = 47989; to = 47990; }
    { from = 48010; to = 48010; }
  ];
  networking.firewall.allowedUDPPortRanges = [
    { from = 47890; to = 47890; }
    { from = 47998; to = 47999; }
    { from = 48000; to = 48000; }
    { from = 48010; to = 48010; }
  ];

  users.users.vivien = {

    packages = with pkgs; [
      # Tools
      discord
      # Games launchers
      steam
      heroic
      lutris
      yuzu-early-access
      qbittorrent
    ];
  };
} 
