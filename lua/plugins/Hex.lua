return {
  "RaafatTurki/hex.nvim",
  opts = {
    dump_cmd = "xxd -g 1 -u",
    assemble_cmd = "xxd -r",
    is_file_binary_pre_read = function()
      -- logic that determines if a buffer contains binary data or not
      -- must return a boolean
    end,
    is_file_binary_post_read = function()
      -- logic that determines if a buffer contains binary data or not
      -- must return a boolean
    end,
  },
}

