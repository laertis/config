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
