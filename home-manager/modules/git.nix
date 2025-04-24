{
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
      ch = "checkout";
      b = "branch";
      c = "commit";
      s = "status";
      lg = "log --oneline --graph --decorate";
    };
  };
}
