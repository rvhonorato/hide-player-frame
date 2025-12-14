--[[
    HidePlayerFrame: Hide player frame except during combat or when targeting

    WoW API REFERENCE:
    All functions like InCombatLockdown(), UnitExists(), CreateFrame(), etc. come from
    the World of Warcraft API - a set of functions Blizzard provides for addon development.

    Documentation sources:
    - Warcraft Wiki: https://warcraft.wiki.gg/wiki/World_of_Warcraft_API
    - Wowpedia: https://wowpedia.fandom.com/wiki/World_of_Warcraft_API

    Key API functions used in this addon:
    - InCombatLockdown(): Returns true if player is in combat
    - UnitExists("target"): Returns true if the specified unit exists (e.g., "target", "player", "party1")
    - PlayerFrame: Global frame object for the player unit frame
    - CreateFrame("Frame"): Creates a new frame object for event handling
    - RegisterEvent("EVENT_NAME"): Registers the frame to listen for specific game events
    - SetScript("OnEvent", function): Sets a callback function to run when events fire
    - print(): Outputs text to the chat window
    - SavedVariables: Persistent storage across game sessions (defined in .toc file)

    Events used:
    - PLAYER_REGEN_DISABLED: Fires when entering combat
    - PLAYER_REGEN_ENABLED: Fires when leaving combat
    - PLAYER_TARGET_CHANGED: Fires when you change your target
    - ADDON_LOADED: Fires when an addon is loaded (including on /reload)

    Full event list: https://warcraft.wiki.gg/wiki/Events
--]]

-- Will be initialized when ADDON_LOADED fires
local autoHideEnabled = false

local function UpdatePlayerFrame()
	if autoHideEnabled then
		if InCombatLockdown() or UnitExists("target") then
			PlayerFrame:Show()
		else
			PlayerFrame:Hide()
		end
	else
		PlayerFrame:Show()
	end
end

local function ToggleAutoHide()
	autoHideEnabled = not autoHideEnabled
	HidePlayerFrameDB.enabled = autoHideEnabled -- Save state
	if autoHideEnabled then
		print("Auto-hide enabled. Player frame will show in combat or when targeting.")
	else
		print("Auto-hide disabled. Player frame always visible.")
	end
	UpdatePlayerFrame()
end

-- Create event frame
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED") -- Entering combat
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED") -- Leaving combat
eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED") -- Target changed
eventFrame:RegisterEvent("ADDON_LOADED") -- Fires on load and /reload

eventFrame:SetScript("OnEvent", function(self, event, addonName)
	if event == "ADDON_LOADED" and addonName == "hide-player-frame" then
		-- Initialize saved variables (only available after ADDON_LOADED)
		HidePlayerFrameDB = HidePlayerFrameDB or {}
		autoHideEnabled = HidePlayerFrameDB.enabled or false
		-- Apply saved state when addon loads
		UpdatePlayerFrame()
	elseif event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_TARGET_CHANGED" then
		UpdatePlayerFrame()
	end
end)

-- Register slash command
SLASH_HPF1 = "/hpf"
SlashCmdList["HPF"] = function(msg)
	ToggleAutoHide()
end

print("HidePlayerFrame loaded. Use /hpf to toggle auto-hide.")
