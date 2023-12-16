local M = {}

M.language_mapping = {
	javascript = {
		files = { "js", "jsx" },
		start_comment = "//",
		end_comment = "",
	},
	typescript = {
		files = { "js", "jsx" },
		start_comment = "//",
		end_comment = "",
	},
	html = {
		files = { "html", "htm" },
		start_comment = "<!--",
		end_comment = "-->",
	},
	css = {
		files = { "css" },
		start_comment = "/*",
		end_comment = "*/",
	},
	golang = {
		files = { "go" },
		start_comment = "//",
		end_comment = "",
	},
	rust = {
		files = { "rs" },
		start_comment = "//",
		end_comment = "",
	},
	lua = {
		files = { "lua" },
		start_comment = "--",
		end_comment = "",
	},
}

M.get_comment = function(file_ext)
	local result = {}

	for _, lang in pairs(M.language_mapping) do
		for _, supported_ext in ipairs(lang.files) do
			if supported_ext == file_ext then
				table.insert(result, lang.start_comment)
				table.insert(result, lang.end_comment)
			end
		end
	end

	return result
end

return M
