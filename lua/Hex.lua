require("hex").setup({
	dump_cmd = "xxd -g -1 -u",
    assemble_cmd = "xxd -r",
    is_file_binary_pre_read = function() end,
    is_file_binary_post_read = function() end,
})
