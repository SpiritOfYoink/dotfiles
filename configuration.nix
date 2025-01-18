{ config, pkgs, lib, inputs, outputs, home-manager, niri, ... }: {

imports = [    # You can import other NixOS modules here.
    ./hardware-configuration.nix
    ./modules/home-manager.nix
    ./modules/desktop.nix
    ./modules/variables.nix
    ];


#   ..... VARIABLES .....

let {    # Set these values in flakes.nix!
  user = config.modules.flake.user;
  fullname = config.modules.flake.fullname;
  hostname = config.modules.flake.hostname;
  # password = config.modules.flake.password;
  # rootpw = config.modules.flake.rootpw;
  system = config.modules.flake.system;
  device = config.modules.flake.device;
  github = config.modules.flake.github;
  };

in {


#   ..... BOOT SETTINGS .....

    boot.loader.systemd-boot.enable = true;       # Enables bootloader. DO NOT TOUCH.
    boot.loader.efi.canTouchEfiVariables = true;        # Allows bootloader to manage boot entries. DO NOT TOUCH.
    boot.loader.systemd-boot.configurationLimit = 10;        # Limits the number of previous configurations stored in the bootloader. Increase if you may need to go further back in time.
    boot.blacklistedKernelModules=["nouveau"];    # Prevents the open-source drivers from loading.


#   ..... DRIVERS & HARDWARE SUPPORT.....

    hardware = {
      graphics = {
        enable = true;    # Enables OpenGL.
        enable32Bit = true;   # Enables 32-bit drivers for 32-bit applications (such as Wine).
        driSupport = true;    # Enables Vulkan .
        driSupport32Bit = true; 
        }

      nvidia = {
        open = false;   # Uses the open-source modules (not drivers). Currently alpha-state and buggy.
        package = config.boot.kernelPackages.nvidiaPackages.beta;   # Use most recent Nvidia drivers.
        nvidiaSettings = true;    # Enables the nvidia settings menu.
        modesetting.enable = true;    # Modesetting is required.
        powerManagement.enable = false;   # Experimental and can cause sleep/suspend to fail. Enable if having crashes after wakie from sleep.
        powerManagement.finegrained = false;    # Turns off GPU when not in use. Do not enable.
        powerManagement.open = false;   # Disables open-source power management.
        prime.sync.enable = true;   # Enables G-Sync.
        }

      enableRedistributableFirmware = true;   # Enables firmware with a licence allowing redistribution.
      };

    #   ..... GNOME DISPLAY MANAGER - LOGIN .....
    services = {
      xserver = {   # Terrible name, but services.xserver is used for GUI-related commands.
        layout = "us"
        enable = true
        videoDrivers = ["nvidia"];   # Loads Nvidia driver for Xorg and Wayland.
        };
      displayManager = {
        gdm.enable = true
        autoLogin = {
          enable = true
          user = ${user} # Currently not accepting variables?
          };
        defaultSession = "niri";
        };
      };


    hardware.bluetooth.enable = true;       # Enables support for Bluetooth.
    hardware.bluetooth.powerOnBoot = true;      # Powers up the default Bluetooth controller on boot.
    services.printing.enable = true;    #Enables CUPS printing service.

    sound.enable = true;    # Configureation of audio using Pipewire.
      security.rtkit.enable = true;   # Handles audio scheduling priority.
      hardware.pulseaudio.enable = false;   # Disables the old PulseAudio drivers.
      services.pipewire = {   # Enables Pipewire audio drivers.
        enable = true;
        alsa.enable = true;   # Enables the ALSA sound API.
        alsa.Support32Bit = true;
        pulse.enable = true;    # Enables PulseAudio server *emulation.*
        };


#   ..... SYSTEM CONFIG .....

    nix.settings.experimental-features = [
      "nix-command"   # Enable the 'nix' terminal command.
      "flakes"  # Enable the Flakes versioning system.
      ];
      environment.systemPackages = with pkgs; [
      git     # Flakes clones its dependencies through the git command, so this must come first.
      ];

    services.dbus.enable = true; # Allows programs to communciate with each other.

    xdg.portal = {    # Gnome Toolkit portal needed to make gtk apps happy.
      enable = true
      wlr.enable = true
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      };

    nixpkgs.config.allowUnfree = true;        # Allows unfree packages.
    networking.networkmanager.enable = true;        # Enables networking.
    networking.firewall.extraCommands = ''iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns'';    # Tunes firewall to allow SMB sharing.
    security.polkit.enable = true;

    services.gnome.gnome-keyring.enable = false;   # Gnome secrets portal, required for some apps.
    security.pam.services.niri.enableGnomeKeyring = false; 

    time.timeZone = "America/Los_Angeles";      # Sets your time zone.
    i18n.defaultLocale = "en_US.UTF-8";     # Selects internationalisation properties.
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
        };
    
    services.xserver = {    # Sets keyboard region and layout.
      layout = "US";
      xkbVariant = "";
      };

    services.logind.extraConfig = ''*;
    HandlePowerKey=poweroff;
    '';      # Makes the power button shut down the computer.

    nix.gc {    # Enables garbage collection.
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than-15d";
      };
    
    nix.optimise.automatic = true;    # Optamises Nix store to reduce used space.
    nix.optimise.dates = [ "03:45" ]; # Optional; allows customizing optimisation schedule

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "24.11";      # Did you read the comment?

#   ..... NETWORKED STORAGE .....

    fileSystems."/mnt/nas-storage" = {    # Accesses network-attached storage.
      device = ${device};
      fsType = "cifs";
      options = [
        let
          automount_opts = "x-systemd.automount,noauto,user,users";
        in ["${automount_opts},credentials=/etc/nixos/secrets/smb-secrets,uid=1000,gid=100"];
        ];
      };

    services.gvfs.enable = true;    # Enables the GVFS daemon to allow GTK file-managers access to brouse samba shares.


#   ..... DESKTOP .....

    services.desktop.enable = true;   # For control of management programs, see desktop.nix


#   ..... USER SETUP .....

    networking.hostName = ${hostname};    # What the computer is called on your network.

    users.users.${user} = {   # Defines the user account.
        isNormalUser = true;
        description = ${fullname};
        extraGroups = [ "wheel"  "networkmanager"];
        initialPassword = "correcthorsebatterystaple";    # Be sure to change this to a secret when you get that set up.
    
    users.mutableUsers = false;   # Users and passwords cannot be changed ourside of this file.

    #users.users."${user}"".initialHashedPassword = mkOption { ${password}; };   # This is the user's password.
    #users.users."${user}".hashedPassword = config.users.users."${user}".initialHashedPassword;

    #users.users."root".initialHashedPassword = mkOption { ${rootpw}; };   # This is the root user's password.
    #users.users."root".hashedPassword = config.users.users."root".initialHashedPassword;
    };
    

#   ..... PROGRAMS .....

  services.adguardhome = {    #  --  Adguard ad blocker.
    enable = true;

    user =    # This information should come from my secrets file?
    password =

    openFirewall = true;
    settings = {    # Pull settings from the .config file for Adguard.
      bind_port = 8000;
      theme = dark
      dns.upstream_dns = [
        "9.9.9.9#dns.quad9.net"   # Filters malicious actors, and keeps zero IP logs.
        "149.112.112.112#dns.quad9.net"
        ];
      filtering = {
        protection_enabled = true;
        filtering_enabled = true;
        parental_enabled = false;   # Parental control-based DNS requests filtering.
        safe_search.enabled = false;    # Enforcing "Safe search" option for search engines, when possible.
          };
      filters = map(url: { enabled = true; url = url; }) [
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt"  # The Big List of Hacked Malware Web Sites
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt"  # malicious url blocklist
        ];
      };
    };

  programs = {    # *Most* programs are managed through home-manager. See home-manager.nix for the majority of programs.

    steam = {    # Steam  --  game launcher.
        enable = true;
        package = pkgs.steam.override.withJava = true;      # Allows for Java games.
        remotePlay.openFirewall = true;     # Open ports in the firewall for Steam Remote Play.
        dedicatedServer.openFirewall = true;        # Open ports in the firewall for Source Dedicated Server.
        localNetworkGameTransfers.openFirewall = true;      # Open ports in the firewall for Steam Local Network Game Transfers.
        };
          
    };

#   ..... END .....

  };    # Ends "Let-In" variables.
}   # Ends file.