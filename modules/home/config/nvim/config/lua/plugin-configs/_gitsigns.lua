-- Set up highlights first
local function setup_highlights()
	vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#a6e3a1" }) -- Catppuccin green
	vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#f9e2af" }) -- Catppuccin yellow
	vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#f38ba8" }) -- Catppuccin red

	-- Number column highlights
	vim.api.nvim_set_hl(0, "GitSignsAddNr", { fg = "#a6e3a1", bg = "NONE" })
	vim.api.nvim_set_hl(0, "GitSignsChangeNr", { fg = "#f9e2af", bg = "NONE" })
	vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { fg = "#f38ba8", bg = "NONE" })

	-- Line highlights (subtle backgrounds)
	vim.api.nvim_set_hl(0, "GitSignsAddLn", { bg = "#2d3235" }) -- Darker green tint
	vim.api.nvim_set_hl(0, "GitSignsChangeLn", { bg = "#2d2e33" }) -- Darker yellow tint
	vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { bg = "#2d2a32" }) -- Darker red tint
end

-- Call the highlight setup
setup_highlights()

-- Gitsigns configuration
require("gitsigns").setup({
	signs = {
		add = { text = "󰐕" },
		change = { text = "󰐕" },
		delete = { text = "▁" },
		topdelete = { text = "▔" },
		changedelete = { text = "~" },
	},

	-- Sign column config
	signcolumn = true,
	numhl = false,
	linehl = true,
	word_diff = false,

	-- Blame line configuration
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol",
		delay = 500,
		ignore_whitespace = false,
	},
	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",

	-- Update time
	update_debounce = 100,

	-- Status formatter
	status_formatter = nil,

	-- Keymaps
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		-- Helper function for mapping keys
		local function map(mode, lhs, rhs, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		-- Navigation
		map("n", "<C-n>", function()
			if vim.wo.diff then
				return "<C-n>"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, desc = "Next git hunk" })

		map("n", "<C-p>", function()
			if vim.wo.diff then
				return "<C-p>"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, desc = "Previous git hunk" })

		-- Actions
		map({ "n", "v" }, "<leader>ga", ":Gitsigns stage_hunk<CR>", { desc = "Git stage hunk" })
		map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Git reset hunk" })
		map("n", "<leader>gaa", gs.stage_buffer, { desc = "Git stage buffer" })
		map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo git stage" })
		map("n", "<leader>gra", gs.reset_buffer, { desc = "Reset git actions in buffer" })
		map("n", "<leader>gh", gs.preview_hunk, { desc = "Preview git hunk" })
		map("n", "<leader>gd", gs.diffthis, { desc = "Git diff this" })
		map("n", "<leader>gD", function()
			gs.diffthis("~")
		end, { desc = "Git diff against last commit" })

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select git hunk" })
	end,

	-- Watch git dir
	watch_gitdir = {
		interval = 1000,
		follow_files = true,
	},

	-- Attach to untracked files
	attach_to_untracked = true,

	-- Preview config
	preview_config = {
		border = "rounded",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
})
