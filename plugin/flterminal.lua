local state = {
	term1 = {
		buf = -1,
		win = -1,
	},
	term2 = {
		buf = -1,
		win = -1,
	},
}

local function create_floating_window(opts)
	opts = opts or {}
	local width = opts.width or math.floor(vim.o.columns * 0.8)
	local height = opts.height or math.floor(vim.o.lines * 0.8)

	-- Calculate the position to center the window
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	-- Create a buffer
	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true)
	end

	-- Define window configuration
	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	}

	-- Create the floating window
	local win = vim.api.nvim_open_win(buf, true, win_config)
	return { buf = buf, win = win }
end

local function toggle_floating_terminal(term_state)
	if not vim.api.nvim_win_is_valid(term_state.win) then
		local created = create_floating_window({ buf = term_state.buf })
		term_state.buf = created.buf
		term_state.win = created.win

		if vim.bo[term_state.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
		vim.cmd("startinsert!")
	else
		vim.api.nvim_win_hide(term_state.win)
	end
end

vim.api.nvim_create_user_command("Floaterminal", function()
	toggle_floating_terminal(state.term1)
end, {})
vim.api.nvim_create_user_command("Floaterminal2", function()
	toggle_floating_terminal(state.term2)
end, {})

vim.keymap.set({ "n", "t" }, "<leader>pf", function()
	toggle_floating_terminal(state.term1)
end, { desc = "Toggle terminal 1" })

vim.keymap.set({ "n", "t" }, "<leader>pF", function()
	toggle_floating_terminal(state.term2)
end, { desc = "Toggle terminal 2" })

