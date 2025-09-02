-- WowGachaBot - A gacha bot addon for World of Warcraft Classic
-- Supports both Era and Anniversary realms

local WowGachaBot = CreateFrame("Frame")
local addonName = "WowGachaBot"

-- Database initialization
WowGachaBotDB = WowGachaBotDB or {}

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
    
    -- Send "hello world" message to chat
    SendChatMessage("Hello World!", "PARTY")
    
    -- Also print to chat frame for confirmation
    print("[" .. addonName .. "] Hello World!")
end

-- Event handler for chat messages
local function OnEvent(self, event, ...)
    if not config.enabled then
        return
    end
    
    if event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER" then
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
    debug("Initializing " .. addonName)
    
    -- Register events
    WowGachaBot:RegisterEvent("CHAT_MSG_PARTY")
    WowGachaBot:RegisterEvent("CHAT_MSG_PARTY_LEADER")
    
    -- Set event handler
    WowGachaBot:SetScript("OnEvent", OnEvent)
    
    -- Print initialization message
    print("[" .. addonName .. "] Loaded successfully! Type !open in party chat to test.")
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
        print("  /wgb test - Test the !open command")
        print("  /wgb help - Show this help")
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

-- Export for external access
_G.WowGachaBot = WowGachaBot
