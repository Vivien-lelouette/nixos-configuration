{ config, pkgs, ... }:
{
  boot.kernelModules = [ "vfio-pci" ];
  boot.kernelParams = [
    "kvm.ignore_msrs=1"
    "kvm.report_ignored_msrs=0"
    # "transparent_hugepage=never"
  ];

  # Enable virtualization
  # full setup here : https://nixos.wiki/wiki/Virt-manager
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
  }; 
  virtualisation.libvirtd.qemu.ovmf.enable = true;
  virtualisation.libvirtd.qemu.runAsRoot = true;
  programs.dconf.enable = true;

  systemd.services.libvirtd = {
    # scripts use binaries from these packages
    # NOTE: All these hooks are run with root privileges... Be careful!
    path =
      let
        env = pkgs.buildEnv {
          name = "qemu-hook-env";
          paths = with pkgs; [
            libvirt
            procps
            utillinux
            doas
            config.boot.kernelPackages.cpupower
            zfs
            ripgrep
            killall
            pciutils
          ];
        };
      in
      [ env ];
  };

  systemd.services.libvirt-nosleep =
    { description = "Preventing sleep while libvirt domain is running";
      serviceConfig = {
        Type = "simple";
        ExecStart = "systemd-inhibit --what=sleep --why='Libvirt domain is running' --who=%U --mode=block sleep infinity";
      };
    };

  systemd.services.pcscd.enable = false;
  systemd.sockets.pcscd.enable = false;

  environment.systemPackages = with pkgs; [
     virt-manager
     pciutils
  ];

  users.users.vivien = {
    extraGroups = [
      "libvirtd"
    ];
  };
}
