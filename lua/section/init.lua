print("Hello from section.nvim")
local util = require("section.util")
local map = require("section.languages")

local M = {}

-- Default config
M.defaults = {
	-- whether or not comment should be uppercase
	uppercase = false,
	-- leading space between comment characters (e.g. //) and section symbol
	leading_space = true,
	-- spaces around comment words?
	word_space = true,
	-- total length of comment
	total_length = 50,
	-- emtpy lines around the comment?
	empty_lines_around = true,
	-- default character to use
	char = "-",
	-- how many chars are before the first word
	num_chars_start = 5,
	-- if true, words will be centered and start and end will always be printed
	-- note that this cannot necessarily guarantee that all section comments will be
	-- the same total length
	symmetrical = false,
}

-- TODO: Implement setup and all that...
-- i.e. merge setup provided to plugin with defaults
M.setup = function(opts)
	print("Options:", opts)
end

-- Actual function to call to create a comment
M.create_comment = function()
	local input = vim.fn.input("Comment: ")

	if input == "" then
		return
	end

	M.print_comment(input)
end

-- Inserts the comment into the current buffer
M.print_comment = function(comment, uppercase, char)
	uppercase = uppercase or false

	local bufnr = vim.fn.bufnr("%")
	local current_line = vim.fn.line(".")
	local comment_start = ""
	local comment_end = ""

	-- get the start and end comment symbold based on filetype
	local filetype = util.get_file_type()
	local comment_symbols = map.get_comment(filetype)

	if comment_symbols and comment_symbols[1] then
		comment_start = comment_symbols[1]
	end
	if comment_symbols and comment_symbols[2] then
		comment_end = comment_symbols[2]
	end

	-- set comment uppercase or not... who knows?
	comment = (uppercase or M.defaults.uppercase) and string.upper(comment) or comment

	-- set char to insert
	char = char or M.defaults.char

	-- calculate the number of chars to add to the end
	local comment_length = string.len(comment)
	local symbol_length = string.len(comment_start)
	local add_to_end = M.defaults.total_length - comment_length - symbol_length - M.defaults.num_chars_start - 3

	-- build string to actually insert
	local insert = comment_start
		.. " "
		.. string.rep(char, M.defaults.num_chars_start)
		.. " "
		.. comment
		.. " "
		.. string.rep(char, add_to_end)

	-- insert the comment into the current line or line above if current is not empty
	if current_line == "" then
		vim.api.nvim_buf_set_lines(bufnr, current_line - 1, current_line + 1, false, { insert })
	else
		vim.api.nvim_buf_set_lines(bufnr, current_line - 1, current_line - 1, false, { insert })
	end
end

return M
