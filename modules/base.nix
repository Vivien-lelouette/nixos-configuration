# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, self, inputs, ... }:
{
  imports =
    [
      # User files
      ./user.nix
      # ./virtualization.nix
    ];

  nix = {
     package = pkgs.nixVersions.stable;
     extraOptions = 
       ''experimental-features = nix-command flakes'';
  }; 

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
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
    river = {
      enable = true;
      xwayland = {
        enable = true;
      };
    };
    hyprlock = {
      enable = true;
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };
  
  services.hypridle.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
  xdg.portal.xdgOpenUsePortal = true;
  
  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

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

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 1701 9001 ];
    allowedUDPPorts = [ 1701 9001 ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  # Necessary for GTK themes
  programs.dconf.enable = true;


  nixpkgs.overlays = [
    (import (builtins.fetchGit {
      url = "https://github.com/nix-community/emacs-overlay.git";
      ref = "master";
      rev = "2df626665bf05449f81db5a6b4e8196030e88a86"; # change the revision
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
  ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.8"
    "electron-27.3.11"
  ];

  # zen browser 1password support
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
          .zen-wrapped
        '';
      mode = "0755";
    };
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     plocate
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
     python311
     pywal
     wpgtk
     xdotool
     keyd
     w3m
     links2
     lynx
     waybar
     
     sshpass

     texlive.combined.scheme-full

     # thunderbird

     pkg-config

     enchant
     hunspell
     hunspellDicts.fr-any
     hunspellDicts.en_US
     emacsPackages.jinx

     logseq

     pkgs.libsecret
     gnupg
     pinentry
     pinentry-gnome3
     
     file
     zlib
     patchelf
     groff
     gnumake
     simple-scan

     pipx

     google-chrome
     inputs.zen-browser.packages.${pkgs.system}.default
     
     filezilla

     appimage-run
     gparted
     writedisk
     zip
     vlc

     d2

     alacritty
     polkit_gnome
     libva-utils
     fuseiso
     udiskie
     adwaita-icon-theme
     gnome-themes-extra
     gsettings-desktop-schemas
     ydotool

     glib

     bc
     ripgrep
     jq
     yq
     
     hyprpicker
     hyprpaper
     rose-pine-cursor

     wofi

     slurp
     grim
     swappy
     wf-recorder
     xfce.tumbler
     xfce.ristretto
     shutter

     qt5.qtwayland
     qt6.qmake
     qt6.qtwayland
     adwaita-qt
     adwaita-qt6
     networkmanagerapplet

     xdg-desktop-portal-gtk
     xdg-desktop-portal-wlr
     
     way-displays
     wideriver

     pavucontrol
  ];

  services.dbus.enable = true;

  environment.sessionVariables = {
    POLKIT_AUTH_AGENT = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    CLUTTER_BACKEND = "wayland";
    XKB_DEFAULT_OPTIONS = "compose:caps";
  };
  
  services.pcscd.enable = true;
  programs.gnupg.agent = {
     enable = true;
     pinentryPackage = pkgs.pinentry-gnome3;
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
    pwvucontrol

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
