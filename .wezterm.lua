-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Color Scheme
config.color_scheme = 'Monokai Remastered'

-- Font configuration
config.font = wezterm.font('Menlo')
config.font_size = 14.0
config.freetype_load_target = 'Light'
config.freetype_render_target = 'HorizontalLcd'

-- Remove all padding
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

-- F11 to toggle fullscreen mode
config.keys = {
  { key = 'F11', action = wezterm.action.ToggleFullScreen },
}

-- URLs in Markdown files are not handled properly by default
-- Source: https://github.com/wez/wezterm/issues/3803#issuecomment-1608954312
config.hyperlink_rules = {
  -- Matches: a URL in parens: (URL)
  {
    regex = '\\((\\w+://\\S+)\\)',
    format = '$1',
    highlight = 1,
  },
  -- Matches: a URL in brackets: [URL]
  {
    regex = '\\[(\\w+://\\S+)\\]',
    format = '$1',
    highlight = 1,
  },
  -- Matches: a URL in curly braces: {URL}
  {
    regex = '\\{(\\w+://\\S+)\\}',
    format = '$1',
    highlight = 1,
  },
  -- Matches: a URL in angle brackets: <URL>
  {
    regex = '<(\\w+://\\S+)>',
    format = '$1',
    highlight = 1,
  },
  -- Then handle URLs not wrapped in brackets
  {
    -- Before
    --regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
    --format = '$0',
    -- After
    regex = '[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)',
    format = '$1',
    highlight = 1,
  },
  -- implicit mailto link
  {
    regex = '\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b',
    format = 'mailto:$0',
  },
}

-- Remove the title bar from the window
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"

-- Use zsh by default
config.default_prog = { '/bin/zsh' }

-- Don't hide cursor when typing
config.hide_mouse_cursor_when_typing = false

-- Return the configuration to wezterm
return config
