{ ... }:
{
  services.xremap = {
    userName = "vivien";
    serviceMode = "user";
    withWlroots = true;
    watch = true;
    yamlConfig = ''
modmap:
  - name: Ergonomic
    remap:
      Alt_L: Ctrl_L
      Ctrl_L: Alt_L
      Alt_R: Alt_L
keymap:
  - name: thunderbird
    application:
      only: thunderbird
    remap:
      M-x: C-k
  - name: qutebrowser
    application:
      only: qutebrowser
    remap:
      C-x:
        remap:
          # C-x h (select all)
          h: [C-home, C-a, { set_mark: true }]
          # C-x C-f (open)
          C-f: C-o
          # C-x C-s (save)
          C-s: C-s
          # C-x C-c (exit)
          C-c: C-q
          # C-x u (undo)
          u: [C-z, { set_mark: false }]
          # C-x k (kill tab)
          k: [C-q, k]
          g: [C-q, g]
          b: [C-q, b]
          C-b: [C-q, C-b]
          Shift-b: [C-q, Shift-b]
          m: C-d
          C-m: C-d
          r:
            remap:
              b: [C-q, r, b]
              m: [C-q, r, m]
              l: [C-q, r, l]
              k: [C-q, r, k]
              l: [C-q, r, l]
      C-c: C-Shift-q
      C-s: C-s
      C-r: C-r
  - name: Emacs
    application:
      not: emacs
    remap:
      # Cursor
      C-b: { with_mark: left }
      C-f: { with_mark: right }
      C-p: { with_mark: up }
      C-n: { with_mark: down }
      # Forward/Backward word
      M-b: { with_mark: C-left }
      M-f: { with_mark: C-right }
      # Beginning/End of line
      C-a: { with_mark: home }
      C-e: { with_mark: end }
      # Page up/down
      M-v: { with_mark: pageup }
      C-v: { with_mark: pagedown }
      # Beginning/End of file
      M-Shift-comma: { with_mark: C-home }
      M-Shift-dot: { with_mark: C-end }
      # Newline
      C-m: enter
      C-j: enter
      C-o: [enter, left]
      # Copy
      C-w: [C-x, { set_mark: false }]
      M-w: [C-c, { set_mark: false }]
      C-y: [C-v, { set_mark: false }]
      # Delete
      C-d: [delete, { set_mark: false }]
      M-d: [C-delete, { set_mark: false }]
      # Kill line
      C-k: [Shift-end, C-x, { set_mark: false }]
      # Kill word backward
      Alt-backspace: [C-backspace, {set_mark: false}]
      # set mark next word continuously.
      C-M-space: [C-Shift-right, {set_mark: true}]
      # Undo
      C-slash: [C-z, { set_mark: false }]
      C-Shift-ro: C-z
      # Mark
      C-space: { set_mark: true }
      # Search
      C-s: C-f
      C-r: Shift-F3
      M-Shift-5: C-h
      # Cancel
      C-g: [esc, { set_mark: false }]
      C-x:
        remap:
          # C-x h (select all)
          h: [C-home, C-a, { set_mark: true }]
          # C-x C-f (open)
          C-f: C-o
          # C-x C-s (save)
          C-s: C-s
          # C-x k (kill tab)
          k: C-f4
          # C-x C-c (exit)
          C-c: C-q
          # C-x u (undo)
          u: [C-z, { set_mark: false }]
'';
  };
}