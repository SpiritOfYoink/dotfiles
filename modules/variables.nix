{ nixos-hardware, ... }:
{lib, ... }:

#   ..... VARIABLES .....

    variables = {       # Change these to reflect your own system.

        user = "yoink";     # What's your login?
        fullname = "The Spirit of Yoink!";      # What's the user called?
        hostname = "Ncase M2";      # What's the computer called?

        #password = mkOption {};        # What is the user's secret file?
        #rootpw = mkOption {};      # What is the root user's secret file?

        system = "x86_64-linux";        # This doesn't need to change unless you're using ARM or Apple silicon.
        device = "//192.168.1.70/NAS_Storage";      # Where's your network storage attached? (SMB share.)
        github = "git@github.com:user/repo#flakename"       # Change this to the github link for your repository.
    };