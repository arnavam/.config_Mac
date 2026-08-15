# undo.yazi

A [Yazi](https://yazi-rs.github.io/) plugin to undo your changes.

## Installation

Use the [yazi package manager](https://yazi-rs.github.io/docs/cli#package-manager) to install this plugin:

```bash
ya pkg add 0xHouss/undo
```


## Usage

1. Key bindings:

    Add this to your [`~/.config/yazi/keymap.toml`](https://yazi-rs.github.io/docs/configuration/keymap):

    ```toml
    # A TOML linter such as https://taplo.tamasfe.dev/ can use this schema to validate your config.
    # If you encounter any issues, please make an issue at https://github.com/yazi-rs/schemas.
    "$schema" = "https://yazi-rs.github.io/schemas/keymap.json"

    [mgr]
    prepend_keymap = [
      ...

      # Undo
      { on = [
        "u",
      ], run = "plugin undo", desc = "Undo last changes" },

      ...
    ]

    ...
    ```

2. Configuration (Optional)

    ```lua
    require("undo"):setup({})
    ```

3. Enjoy

    Currently the plugin handles undoing trashing, when deleting items to the trash, you can press u to restore them.

## Todo

- Add setup opts
- Add history limit
- Add handling for rename, move, duplicate
