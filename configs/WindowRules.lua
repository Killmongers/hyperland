-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- Vendor defaults for window rules and layer rules.
-- Lua port of configs/WindowRules.conf (Hyprland >= 0.53 rule syntax)
-- See https://wiki.hypr.land/configuring/core/rules/

-- Some samples on how to start apps on specific workspaces
-- hl.window_rule({ match = { tag = "email*" },       workspace = "1" })
-- hl.window_rule({ match = { tag = "browser*" },     workspace = "2" })
-- hl.window_rule({ match = { tag = "projects*" },    workspace = "3" })
-- hl.window_rule({ match = { tag = "screenshare*" }, workspace = "4 silent" })
-- hl.window_rule({ match = { tag = "gamestore*" },   workspace = "5" })
-- hl.window_rule({ match = { class = "^(virt-manager)$" }, workspace = "6 silent" })
-- hl.window_rule({ match = { class = "^(.virt-manager-wrapped)$" }, workspace = "6 silent" })
-- hl.window_rule({ match = { tag = "im*" },          workspace = "7" })
-- hl.window_rule({ match = { class = "obsidian" },   workspace = "8" })
-- hl.window_rule({ match = { tag = "games*" },       workspace = "8" })
-- hl.window_rule({ match = { tag = "multimedia*" },  workspace = "9 silent" })


--------------------------------------------------------------------
---- TAGS - add apps under the appropriate tag to share settings ----
--------------------------------------------------------------------

-- Tags are matched on class, plus a few title based ones further down.
local classTags = {
    -- browser tags
    { "^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr|[Ff]irefox-bin)$", "+browser" },
    { "^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$",                     "+browser" },
    { "^(chrome-.+-Default)$",                                          "+browser" },
    { "^([Cc]hromium)$",                                                "+browser" },
    { "^([Mm]icrosoft-edge(-stable|-beta|-dev|-unstable))$",             "+browser" },
    { "^(Brave-browser(-beta|-dev|-unstable)?)$",                       "+browser" },
    { "^([Tt]horium-browser|[Cc]achy-browser)$",                        "+browser" },
    { "^(zen-alpha|zen)$",                                              "+browser" },

    -- notif tags
    { "^(swaync-control-center|swaync-notification-window|swaync-client|class)$", "+notif" },

    -- KooL settings tag
    { "^(nwg-displays|nwg-look)$",                              "+KooL-Settings" },
    { "^(Alacritty|kitty|kitty-dropterm)$",                     "+terminal" },
    { "^([Tt]hunderbird|org.mozilla.Thunderbird)$",               "+email" },
    { "^(eu.betterbird.Betterbird)$",                           "+email" },
    { "^(org.gnome.Evolution)$",                                "+email" },
    { "^(codium|codium-url-handler|VSCodium)$",                 "+projects" },
    { "^(VSCode|code|code-url-handler)$",                       "+projects" },
    { "^(jetbrains-.+)$",                                       "+projects" },
    { "^(dev.zed.Zed|antigravity)$",                            "+projects" },
    { "^(com.obsproject.Studio)$",                              "+screenshare" },
    { "^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$",                   "+im" },
    { "^([Ff]erdium)$",                                         "+im" },
    { "^([Ww]hatsapp-for-linux)$",                              "+im" },
    { "^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$", "+im" },
    { "^(teams-for-linux)$",                                    "+im" },
    { "^(im.riot.Riot|Element)$",                               "+im" },
    { "^(gamescope)$",                                          "+games" },
    { "^(steam_app_\\d+)$",                                     "+games" },
    { "^([Ss]team)$",                                           "+gamestore" },
    { "^(com.heroicgameslauncher.hgl)$",                        "+gamestore" },
    { "^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$",          "+file-manager" },
    { "^(app.drey.Warp)$",                                      "+file-manager" },
    { "^([Ww]aytrogen)$",                                       "+wallpaper" },
    { "^([Aa]udacious)$",                                       "+multimedia" },
    { "^([Mm]pv|vlc)$",                                         "+multimedia_video" },
    { "^(wihotspot(-gui)?)$",                                   "+settings" },
    { "^([Bb]aobab|org.gnome.[Bb]aobab)$",                      "+settings" },
    { "^(gnome-disks|wihotspot(-gui)?)$",                       "+settings" },
    { "^(file-roller|org.gnome.FileRoller)$",                   "+settings" },
    { "^(nm-applet|nm-connection-editor|blueman-manager)$",     "+settings" },
    { "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$", "+settings" },
    { "^(qt5ct|qt6ct)$",                                        "+settings" },
    { "(xdg-desktop-portal-gtk)",                               "+settings" },
    { "^(org.kde.polkit-kde-authentication-agent-1)$",           "+settings" },
    { "^([Rr]ofi)$",                                            "+settings" },
    { "^(btrfs-assistant)$",                                    "+settings" },
    { "^(timeshift-gtk)$",                                      "+settings" },
    { "^(gnome-system-monitor|org.gnome.SystemMonitor|io.missioncenter.MissionCenter)$", "+viewer" },
    { "^(evince)$",                                             "+viewer" },
    { "^(eog|org.gnome.Loupe)$",                                "+viewer" },
}

local titleTags = {
    { "^(KooL Quick Cheat Sheet)$", "+KooL_Cheat" },
    { "^(KooL Hyprland Settings)$", "+KooL_Settings" },
    { "^(ROG Control)$",            "+settings" },
    { "(Kvantum Manager)",          "+settings" },
}

for _, rule in ipairs(classTags) do
    hl.window_rule({ match = { class = rule[1] }, tag = rule[2] })
end
for _, rule in ipairs(titleTags) do
    hl.window_rule({ match = { title = rule[1] }, tag = rule[2] })
end

-------------------------------------------------------
---- SOME SPECIAL OVERRIDE RULES ----------------------
-------------------------------------------------------

hl.window_rule({ match = { tag = "multimedia_video" }, no_blur = true })
hl.window_rule({ match = { tag = "multimedia_video" }, opacity = "1.0" })
hl.window_rule({ match = { tag = "multimedia" },       no_blur = true })
hl.window_rule({ match = { tag = "multimedia" },       opacity = "1.0" })

--------------
---- POSITION --
--------------

hl.window_rule({ match = { tag = "KooL_Cheat" },    center = true })
hl.window_rule({ match = { tag = "KooL-Settings" }, center = true })
hl.window_rule({ match = { title = "^(ROG Control)$" }, center = true })
hl.window_rule({ match = { title = "^(Keybindings)$" }, center = true })
hl.window_rule({ match = { class = "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$" }, center = true })
hl.window_rule({ match = { class = "^([Ff]erdium)$" }, center = true })

-- Avoid idle for fullscreen apps
hl.window_rule({ match = { fullscreen = true }, idle_inhibit = "fullscreen" })

------------
---- FLOAT --
------------

hl.window_rule({ match = { tag = "KooL_Cheat" },    float = true })
hl.window_rule({ match = { tag = "wallpaper" },     float = true, center = true })
hl.window_rule({ match = { tag = "settings" },      float = true, center = true })
hl.window_rule({ match = { tag = "viewer" },        float = true, center = true })
hl.window_rule({ match = { tag = "KooL-Settings" }, float = true, center = true })
hl.window_rule({ match = { class = "([Zz]oom|onedriver|onedriver-launcher)" }, float = true })
hl.window_rule({ match = { class = "(org.gnome.Calculator|qalculate-gtk)" },   float = true })
hl.window_rule({ match = { class = "^(mpv|com.github.rafostar.Clapper)$" },    float = true })
hl.window_rule({ match = { class = "^([Qq]alculate-gtk)$" },                   float = true })
hl.window_rule({ match = { class = "^([Ff]erdium)$" },                         float = true })

-- Popups and dialogues
hl.window_rule({ match = { title = "^(Authentication Required)$" }, float = true, center = true })
hl.window_rule({
    match = { class = "(codium|codium-url-handler|VSCodium)", title = "negative:(.*codium.*|.*VSCodium.*)" },
    float = true,
})
hl.window_rule({
    match = { class = "^(com.heroicgameslauncher.hgl)$", title = "negative:(Heroic Games Launcher)" },
    float = true,
})
hl.window_rule({
    match = { class = "^([Ss]team)$", title = "negative:^([Ss]team)$" },
    float = true,
})
hl.window_rule({
    match = { title = "^(Add Folder to Workspace)$" },
    float  = true,
    size   = { "monitor_w * 0.7", "monitor_h * 0.6" },
    center = true,
})
hl.window_rule({
    match = { title = "^(Save As)$" },
    float  = true,
    size   = { "monitor_w * 0.7", "monitor_h * 0.6" },
    center = true,
})
hl.window_rule({
    match = { initial_title = "(Open Files)" },
    float  = true,
    size   = { "monitor_w * 0.7", "monitor_h * 0.6" },
})
hl.window_rule({
    match  = { title = "^(SDDM Background)$" },
    float  = true,
    center = true,
    size   = { "monitor_w * 0.16", "monitor_h * 0.12" },
})
hl.window_rule({
    match  = { class = "^(yad)$" },
    float  = true,
    center = true,
    size   = { "monitor_w * 0.2", "monitor_h * 0.2" },
})
hl.window_rule({ match = { class = "^(hyprland-donate-screen)$" }, float = true, center = true })

--------------
---- OPACITY --
--------------

hl.window_rule({ match = { tag = "browser" },        opacity = "0.99 0.8" })
hl.window_rule({ match = { tag = "projects" },       opacity = "0.9 0.8" })
hl.window_rule({ match = { tag = "im" },             opacity = "0.94 0.86" })
hl.window_rule({ match = { tag = "multimedia" },     opacity = "0.94 0.86" })
hl.window_rule({ match = { tag = "file-manager" },   opacity = "0.9 0.8" })
hl.window_rule({ match = { tag = "terminal" },       opacity = "0.9 0.7" })
hl.window_rule({ match = { tag = "settings" },       opacity = "0.8 0.7" })
hl.window_rule({ match = { tag = "viewer" },         opacity = "0.82 0.75" })
hl.window_rule({ match = { tag = "wallpaper" },      opacity = "0.9 0.7" })
hl.window_rule({ match = { class = "^(gedit|org.gnome.TextEditor|mousepad)$" }, opacity = "0.8 0.7" })
hl.window_rule({ match = { class = "^(deluge)$" },   opacity = "0.9 0.8" })
hl.window_rule({ match = { class = "^(seahorse)$" }, opacity = "0.9 0.8" })
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, opacity = "0.95 0.75" })

-----------
---- SIZE --
-----------

hl.window_rule({ match = { tag = "KooL_Cheat" }, size = { "monitor_w * 0.65", "monitor_h * 0.9" } })
hl.window_rule({ match = { tag = "wallpaper" },  size = { "monitor_w * 0.7",  "monitor_h * 0.7" } })
hl.window_rule({ match = { tag = "settings" },   size = { "monitor_w * 0.7",  "monitor_h * 0.7" } })
hl.window_rule({ match = { class = "^([Ff]erdium)$" }, size = { "monitor_w * 0.6", "monitor_h * 0.7" } })

-------------------------
---- BLUR / FULLSCREEN --
-------------------------

hl.window_rule({ match = { tag = "games" }, no_blur = true, fullscreen = false })
hl.window_rule({ match = { tag = "games" }, fullscreen = false })

-- This will not take focus to the window that appears when hovering over
-- some parts of the IntelliJ products
hl.window_rule({ match = { class = "^(jetbrains-*)" }, no_initial_focus = true })
hl.window_rule({ match = { title = "^(wind.*)$" },     no_initial_focus = true })

-------------------
---- LAYER RULES --
-------------------

hl.layer_rule({ match = { namespace = "rofi" },   blur = true })
hl.layer_rule({ match = { namespace = "notifications" }, blur = true })
hl.layer_rule({ match = { namespace = "quickshell:overview" }, blur = true })
hl.layer_rule({ match = { namespace = "quickshell:overview" }, ignore_alpha = 0.5 })

------------------------------
---- NAMED SPECIAL CASES -----
------------------------------

hl.window_rule({
    name  = "Whatsapp-zapzap",
    match = { class = "^([Ww]hatsapp-for-linux|ZapZap|com.rtosta.zapzap)$" },
    size   = { "monitor_w * 0.6", "monitor_h * 0.7" },
    center = true,
})

hl.window_rule({
    name  = "Picture-in-Picture",
    match = { title = "^(Picture-in-Picture)$" },
    float  = true,
    move   = "72% 7%",
    opacity = "0.95 0.75",
    pin    = true,
    keep_aspect_ratio = true,
    size   = { "monitor_w * 0.3", "monitor_h * 0.3" },
})

-- Thunar copy progress dialog
hl.window_rule({
    name  = "Thunar-Progress-bar",
    match = { class = "^([Tt]hunar)$", title = "^(File Operation Progress)$" },
    float  = true,
    center = true,
    size   = { "monitor_w * 0.26", "monitor_h * 0.18" },
})
