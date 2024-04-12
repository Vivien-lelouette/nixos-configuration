# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, self, ... }:
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
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true; # enable the graphical frontend
  security.pam.services.gdm.enableGnomeKeyring = true;
  security.pam.services.hyprlock = { };

  # Enable the KDE Plasma Desktop Environment.
  # services.desktopManager.plasma6.enable = true;

  programs = {
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
    };
    waybar = {
      enable = true;
      package = pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
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

  services.pipewire.wireplumber.configPackages = [
          (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/10-bluez.conf" ''
            monitor.bluez.properties = {
              bluez5.roles = [ a2dp_sink a2dp_source bap_sink bap_source hsp_hs hsp_ag hfp_hf hfp_ag ]
              bluez5.headset-roles = [ hsp_hs hsp_ag hfp_hf hfp_ag ]
              bluez5.codecs = [ sbc sbc_xq aac ]
              bluez5.enable-sbc-xq = true
              bluez5.enable-msbc = true
              bluez5.enable-hw-volume = true
              bluez5.hfphsp-backend = "native"
            }
          '')
        ];

  #   {
	#   "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
	# 	bluez_monitor.properties = {
	# 		["bluez5.enable-sbc-xq"] = true,
	# 		["bluez5.enable-msbc"] = true,
	# 		["bluez5.enable-hw-volume"] = true,
	# 		["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
	# 	                                                }
	# '';
  # };

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
      rev = "5d0a10938c32f3cb95d1f1f18127948d239c6720"; # change the revision
    }
    ))
    (
      self: super:
      {
        emacs-git-gtk =
            super.emacs-git.override {
              withX = false;
              withGTK3 = true;
              withWebP = true;
              withPgtk = true;
            };
      }
    )
    (
      self: super:
      {
        appmenu-gtk3-module = super.callPackage ../packages/appmenu-gtk3-module {}; # path containing default.nix
      }
    )
  ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.8"
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
     emacs-git-gtk
     fish
     dracula-theme
     openjdk
     python2
     python310
     pywal
     wpgtk
     xdotool
     keyd
     warpd

     pkgs.libsecret
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
     nyxt
     libsForQt5.polonium

     alacritty
     polkit_gnome
     libva-utils
     fuseiso
     udiskie
     gnome.adwaita-icon-theme
     gnome.gnome-themes-extra
     gsettings-desktop-schemas
     swaynotificationcenter
     wlr-randr
     ydotool

     wl-clipboard
     jq
     hyprland-protocols
     hyprpicker
     hypridle
     hyprlock
     hyprpaper

     wofi

     slurp
     grim
     swappy
     wf-recorder

     xdg-utils
     xdg-desktop-portal
     xdg-desktop-portal-gtk
     xdg-desktop-portal-hyprland
     qt5.qtwayland
     qt6.qmake
     qt6.qtwayland
     adwaita-qt
     adwaita-qt6
     networkmanagerapplet
  ];

  environment.sessionVariables = {
    POLKIT_AUTH_AGENT = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
    XDG_SESSION_TYPE = "wayland";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    WLR_RENDERER = "vulkan";
    CLUTTER_BACKEND = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    GTK_USE_PORTAL = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
  }; 

  services.pcscd.enable = true;
  programs.gnupg.agent = {
     enable = true;
     # pinentryPackage = pkgs.pinentry-qt;
     enableSSHSupport = true;
  };
  
  # Give EXWM permission to control the session and start keyd
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xhost}/bin/xhost +SI:localuser:$USER
  '';

  # Allow /etc/hosts changes
  environment.etc.hosts.mode = "0644";

  programs.nix-ld.enable = true;

  ## If needed, you can add missing libraries here. nix-index-database is your friend to
  ## find the name of the package from the error message:
  ## https://github.com/nix-community/nix-index-database
   programs.nix-ld.libraries = with pkgs; [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    curl
    dbus
    expat
    fontconfig
    freetype
    fuse3
    gdk-pixbuf
    glib
    gtk3
    icu
    libGL
    libappindicator-gtk3
    libdrm
    libglvnd
    libnotify
    libpulseaudio
    libunwind
    libusb1
    libuuid
    libxkbcommon
    libxml2
    mesa
    nspr
    nss
    openssl
    pango
    pipewire
    stdenv.cc.cc
    systemd
    vulkan-loader
    xorg.libX11
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libxcb
    xorg.libxkbfile
    xorg.libxshmfence
    zlib
  ];
}
