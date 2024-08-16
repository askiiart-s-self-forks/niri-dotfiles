local wezterm = require 'wezterm'
local config = wezterm.config_builder()

----- actual config -----

config.font = wezterm.font('FiraCode Nerd Font')
config.font_size = 11.0

-- enable scrollbar
config.enable_scroll_bar = true

-- clone of my catppuccin mocha kitty theme (not the same as the default catppuccin mocha color scheme
config.color_scheme = 'Catppuccin Mocha'

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0
}

config.colors = {
    foreground = '#CAD3F5',
    background = '#24273A',
    cursor_fg = '#24273A',
    cursor_bg = '#F4DBD6',
    cursor_border = '#F4DBD6',
    selection_fg = '#24273A',
    selection_bg = '#F4DBD6',
    scrollbar_thumb = '#F4DBD6',
    split = '#1E1E2E',

    ansi = {
        '#494D64', -- black
        '#ED8796', -- red
        '#A6DA95', -- green
        '#EED49F', -- yellow
        '#8AADF4', -- blue
        '#F5BDE6', -- magenta
        '#8BD5CA', -- cyan
        '#B8C0E0'  -- white
    },
    brights = {
        '#5B6078', -- black
        '#ED8796', -- red
        '#A6DA95', -- green
        '#EED49F', -- yellow
        '#8AADF4', -- blue
        '#F5BDE6', -- magenta
        '#8BD5CA', -- cyan
        '#A5ADCB'  -- white
    }
}

config.default_cursor_style = 'SteadyBar'

return config
