-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- Default settings.
-- Lua port of configs/SystemSettings.conf
--
-- Put your own overrides in UserConfigs/UserSettings.lua, this file is meant
-- to stay close to the upstream defaults.
-- See https://wiki.hypr.land/configuring/core/config-options/

local scriptsDir = os.getenv("HOME") .. "/.config/hypr/scripts"

--------------------
----  LAYOUTS  ----
--------------------

hl.config({
    dwindle = {
        -- pseudotile = true,
        preserve_split        = true,
        -- smart_split = true,
        special_scale_factor  = 0.8,
    },

    master = {
        new_status = "master",
        new_on_top = true,
        mfact      = 0.5,
    },

    general = {
        resize_on_border = true,
        layout           = "dwindle",
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        repeat_rate  = 50,
        repeat_delay = 300,

        sensitivity               = 0, -- mouse sensitivity
        -- accel_profile         = "",  -- flat or adaptive or empty means libinput default
        numlock_by_default        = true,
        left_handed               = false,
        follow_mouse              = 1,
        float_switch_override_focus = false,

        touchpad = {
            disable_while_typing    = true,
            natural_scroll          = true,
            clickfinger_behavior    = false,
            middle_button_emulation = false,
            tap_to_click            = true,
            drag_lock               = false,
        },

        -- For devices with a touch device, i.e. touchscreen
        touchdevice = {
            enabled = true,
        },

        -- For drawing tablets, see the wiki link above for proper variables
        tablet = {
            transform   = 0,
            left_handed = 0,
        },
    },
})

------------------
---- GESTURES ----
------------------

-- Trackpad swipe between workspaces
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

hl.config({
    gestures = {
        workspace_swipe_distance            = 500,
        workspace_swipe_invert              = true,
        workspace_swipe_min_speed_to_force  = 30,
        workspace_swipe_cancel_ratio        = 0.5,
        workspace_swipe_create_new          = true,
        workspace_swipe_forever             = true,
        -- workspace_swipe_use_r            = true, -- forever create a new workspace when swiping right
    },
})

-- Desktop zoom / magnifier. Multiplies the current zoom factor, clamped to >= 1.
local function zoom_by(factor)
    local current = hl.get_config("cursor.zoom_factor") or 1.0
    if current < 1 then
        current = 1
    end
    hl.config({ cursor = { zoom_factor = current * factor } })
end

hl.gesture({
    fingers   = 4,
    direction = "up",
    action    = function() zoom_by(1.5) end,
})

hl.gesture({
    fingers   = 4,
    direction = "down",
    action    = function() zoom_by(1 / 1.5) end,
})

-- Quickshell / AGS overview
hl.gesture({
    fingers   = 3,
    direction = "up",
    action    = function() hl.exec_cmd(scriptsDir .. "/OverviewToggle.sh") end,
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        disable_hyprland_logo   = true,
        disable_splash_rendering = true,
        vrr                     = 2,
        mouse_move_enables_dpms = true,
        enable_swallow          = false,
        swallow_regex           = "^(kitty)$",
        focus_on_activate       = false,
        initial_workspace_tracking = 0,
        middle_click_paste      = false,
        enable_anr_dialog       = true, -- Application not Responding (ANR)
        anr_missed_pings        = 15,   -- ANR threshold, default 1 is too low
        allow_session_lock_restore = true, -- Prevent lockscreen crash when resuming from suspend
        on_focus_under_fullscreen  = 1,    -- 0 = no change, 1 = new window takes over fullscreen, 2 = stays behind
    },
})

-- hl.config({
--     opengl = {
--         nvidia_anti_flicker = true,
--     },
-- })

hl.config({
    binds = {
        workspace_back_and_forth = true,
        allow_workspace_cycles   = true,
        pass_mouse_when_bound    = false,
    },
})

-- Could help when scaling and not pixelating
hl.config({
    xwayland = {
        enabled           = true,
        force_zero_scaling = true,
    },

    render = {
        direct_scanout = 0,
    },

    cursor = {
        sync_gsettings_theme     = true,
        no_hardware_cursors      = 1, -- change to 1 if you want to disable
        enable_hyprcursor        = true,
        warp_on_change_workspace = 2,
        no_warps                 = true,
    },
})
