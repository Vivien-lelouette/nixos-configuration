{ ... }:
{
  services.xremap = {
    userName = "vivien";
    serviceMode = "user";
    withKDE = true;
    config = {
      keymap = [
      #   {
      #     name = "Global";
      #     application = { "not" = ["emacs"]; };
      #     remap = {
      #       # Cursor
      #       "C-b" = "left";
      #       "C-f" = "right";
      #       "C-p" = "up";
      #       "C-n" = "down";

      #       # Forward/Backward word
      #       "M-b" = "C-left";
      #       "M-f" = "C-right";

      #       # Beginning/End of line
      #       "C-a" = "home";
      #       "C-e" = "end";

      #       # Page up/down
      #       "M-v" = "pageup";
      #       "C-v" = "pagedown";

      #       # Beginning/End of file
      #       "M-Shift-comma" = "C-home";
      #       "M-Shift-dot" = "C-end";

      #       # Newline
      #       "C-m" = "enter";
      #       "C-j" = "enter";
      #       "C-o" = ["enter" "left"];

      #       # Copy
      #       "C-w" = "C-x";
      #       "M-w" = "C-c";
      #       "C-y" = "C-v";

      #       # Delete
      #       "C-d" = "delete";
      #       "M-d" = "C-delete";

      #       # Kill line
      #       "C-k" = ["Shift-end" "C-x"];

      #       # Undo
      #       "C-slash" = "C-z";

      #       # Search
      #       "C-s" = "C-f";
      #       "C-r" = "Shift-F3";

      #       # Cancel
      #       "C-g" = "esc";

      #       "C-x" = {
      #         remap = {
      #           # C-x h (select all)
      #           "h" = ["C-home" "C-a"];

      #           # C-x C-f (open)
      #           "C-f" = "C-o";

      #           # C-x C-s (save)
      #           "C-s" = "C-s";

      #           # C-x k (kill tab)
      #           "k" = "C-w";

      #           # C-x C-c (exit)
      #           "C-c" = "C-q";
      #         };
      #       };

      #       "C-c" = {
      #         remap = {
      #           "C-c" = "C-enter";
      #         };
      #       };
      #     };
      #   }
      #   {
      #     name = "Konsole";
      #     application = { "only" = ["org.kde.konsole"]; };
      #     remap = {
      #       # History search
      #       "M-r" = "C-r";

      #       "C-c" = {
      #         remap = {
      #           "C-c" = "C-c";
      #         };
      #       };
      #     };
      #   }
      ]
      ;
    };
  };
}
