    { lib, ... }:{
    
    #   ..... VARIABLES .....    

      options.user = "yoink";     # What's your login?
      fullname = "The Spirit of Yoink!";      # What's the user called?
      hostname = "Ncase M2";      # What's the computer called?

      #password = mkOption {};        # What is the user's secret file?
      #rootpw = mkOption {};      # What is the root user's secret file?

      server = "//192.168.1.70/NAS_Storage";      # Where's your network storage attached? (SMB share.)
      github = "https://github.com/SpiritOfYoink/dotfiles";       # Change this to the github link for your repository.

      system = "x86_64-linux";        # This doesn't need to change unless you're using ARM or Apple silicon.
      pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";    # If 'system' changes, change this!
      lib = nixpkgs.lib;
      
    }