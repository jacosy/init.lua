vim.keymap.set("n", "<leader>pv", vim.cmd.Oil)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- close quickfix window
vim.keymap.set("n", "<C-c>", ":cclose<CR>", { noremap = true })

-- fix the <CR> not working in the quickfix window
-- Create or get the autocommand group
local group = vim.api.nvim_create_augroup("QuickfixMappings", { clear = true })

-- Create an autocommand for the 'qf' (quickfix) filetype
vim.api.nvim_create_autocmd("FileType", {
    group = group,  -- Associate with the group
    pattern = "qf", -- Trigger when the filetype is 'qf' (quickfix)
    callback = function()
        -- Define the key mapping (nnoremap <buffer> <CR> <CR>)
        vim.api.nvim_buf_set_keymap(0, 'n', '<CR>', '<CR>', { noremap = true, silent = true })
    end,
})

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/longoria/packer.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

-- bufferline
vim.keymap.set('n', '[b', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', ']b', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>1', ':lua require("bufferline").go_to(1, true)<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>2', ':lua require("bufferline").go_to(2, true)<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>3', ':lua require("bufferline").go_to(3, true)<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>4', ':lua require("bufferline").go_to(4, true)<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>5', ':lua require("bufferline").go_to(5, true)<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>6', ':lua require("bufferline").go_to(6, true)<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>7', ':lua require("bufferline").go_to(7, true)<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>8', ':lua require("bufferline").go_to(8, true)<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>9', ':lua require("bufferline").go_to(-1, true)<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gD', ':BufferLinePickClose<CR>', { noremap = true, silent = true })

-- navigate vim panels
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")

-- split vim panel
vim.keymap.set("n", "<C-w>|", ":vs<CR>")
vim.keymap.set("n", "<C-w>%", ":sp<CR>")

-- for solving the git conflicts
vim.keymap.set("n", "gL", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "gR", "<cmd>diffget //3<CR>")

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
