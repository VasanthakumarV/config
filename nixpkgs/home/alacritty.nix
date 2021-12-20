{ ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      env = { "TERM" = "xterm-256color"; };
      font = {
        size = 11.0;
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
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
          key = "C";
          mods = "Control";
          action = "Copy";
        }
        {
          key = "V";
          mods = "Control";
          action = "Paste";
        }
        {
          key = "Key0";
          mods = "Control";
          action = "ResetFontSize";
        }
        {
          key = "Minus";
          mods = "Control";
          action = "DecreaseFontSize";
        }
        {
          key = "Equals";
          mods = "Control";
          action = "IncreaseFontSize";
        }
        {
          key = "Minus";
          mods = "Control";
          action = "DecreaseFontSize";
        }
        {
          key = "Plus";
          mods = "Control";
          action = "IncreaseFontSize";
        }
      ];
    };
  };
}
