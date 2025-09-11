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

-- Function to create rainbow colored text
local function createRainbowText(text)
    local rainbowColors = {
        "ffff0000", -- Red
        "ffff8000", -- Orange
        "ffffff00", -- Yellow
        "ff00ff00", -- Green
        "ff00ffff", -- Cyan
        "ff0080ff", -- Blue
        "ff8000ff", -- Purple
        "ffff00ff"  -- Magenta
    }

    local result = ""
    local colorIndex = 1

    for i = 1, #text do
        local char = text:sub(i, i)
        local color = rainbowColors[colorIndex]
        result = result .. "|c" .. color .. char .. "|r"
        colorIndex = colorIndex + 1
        if colorIndex > #rainbowColors then
            colorIndex = 1
        end
    end

    return result
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
        -- Create item link using the item ID
        local itemLink
        if weapon.special_effect == "rainbow" then
            -- For rainbow, use a special color that stands out
            itemLink = "|cffff00ff|Hitem:" .. weapon.item_id .. ":0:0:0:0:0:0:0|h[" .. weapon.name .. "]|h|r"
        elseif weapon.special_effect == "golden" then
            -- Create golden colored item link
            itemLink = "|cffffd700|Hitem:" .. weapon.item_id .. ":0:0:0:0:0:0:0|h[" .. weapon.name .. "]|h|r"
        elseif weapon.special_effect == "shiny" then
            -- Create shiny colored item link
            itemLink = "|cffffffff|Hitem:" .. weapon.item_id .. ":0:0:0:0:0:0:0|h[" .. weapon.name .. "]|h|r"
        else
            -- Use normal quality color
            itemLink = "|c" ..
                (weapon.quality_color or "ff9d9d9d") ..
                "|Hitem:" .. weapon.item_id .. ":0:0:0:0:0:0:0|h[" .. weapon.name .. "]|h|r"
        end

        -- Add special effect formatting with colors and text
        if weapon.special_effect == "rainbow" then
            -- Rainbow: red color with (RAINBOW) suffix
            itemLink = "|cffff0000|Hitem:" ..
                weapon.item_id .. ":0:0:0:0:0:0:0|h[" .. weapon.name .. "]|h|r (RAINBOW)"
        elseif weapon.special_effect == "shiny" then
            -- Shiny: lighter blue color with (SHINY) suffix
            itemLink = "|cff87ceeb|Hitem:" .. weapon.item_id .. ":0:0:0:0:0:0:0|h[" .. weapon.name .. "]|h|r (SHINY)"
        elseif weapon.special_effect == "golden" then
            -- Golden: gold color with (GOLDEN) suffix
            itemLink = "|cffffd700|Hitem:" .. weapon.item_id .. ":0:0:0:0:0:0:0|h[" .. weapon.name .. "]|h|r (GOLDEN)"
        end

        -- Send the item link to chat
        SendChatMessage(itemLink, "SAY")

        -- Also print to chat frame for confirmation
        print("[" .. addonName .. "] " .. itemLink)
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
    elseif command == "testmode" or command == "highchance" then
        if WeaponsDB then
            WeaponsDB:ToggleTestMode()
        else
            print("[" .. addonName .. "] WeaponsDB not loaded!")
        end
    elseif command == "normal" then
        if WeaponsDB then
            WeaponsDB:SetTestMode(false)
        else
            print("[" .. addonName .. "] WeaponsDB not loaded!")
        end
    elseif command == "help" or command == "" then
        print("[" .. addonName .. "] Commands:")
        print("  /wgb toggle - Enable/disable the addon")
        print("  /wgb debug - Toggle debug mode")
        print("  /wgb test - Test the !open command (get random weapon)")
        print("  /wgb testmode - Toggle high-chance special effects mode")
        print("  /wgb normal - Set normal special effects rates")
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
