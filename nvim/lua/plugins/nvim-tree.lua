return {
    "nvim-tree/nvim-tree.lua",
    config = function(_, opts)
        require("nvim-tree").setup({
            view = {
                number = true,
                relativenumber = true,
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },
        })
    end
}
