MOST COMMONS:

Diagnostics and Linting:

<leader>vd: Open diagnostic float.
Navigation and File Management:

<C-h/t/n/s>: Navigate Harpoon files.
<leader>a: Add file to Harpoon.
Ctrl+o: Go back (previous file).
<leader>ef: Find files.
C+p: Find files (all).
C+w+=: Make split windows equal.
C-v: Go to file section as a split.
C-t: Go to a file in a new tab.
Code Navigation:

gd: Go to definition.
<leader>es: Grep for name.
Shift-K: Show floating definition.
Selection and Editing:

ggVG: Select whole file.
Ctrl+V -> Shift I -> //: Comment whole block.
Shift + I/A: Beginning and end of line insert.
*: Set current element as search pattern.
n: Move to the next occurrence.
f<char>: Move to character, F for backward.
vit: Select inside tag (HTML).
Clipboard and Yanking:

<leader>y: Copy to clipboard.
Version Control and Git:

<leader>u: Show UndotreeToggle (GitHub).
General:

<leader>p: Paste from clipboard
<C-c> (in insert mode): Escape to normal mode
Navigation:

<C-d>: Move half-page down
<C-u>: Move half-page up
N: Moves to the prev (occurrence)
;: Repeat the last f, F, t, or T motion (forward)
,: Repeat the last f, F, t, or T motion (backward)
Editing:

r: Replace the character under the cursor
D: Remove everything from the cursor to the end of the line
:%s/from/to or <leader>s: Replace text from 'from' to 'to'
ciW: Change (delete and enter insert mode) inside the current word
ci"({: Change (delete and enter insert mode) inside the specified characters
vi{(<...: Select inside the specified characters
va{(: Select around the specified characters
vaW: Select all text until the next whitespace
vip: Select the current paragraph
viw: Select the current word
yiW: Yank (copy) the current word including punctuation
yow: Yank (copy) the current "word" (consecutive text)
J (in visual mode): Join the selected lines
K (in visual mode): Move the selected text up
J (in normal mode): Join the current line with the next one, without spacing

LSP (Language Server Protocol):

<leader>vws: Search workspace symbols
\[d and \]d: Navigate diagnostics
<leader>vca: Show code actions
<leader>vrr: Show references
<leader>F2: Rename symbol
K: Hover to see details
<C-n> and <C-p> (in insert mode): Navigate suggestions
<C-h> (in insert mode): Show signature help
Git:

<leader>gc: Git commit
<leader>gp: Git push
Windows:

C-w-h / C-w-v: Move to a split horizontally/vertically
C-x: Split window horizontally
Miscellaneous:

<leader>f: Format the current document
Treesitter:

D: Create a new directory
%: Create a new file

## Other pugins

https://github.com/airblade/vim-gitgutter
https://github.com/brenoprata10/nvim-highlight-colors
https://github.com/folke/todo-comments.nvim
