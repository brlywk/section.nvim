local M = {}

M.get_file_type = function()
	local file_open = vim.fn.bufname("%") ~= ""

	if not file_open then
		return nil
	end

	local current_file_path = vim.fn.expand("%")
	local file_extension = vim.fn.fnamemodify(current_file_path, ":e")
	-- local file_type = vim.bo.filetype

	return file_extension

	-- print("Extension:", file_extension)
	-- print("Type:", file_type)
end

-- DEBUG: Just a temporary function to reload the plugin
M.debug_reset = function()
	package.loaded["section"] = nil
	require("section")
end

return M
