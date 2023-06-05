# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [
      # User files
      ./user.nix
      ./virtualization.nix
    ];

  nix = {
     package = pkgs.nixFlakes;
     extraOptions = 
       ''experimental-features = nix-command flakes'';
  }; 

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.utf8";
    LC_IDENTIFICATION = "fr_FR.utf8";
    LC_MEASUREMENT = "fr_FR.utf8";
    LC_MONETARY = "fr_FR.utf8";
    LC_NAME = "fr_FR.utf8";
    LC_NUMERIC = "fr_FR.utf8";
    LC_PAPER = "fr_FR.utf8";
    LC_TELEPHONE = "fr_FR.utf8";
    LC_TIME = "fr_FR.utf8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable scanner support
  users.users.vivien.extraGroups = [ "scanner" "lp" ];
  hardware = {
    sane = {
      enable = true;
      brscan4 = {
        enable = true;
      };
    };
  };
  
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  environment.etc = {
	  "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
		bluez_monitor.properties = {
			["bluez5.enable-sbc-xq"] = true,
			["bluez5.enable-msbc"] = true,
			["bluez5.enable-hw-volume"] = true,
			["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
		                                                }
	'';
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  # Necessary for GTK themes
  programs.dconf.enable = true;


  nixpkgs.overlays = [
    (import (builtins.fetchGit {
      url = "https://github.com/nix-community/emacs-overlay.git";
      ref = "master";
      rev = "1195f952f1d610244a4b1b8b0b9dbd13ef6d553c"; # change the revision
    }
    ))
    (
      self: super:
      {
        emacsGit-gtk =
            super.emacsGit.override {
              withX = true;
              withGTK3 = true;
              withWebP = true;
            };
      }
    )
    # (
    #   self: super:
    #   {
    #     appmenu-gtk3-module = super.callPackage ../packages/appmenu-gtk3-module {}; # path containing default.nix
    #   }
    # )
  ];

  hardware.bluetooth.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.6"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     git
     stow
     gcc
     glibc
     sqlite
     emacsGit-gtk
     fish
     materia-kde-theme
     materia-theme
     dracula-theme
     openjdk
     python2
     python310
     pywal
     wpgtk
     xdotool
     keyd
     warpd
     unclutter
     gnupg
     pinentry
     pinentry-qt
     file
     zlib
     patchelf
     groff
     gnumake
     simple-scan
     offlineimap
     mu
     python310Packages.pipx
     google-chrome
     firefox
     appimage-run
     gparted
     writedisk
     zip
     vlc
     find-cursor
  ];

  services.unclutter.enable = false;

  services.pcscd.enable = true;
  programs.gnupg.agent = {
     enable = true;
     pinentryFlavor = "qt";
     enableSSHSupport = true;
  };
  
  # Give EXWM permission to control the session and start keyd
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xhost}/bin/xhost +SI:localuser:$USER
  '';

  # Allow /etc/hosts changes
  environment.etc.hosts.mode = "0644";
}
