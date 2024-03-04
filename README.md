# Keybindings Reference

This document outlines the keybindings grouped by their categories for easy reference.

## Most Commons

- `<leader>vd`: Open diagnostic float.
- `<C-h/t/n/s>`: Navigate Harpoon files.
- `<leader>a`: Add file to Harpoon.
- `<leader>y`: Copy to clipboard.
- `Ctrl+o`: Goes back (previous file).
- `gd`: Go to definition.
- `ggVG`: Selects whole file.
- `<leader>es`: Grep for name.
- `Ctrl+V` -> `Shift I` -> `//`: Comment whole block.
- `Shift-K`: Shows floating Definition.
- `<leader>U`: Shows UndotreeToggle.
- `Shift + I/A` -> Beginning & end of line Insert.
- `*`: Sets current element as search pattern.
  - `n`: Moves to the next occurrence.

## Edit Text

- `:%s/from/to` or `<leader>s`: Replace text from 'from' to 'to'.
- `r`: Select and replace at selection.
- `D`: Removes everything to the end of the cursor.

## Motions

- `VI`: Visual Inside.
- `VA`: Visual Around.
- `w`: Move forward by a word.
- `b`: Move backwards by a word.
- `vip`: Select paragraphs.
- `vi {(<…`: Selects all in between the specified characters.
- `va {(`: Selects all including the specified characters.
- `vaW`: Selects all to whitespace.
- `V`: Selects whole line.
- `ggVG`: Selects whole file.
- `viw`: Select the word, no matter where in the word's position.
- `yiW`: Yank inside word including punctuation.
- `yow`: Yank all continued text (e.g., `some::long::string`).
- `ciW`: Deletes continued text and enters insert mode.
- `ctrl + o`: Jumps back on jumps.
- `ci “({`: Jumps and replace between specified characters.

## Moves Half-Page

- `<C-d>`: Move half-page down.
- `<C-u>`: Move half-page up.

## Moves Selected Content UP/DOWN

- `v mode J`: Move selected content down.
- `v mode K`: Move selected content up.
- `n mode J`: Join lines without spacing.

## Clipboard Operations

- `<leader>y`: Copy to clipboard.
- `<leader>Y`: Copy whole line to clipboard.
- `<leader>p`: Paste from clipboard.

## Miscellaneous

- `<C-c>` in insert mode: Escape to normal mode.
- `<leader>f`: Format document with LSP.
- `<leader>s`: Replace the current word with input.

## Harpoon

- `<leader>a`: Add file to Harpoon.
- `<C-e>`: Toggle Harpoon quick menu.
- `C-v`: Split window vertically.
- `C-x`: Split window horizontally.
- `C-t`: Open a new tab.
- `<C-h/t/n/s>`: Navigate Harpoon files.

## LSP

- `C-n`: Navigate suggestion down.
- `C-p`: Navigate suggestion up.
- `Ctrl+o`: Goes back (previous file).
- `gd`: Go to definition.
- `K`: Hover to see details.
- `<leader>vws`: Search workspace symbols.
- `<leader>vd`: Open diagnostic float.
- `[d` and `]d`: Navigate diagnostics.
- `<leader>vca`: Show code actions.
- `<leader>vrr`: Show references.
- `<leader>F2`: Rename symbol.
- `<C-h>` in insert mode: Show signature help.

## Git

- `<leader>gc`: Git commit.
- `<leader>gp`: Git push.
- `<leader>gs`: Git status.

## Split Windows

- `C-w-h/C-w-v`: Move to split horizontally/vertically.
- `<leader>vd`: Opens diagnostics.
- `<leader>f`: Format document.
- `<leader>s`: Renames the current word.

## Treesitter

- `D`: New directory.
- `%`: New file.
- `R`: Rename file.



## Other pugins

https://github.com/airblade/vim-gitgutter
https://github.com/brenoprata10/nvim-highlight-colors
https://github.com/folke/todo-comments.nvim
