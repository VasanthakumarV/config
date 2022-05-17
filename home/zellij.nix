{ ... }: {
  programs.zellij = {
    enable = true;
    settings = {
      pane_frames = false;
      simplified_ui = true;
    };
  };
}
