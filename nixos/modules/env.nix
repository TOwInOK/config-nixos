{
  environment.sessionVariables = rec {
    TERMINAL = "ghostty";
    EDITOR = "zed";
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];
  };
}
