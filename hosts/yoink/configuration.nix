{ pkgs, lib, config, ... }: with lib;

  let
    user = "yoink";   # What's your login?
    fullname = "The Spirit of Yoink!";    # What's the user called?
    host = "Ncase M2";    # What's the computer called?

    pkgs = nixpkgs.legacyPackages."x86_64-linux";   # If 'system' changes, change this!
    lib = nixpkgs.lib;    # No need to change this.

    github = "https://github.com/SpiritOfYoink/dotfiles";   # Change this to the github link for your repository, if you clone this.
    server = "//192.168.1.70/NAS_Storage";    # Where's your network storage attached? (SMB share.)

    #password = ;        # What is the user's secret file?
    #rootpw = ;      # What is the root user's secret file?
  in {

#   ..... SUBMODULES .....
    imports = [   # You can import other NixOS modules here.
      ./hardware-configuration.nix
      ../../modules
      ];

#   ..... CONFIG .....

    environment.sessionVariables = {
      NIX_PATH = "/home/dotfiles/${user}/configuration.nix";
      };
    
    nixpkgs.config.allowUnfree = true;
    nvidia-drivers.enable = true;
    programs.gamemode.enable = true;    # TODO: See if this needs more setting up.

    nix = {
      settings.experimental-features = ["nix-command flakes"];   # Enables the Flakes update system command in conjunction with a rebuild.
      environment.systemPackages = with pkgs; [ git ];    # Flakes clones its dependencies through the git command, so it must be at the top of the list.
      checkConfig = true;
      checkAllErrors = true;
      };

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

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";    # Did you read the comment?


#   ..... NETWORKED STORAGE .....

  services.gvfs.enable = true;    # Enables the GVFS daemon to allow GTK file-managers access to brouse samba shares.

    fileSystems."/mnt/nas-storage" = {
      device = "//<LOCALSHAREIP>/<MACHINECODENAME>";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,uid=<CLIENTMACHINEUSER>";   # this line prevents hanging on network split.

        in ["${automount_opts},credentials=/home/${user}/hosts/${user}/secrets/smb-secrets"];
        };


#   ..... USER SETUP .....

  networking.hostName = ${host};    # What the computer is called on your network.

  users.users.${user} = {   # Defines the user account.
      isNormalUser = true;
      description = ${fullname};
      extraGroups = [ "wheel"  "networkmanager"];
      initialPassword = "correcthorsebatterystaple";    # TODO: Be sure to change this to the secrets below, when you get that set up.

  #users.users."${user}"".HashedPassword = mkOption { ${password}; };   # This is the user's password.
  #users.users."root".HashedPassword = mkOption { ${rootpw}; };   # This is the root user's password.

  users.mutableUsers = false;   # Users and passwords cannot be changed ourside of this file.
  };
    






#   ..... PROGRAMS .....


programs = {    # *Most* programs are managed through home-manager. See home-manager.nix for the majority of programs.

  steam = {   # Steam
      enable = true;
      package = pkgs.steam.override.withJava = true;    # Allows for Java games.

      remotePlay.openFirewall = true;   # Open ports in the firewall for Steam Remote Play.
      localNetworkGameTransfers.openFirewall = true;    # Open ports in the firewall for Steam Local Network Game Transfers.
      extest.enable = true;   # Translates X11 input events to uinput events. (For using Steam Input on Wayland.)
      extraPackages = with pkgs; [ gamescope ];   # Valve's microcompositor to allow games to run in an isolated enviroment.
      gamescopeSession.enable = true;
      


      };
  gamescope.enable = true;    # TODO: I don't know if I need this or if the extraPackages in steam is fine. 


  };

#   ..... END .....

}