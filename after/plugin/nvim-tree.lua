local tree = require('nvim-tree')
local tree_api = require('nvim-tree.api')

tree.setup({
    view = {
        width = 50,
        float = {
            enable = true,
            open_win_config = {
                row = 0,
                col = 0,
                width = 48,
                height = 56,
            }
        },
        mappings = {
            list = {
                { key = '<LeftRelease>', action = 'edit' },
                { key = '<Esc>',         action = 'close' },
                { key = '<M-1>',         action = 'close' },
                { key = '<M-!>',         action = 'close' },
            }
        }
    },
    git = {
        enable = false,
    },
})

-- vim.keymap.set('n', '<M-1>', ":NvimTreeFindFile<CR>", {silent=true})
vim.keymap.set('n', '<leader>pv', function()
    tree_api.tree.toggle(true, false, vim.fn.getcwd())
end)
vim.keymap.set('n', '<M-2>', function()
    tree_api.tree.toggle(true, false, vim.fn.expand('%:p:h'))
end)

local function open_nvim_tree(data)
    -- buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1

    if not directory then
        return
    end

    -- change to the directory
    vim.cmd.cd(data.file)

    -- open the tree
    require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

