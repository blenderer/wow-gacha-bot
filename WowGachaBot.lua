-- WowGachaBot - A gacha bot addon for World of Warcraft Classic
-- Supports both Era and Anniversary realms

local WowGachaBot = CreateFrame("Frame")
local addonName = "WowGachaBot"

-- Database initialization
WowGachaBotDB = WowGachaBotDB or {}

-- WeaponsDB will be loaded as a global variable

-- Configuration
local config = {
    enabled = true,
    debug = false
}

-- Debug function
local function debug(msg)
    if config.debug then
        print("[" .. addonName .. "] " .. tostring(msg))
    end
end

-- Main function to handle the !open command
local function handleOpenCommand()
    debug("Handling !open command")

    -- Check if WeaponsDB is loaded
    if not WeaponsDB then
        SendChatMessage("WeaponsDB not loaded!", "SAY")
        print("[" .. addonName .. "] WeaponsDB not loaded!")
        return
    end

    -- Get a random weapon from the database
    local weapon = WeaponsDB:GetRandomWeapon()

    if weapon and weapon.name then
        -- Send the weapon name to chat
        SendChatMessage(weapon.name, "SAY")

        -- Also print to chat frame for confirmation
        print("[" .. addonName .. "] " .. weapon.name)
    else
        -- Fallback if no weapon found
        SendChatMessage("No weapon found!", "SAY")
        print("[" .. addonName .. "] No weapon found!")
    end
end

-- Event handler for chat messages
local function OnEvent(self, event, ...)
    if not config.enabled then
        return
    end
    if event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER" or event == "CHAT_MSG_SAY" then
        local message, sender = ...


        -- Check if the message is "!open" (case insensitive)
        if message and string.lower(string.trim(message)) == "!open" then
            debug("Detected !open command from " .. (sender or "unknown"))
            handleOpenCommand()
        end
    end
end

-- Initialize the addon
local function InitializeAddon()
    print("Initializing " .. addonName)

    -- Register events
    WowGachaBot:RegisterEvent("CHAT_MSG_PARTY")
    WowGachaBot:RegisterEvent("CHAT_MSG_PARTY_LEADER")
    WowGachaBot:RegisterEvent("CHAT_MSG_SAY")

    -- Set event handler
    WowGachaBot:SetScript("OnEvent", OnEvent)

    -- Print initialization message
    print("[" .. addonName .. "] Loaded successfully! Type !open in party chat to get a random weapon.")
end

-- Slash command handler
SLASH_WOWGACHABOT1 = "/wgb"
SLASH_WOWGACHABOT2 = "/wowgachabot"

SlashCmdList["WOWGACHABOT"] = function(msg)
    local command = string.lower(string.trim(msg))

    if command == "toggle" then
        config.enabled = not config.enabled
        print("[" .. addonName .. "] " .. (config.enabled and "Enabled" or "Disabled"))
    elseif command == "debug" then
        config.debug = not config.debug
        print("[" .. addonName .. "] Debug mode " .. (config.debug and "enabled" or "disabled"))
    elseif command == "test" then
        handleOpenCommand()
    elseif command == "help" or command == "" then
        print("[" .. addonName .. "] Commands:")
        print("  /wgb toggle - Enable/disable the addon")
        print("  /wgb debug - Toggle debug mode")
        print("  /wgb test - Test the !open command (get random weapon)")
        print("  /wgb help - Show this help")
        print("  !open - Get a random weapon (works in party/say chat)")
    else
        print("[" .. addonName .. "] Unknown command. Type /wgb help for available commands.")
    end
end

-- Initialize when addon loads
WowGachaBot:RegisterEvent("ADDON_LOADED")
WowGachaBot:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local loadedAddonName = ...
        if loadedAddonName == addonName then
            InitializeAddon()
            self:UnregisterEvent("ADDON_LOADED")
        end
    else
        OnEvent(self, event, ...)
    end
end)
