--vim.keymap.set('n', '<leader>p.', vim.cmd.Ex, { desc = "Return to file directory in netrw" })

-- Move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join the current line with the next line" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half a page and center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half a page and center cursor" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center cursor" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center cursor" })
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>", { desc = "Restart LSP server" })

-- greatest remap ever
vim.keymap.set(
	"x",
	"<leader>p",
	[["_dP]],
	{ desc = "Delete selected text and paste without modifying unnamed register" }
)

-- next greatest remap ever
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy line to clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete text to black hole register" })

vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Use Ctrl+C as Esc" })

vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Ex mode" })
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "Next item in quickfix list and center cursor" })
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = "Previous item in quickfix list and center cursor" })
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz", { desc = "Next item in location list and center cursor" })
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz", { desc = "Previous item in location list and center cursor" })

vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Search and replace word under cursor" }
)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current file executable" })

vim.keymap.set(
	"n",
	"<leader>.pp",
	"<cmd>e ~/.config/nvim/lua/sharker/remap.lua<CR>",
	{ desc = "Open remap.lua configuration file" }
)
vim.keymap.set(
	"n",
	"<leader>mr",
	"<cmd>CellularAutomaton make_it_rain<CR>",
	{ desc = "Run CellularAutomaton make_it_rain" }
)

vim.keymap.set("n", "<leader><leader>x", function()
	vim.cmd("so")
end, { desc = "Source current file" })
vim.keymap.set("n", "<leader>x", ":.lua<CR>", { desc = "Source current line" })
vim.keymap.set("v", "<leader>x", ":lua<CR>", { desc = "Source current selection" })

-- Autocommands
vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true })

-- highlight yanks
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = "kickstart-highlight-yank",
	pattern = "*",
	callback = function()
		vim.hl.on_yank({ timeout = 200 })
	end,
})

-- small terminal
local term_buf = nil
local job_id = 0
vim.keymap.set({ "n", "t" }, "<leader>pt", function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_buf(win) == term_buf then
			vim.api.nvim_win_close(win, true)
			return
		end
	end

	if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
		vim.cmd.vnew()
		vim.cmd("buffer " .. term_buf)
		vim.cmd.wincmd("J")
		vim.api.nvim_win_set_height(0, 15)
		vim.cmd("startinsert!")
		return
	end
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 15)

	job_id = vim.bo.channel
	term_buf = vim.api.nvim_get_current_buf()
	vim.cmd("startinsert!")
end, { desc = "Toggle persistent terminal" })

vim.keymap.set("n", "<leader>pr", function()
	vim.fn.chansend(job_id, { "npm run dev\r\n" })
end, { desc = "Run: nmp run dev" })

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Return to normal mode in terminal." })
vim.keymap.set("n", "<leader>af", "ggVG", { desc = "Select [a]ll [f]ile" })

vim.keymap.set("n", "<leader>o", "o<Esc>", { desc = "Create new line under" })
vim.keymap.set("n", "<leader>O", "O<Esc>", { desc = "Create new line above" })
-- TODO: ALERT WHEN CAPS ARE ON.

-- Lilipond
vim.api.nvim_create_autocmd("BufEnter", {
	command = "syntax sync fromstart",
	pattern = { "*.ly", "*.ily", "*.tex" },
})

