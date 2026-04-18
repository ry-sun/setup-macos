require("full-border"):setup({
    type = ui.Border.ROUNDED,
})

require("git"):setup({
    -- Order of status signs showing in the linemode
    order = 1500,
})

require("duckdb"):setup({ mode = "standard" })

require("recycle-bin"):setup()

require("restore"):setup({
    -- Set the position for confirm and overwrite prompts.
    -- Don't forget to set height: `h = xx`
    -- https://yazi-rs.github.io/docs/plugins/utils/#ya.input
    position = { "center", w = 70, h = 40 }, -- Optional

    -- Show confirm prompt before restore.
    -- NOTE: even if set this to false, overwrite prompt still pop up
    show_confirm = true, -- Optional

    -- Suppress success notification when all files or folder are restored.
    suppress_success_notification = true, -- Optional

    -- colors for confirm and overwrite prompts
    theme = { -- Optional
        -- Default using style from your flavor or theme.lua -> [confirm] -> title.
        -- If you edit flavor or theme.lua you can add more style than just color.
        -- Example in theme.lua -> [confirm]: title = { fg = "blue", bg = "green"  }
        title = "blue", -- Optional. This value has higher priority than flavor/theme.lua

        -- Default using style from your flavor or theme.lua -> [confirm] -> content
        -- Sample logic as title above
        header = "green", -- Optional. This value has higher priority than flavor/theme.lua

        -- header color for overwrite prompt
        -- Default using color "yellow"
        header_warning = "yellow", -- Optional
        -- Default using style from your flavor or theme.lua -> [confirm] -> list
        -- Sample logic as title and header above
        list_item = { odd = "blue", even = "blue" }, -- Optional. This value has higher priority than flavor/theme.lua
    },
})

require("fs-usage"):setup()

require("ffmpeg-stats"):setup({
    -- Which stats should be shown by default upon opening yazi
    duration = false,
    resolution = false,
    codec = false,
    fps = false,
    bitrate = false,
    audio_codec = false,
    audio_channels = false,
    format = false,
    aspect = false,

    -- Uses theme colour by default
    -- style = ui.Style():fg("cyan"),
})

require("omp"):setup()
