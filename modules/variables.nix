    { lib, ... }:{
    
    #   ..... VARIABLES .....    

      options.user = "yoink";     # What's your login?
      options.fullname = "The Spirit of Yoink!";      # What's the user called?
      options.hostname = "Ncase M2";      # What's the computer called?

      #options.password = mkOption {};        # What is the user's secret file?
      #options.rootpw = mkOption {};      # What is the root user's secret file?

      options.server = "//192.168.1.70/NAS_Storage";      # Where's your network storage attached? (SMB share.)
      options.github = "https://github.com/SpiritOfYoink/dotfiles";       # Change this to the github link for your repository.

      options.system = "x86_64-linux";        # This doesn't need to change unless you're using ARM or Apple silicon.
      options.pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";    # If 'system' changes, change this!
      options.lib = nixpkgs.lib;

    }