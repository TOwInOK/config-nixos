{ ... }: {
  programs.git = {
    enable = true;
    userName = "towinok";
    userEmail = "60252419+TOwInOK@users.noreply.github.com";

    extraConfig = {
      init.defaultBranch = "main"; # no master.
      pull.rebase = false;
      push.default = "simple";
      # core.editor = "zed"; 
    };

    aliases = {
      co = "checkout";
      br = "branch";
      ci = "commit";
      st = "status";
      lg = "log --oneline --graph --decorate";
    };
  };
}
