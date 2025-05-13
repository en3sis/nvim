### Diagnostics and Linting
- `<leader>vd`: Open diagnostic float.
    - `<leader>xq`: TroubleToggle & quick fix.
- `<leader>gr` show reference in telescope
	- `C-q` quick fix list, then you can <`C-h`> and `<C-l`> 

### Navigation and File Management
- `<C-t/h/m/n>`: Navigate Harpoon files.
- `<leader>a`: Add file to Harpoon.
- `Ctrl+ˆ`: Go back (previous file).
- `<leader>ef`: Explore Files.
- `C+p`: Find files (all).
- `C+w+=`: Make split windows equal.

### On FileExplore
- `C-v`: Go to file section as a split.
- `C-t`: Go to a file in a new tab.
- `C-ˆ`: Alternate files.

### Code Navigation
- `gd`: Go to definition.
- `<leader>es`: Grep for name.
- `Shift-K`: Show floating definition.
- ` ``(x2)`: Moves between the last two positions.
- `  ``&. `: Moves to latest edit.
- `$/_`: End/Beginning of line.
- `%`: Flips to Start/End of {}

### Selection and Editing
- `yiW`: Yank (copy) the current word including punctuation.
- `ggVG`: Select whole file.
- `Ctrl+V -> Shift I -> //`: Comment whole block.
- `Shift + I/A`: Beginning and end of line insert.
- `*`: Set current element as search pattern.
    - `n`: Move to the next occurrence.
- `f<char>`: Move to character, F for backward.
	- use `;` and `,` to move next/prev
- `vit`: Select inside tag (HTML).
- `vt{`: Selects TO
- `<leader>u`: Show UndotreeToggle (GitHub).
### Clipboard and Yanking
- `<leader>y`: Copy to clipboard.

### Version Control and Git
- `<leader>u`: Show UndotreeToggle (GitHub).
- `!Gvdiffsplit!`: Opens a 3 way split 
	- `<leader>gh`

### Macros
- `@@`: Repeat last macro.

### General
- `<leader>p`: Paste from clipboard.
- `<C-c>` (in insert mode): Escape to normal mode.

### Navigation
- `<C-d>`: Move half-page down.
- `<C-u>`: Move half-page up.
- `N`: Moves to the previous (occurrence).
- `;`: Repeat the last f, F, t, or T motion (forward).
- `,`: Repeat the last f, F, t, or T motion (backward).

### Editing
- `r`: Replace the character under the cursor.
- `D`: Remove everything from the cursor to the end of the line.
- `:%s/from/to` or `<leader>s`: Replace text from 'from' to 'to'.
- `ciW`: Change (delete and enter insert mode) inside the current word.
- `ci"({`: Change (delete and enter insert mode) inside the specified characters.
- `vi{(<...`: Select inside the specified characters.
- `va{(`: Select around the specified characters.
- `vaW`: Select all text until the next whitespace.
- `vip`: Select the current paragraph.
- `viw`: Select the current word.
- `yow`: Yank (copy) the current "word" (consecutive text).
- `J` (in visual mode): Join the selected lines.
- `K` (in visual mode): Move the selected text up.
- `J` (in normal mode): Join the current line with the next one, without spacing.

### LSP (Language Server Protocol)
- `<leader>vws`: Search workspace symbols.
- `\[d` and `\]d`: Navigate diagnostics.
    - `F3`: Show code actions.
- `<leader>vrr`: Show references.
- `<leader>F2`: Rename symbol.
- `K`: Hover to see details.
- `<C-n>` and `<C-p>` (in insert mode): Navigate suggestions.
- `<C-h>` (in insert mode): Show signature help.
- `<leader>gr` show reference in telescope
	- `C-q` exits to buffer, then you can <`C-h`> and `<C-l`> 

### Git
- `<leader>ga`: Git add.
- `<leader>gc`: Git commit.
- `<leader>gp`: Git push.
	On gs (Git status panel)
	- `dv`: View difference.
	    - `gh`: Picks left.
	    - `gl`: Picks right.

### Windows
- `C-w-h / C-w-v`: Move to a split horizontally/vertically.
- `C-x`: Split window horizontally.

### Miscellaneous
- `<leader>f`: Format the current document.

### Treesitter
- `D`: Create a new directory.
- `%`: Create a new file.

### Possible Plugins
- [Search]([https://www.reddit.com/r/neovim/comments/1b5ri9g/developing_search_replace_similar_to_vs_code_with/](https://www.reddit.com/r/neovim/comments/1b5ri9g/developing_search_replace_similar_to_vs_code_with/))
- [Distant]([https://github.com/chipsenkbeil/distant.nvim](https://github.com/chipsenkbeil/distant.nvim))

