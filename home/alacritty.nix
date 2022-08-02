{ ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      env = { "TERM" = "xterm-256color"; };
      font = {
        size = 12.0;
        # offset = { y = 6.0; };
        normal = {
          family = "Hasklug Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "Hasklug Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "Hasklug Nerd Font";
          style = "Italic";
        };
      };
      colors = {
        primary = {
          background = "#192330";
          foreground = "#d6d6d7";
        };
        normal = {
          black = "#393b44";
          red = "#c94f6d";
          green = "#81b29a";
          yellow = "#dbc074";
          blue = "#719cd6";
          magenta = "#9d79d6";
          cyan = "#63cdcf";
          white = "#dfdfe0";
        };
        bright = {
          black = "#393b44";
          red = "#c94f6d";
          green = "#81b29a";
          yellow = "#dbc074";
          blue = "#719cd6";
          magenta = "#9d79d6";
          cyan = "#63cdcf";
          white = "#dfdfe0";
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
