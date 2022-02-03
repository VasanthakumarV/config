{ ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      env = { "TERM" = "xterm-256color"; };
      font = {
        size = 11.0;
        normal = {
          family = "Iosevka Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "Iosevka Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "Iosevka Nerd Font";
          style = "Italic";
        };
      };
      colors = {
        primary = {
          background = "#2D2A2E";
          foreground = "#FCFCFA";
        };
        normal = {
          black = "#403E41";
          red = "#FF6188";
          green = "#A9DC76";
          yellow = "#FFD866";
          blue = "#FC9867";
          magenta = "#AB9DF2";
          cyan = "#78DCE8";
          white = "#FCFCFA";
        };
        bright = {
          black = "#727072";
          red = "#FF6188";
          green = "#A9DC76";
          yellow = "#FFD866";
          blue = "#FC9867";
          magenta = "#AB9DF2";
          cyan = "#78DCE8";
          white = "#FCFCFA";
        };
      };
      key_bindings = [
        {
          key = "H";
          mods = "Alt";
          chars = "\\x1bh";
        }
        {
          key = "J";
          mods = "Alt";
          chars = "\\x1bj";
        }
        {
          key = "K";
          mods = "Alt";
          chars = "\\x1bK";
        }
        {
          key = "L";
          mods = "Alt";
          chars = "\\x1bl";
        }
      ];
    };
  };
}
