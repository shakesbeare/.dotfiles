return {
    "ggandor/leap.nvim",
    dependencies = {
        "tpope/vim-repeat"
    },
    event = "VeryLazy",
    config = function(_, opts)
        require('leap').add_default_mappings()
    end
}
