--[[
    - Special thanks to Indragie Karunaratne (https://www.indragie.com) the man behind Snap :
    > https://apps.apple.com/ch/app/snap/id418073146
    the app that inspired me to build this script.

    - This hammerspoon config assigns hotkeys to apps, similar to what you can do in Windows 10
    and onwards where WindowsKey+1 would launch, unminimize or hide the 1st pinned app in the
    windows taskbard, WindowsKey+2 the second and so on, with the exception that this script's
    functionality is not bound to the location of the app in the dock but it can be any app.

    - Initially developed in AppleScript but moved to Hammersppon since it requires to trap
    hotkeys before any app can capture the keystroke.
    Only tested against the apps configured in this scripts but in theory it can be extended
    to any app.

    - Tested on: MacOS Tahoe 21.1ulti

    - WIP: Fix behavior for multiple virtual desktops
--]]

local function toggleApp(appName)

    -- Used for apps with different process name than bundle name
    -- eg iTerm vs iTerm2 process name
    hs.application.enableSpotlightForNameSearches(true)

    local app = hs.application.get(appName)

    if not app then
        print(appName .. " not running: launchOrFocus")
        hs.application.launchOrFocus(appName)
        return
    end

    local windows = app:allWindows()
    local mainWin = app:mainWindow()

    if app:isFrontmost() then
        -- Special case you close the last remaining window of iTerm where iTerm
        -- process is in the foreground but with no active windows
        -- In this edge case pressing the hotkey again would run the `app:hide()`
        -- if it was wrapped around this if conditional
        if #windows == 0 then
            print(appName .. " running in focus with " .. #windows .. " windows: launchOrFocus")
            hs.application.launchOrFocus(appName)
        else
            if appName == "Finder" and #windows == 1 then
                print(appName .. " running in focus with " .. #windows .. " windows: launchOrFocus")
                hs.application.launchOrFocus(appName)
            else
                print(appName .. " running in focus with " .. #windows .. " windows: minimize")
                app:hide()
            end
        end
    else
        -- If windows exist, unminimize and activate; else create a new window
        if mainWin then
            print(appName .. " running out of focus: unminimize & activate")
            mainWin:unminimize()
            app:activate()
        else
            print(appName .. " running out of focus with 0 windows: launchOrFocus")
            hs.application.launchOrFocus(appName)
        end
    end
end

hs.hotkey.bind("alt", "1", function()
    toggleApp("Slack")
end)

hs.hotkey.bind("alt", "2", function()
    toggleApp("iTerm")
end)

hs.hotkey.bind("command", "e", function()
    toggleApp("Finder")
end)
