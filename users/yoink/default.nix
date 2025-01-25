{ pkgs, lib, config, inputs, ... }: with lib;

  let
    user = "yoink";   # What's your login?
    fullname = "The Spirit of Yoink!";    # What's the user called?
    host = "Ncase M2";    # What's the computer called?

    lib = nixpkgs.lib;    # No need to change this.

    github = "https://github.com/SpiritOfYoink/dotfiles";   # Change this to the github link for your repository, if you clone this.
    server = "//192.168.1.70/NAS_Storage";    # Where's your network storage attached? (SMB share.)

    #password = ;        # What is the user's secret file?
    #rootpw = ;      # What is the root user's secret file?
  in {


#   ..... SUBMODULES .....
    imports = [   # You can import other NixOS modules here.
      etc/nixos/hardware-configuration.nix
      ../hosts/$<host>.nix
      ];


#   ..... MODULE OPTIONS .....

    nvidia-drivers.enable = true; 


#   ..... NETWORKED STORAGE .....

    services.gvfs.enable = true;    # Enables the GVFS daemon to allow GTK file-managers access to brouse samba shares.

      fileSystems."/mnt/nas-storage" = {
        device = "${server}";   # The target to connect to.
        fsType = "cifs";
        options = [
          "credentials=/home/${user}/hosts/${user}/secrets/smb-secrets"
          "x-systemd.automount"
          "x-systemd.requires=network-online.target"    # If you have issues because the target isn't there, remove this line and the next.
          "x-systemd.after=network-online.target"
          "x-systemd.idle-timeout=60"
          "x-systemd.device-timeout=5s"
          "x-systemd.mount-timeout=5s,"   # These lines prevent the system hanging if the target fails to reply.
          "rw" "uid=${user}" "gid=1000"    # Sends the user's name and group.
          "vers=3.02"
            ]; };


#   ..... HOME MANAGER .....


#   ..... USER SETUP .....

    networking.hostName = "${host}";    # What the computer is called on your network.

    users.users."${user}" = {   # Defines the user account.
        isNormalUser = true;
        description = "${fullname}";
        extraGroups = [ "wheel"  "networkmanager"];
        initialPassword = "correcthorsebatterystaple";    # TODO: Be sure to change this to the secrets below, when you get that set up.

    #users.users."${user}"".HashedPassword = mkOption { "/home/${user}/hosts/${user}/secrets/user-secrets" };   # This is the user's password.
    #users.users."root".HashedPassword = mkOption { "/home/${user}/hosts/${user}/secrets/root-secrets"; };   # This is the root user's password.

    users.mutableUsers = false;   # Users and passwords cannot be changed ourside of this file.
    };




users.users.${user}.isNormalUser = true;
home-manager.users.${user} = { pkgs, ... }: {




  environment.systemPackages = [
      pkgs.home-manager
      ];
  home.packages = [
    protonup
     ];
  programs.bash.enable = true;
  home.stateVersion = "24.11"; # The state version is required, and should stay at the version you originally installed.
  };

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\\\${HOME}/.steam/root/compatibilitytools.d";
    };



          yoink = home-manager.lib.homeManagerConfiguration {   # THE SPIRIT OF YOINK
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          specialArgs = { inherit inputs; };   # Allows modules access to flake inputs.
          extraSpecialArgs = { inherit inputs; };   # Allows home-manager modules access to flake inputs.
          config = { allowUnfree = true; };
          modules = [ ./users/yoink ];
          };


      homeConfigurations.home-manager.lib.homeManagerConfiguration {   # THE SPIRIT OF YOINK
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          specialArgs = { inherit inputs; };   # Allows modules access to flake inputs.
          extraSpecialArgs = { inherit inputs; };   # Allows home-manager modules access to flake inputs.
          config = { allowUnfree = true; };
          modules = [ ./users/yoink ];
          };

    home.username = "${user}";
    home.homeDirectory = "/home/${user}/dotfiles/modules/home-manager";
    home.stateVersion = "24.11";    # This is used for backwards compatiblity. Don't change this.
    programs.home-manager.enable = true;    # Let Home Manager install and manage itself.

    wallpaper = 



#   ..... BOILERPLATE .....


}   # End of file.