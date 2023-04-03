return {
    'terrortylor/nvim-comment',
    event = "BufEnter",
    config = function(_, opts) 
        require('nvim_comment').setup {}
    end
}
