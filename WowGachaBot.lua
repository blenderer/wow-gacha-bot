-- WowGachaBot - A gacha bot addon for World of Warcraft Classic
-- Supports both Era and Anniversary realms

local WowGachaBot = CreateFrame("Frame")
local addonName = "WowGachaBot"

-- Database initialization - must be first
WowGachaBotDB = WowGachaBotDB or {}
WowGachaBotDB.enabled = WowGachaBotDB.enabled or true
WowGachaBotDB.debug = WowGachaBotDB.debug or false
WowGachaBotDB.inventories = WowGachaBotDB.inventories or {}
WowGachaBotDB.settings = WowGachaBotDB.settings or {
    maxInventorySize = 50,
    showInventoryOnOpen = true
}

-- WeaponsDB will be loaded as a global variable

-- Configuration - use database values
local config = {
    enabled = function() return WowGachaBotDB.enabled end,
    debug = function() return WowGachaBotDB.debug end
}

-- Debug function - must be defined early
local function debug(msg)
    -- Safety check in case config is not properly initialized
    local debugEnabled = false
    if WowGachaBotDB and WowGachaBotDB.debug then
        debugEnabled = WowGachaBotDB.debug
    end

    if debugEnabled then
        print("[" .. addonName .. "] " .. tostring(msg))
    end
end

-- Ensure database is properly initialized
local function ensureDatabaseInitialized()
    if not WowGachaBotDB then
        WowGachaBotDB = {}
    end
    if not WowGachaBotDB.inventories then
        WowGachaBotDB.inventories = {}
    end
    if not WowGachaBotDB.settings then
        WowGachaBotDB.settings = {
            maxInventorySize = 50,
            showInventoryOnOpen = true
        }
    end
    if WowGachaBotDB.enabled == nil then
        WowGachaBotDB.enabled = true
    end
    if WowGachaBotDB.debug == nil then
        WowGachaBotDB.debug = false
    end
end

-- Inventory management functions
local function getPlayerInventory(playerName)
    debug("Getting inventory for player: " .. tostring(playerName))
    debug("WowGachaBotDB.inventories exists: " .. tostring(WowGachaBotDB.inventories ~= nil))

    if not WowGachaBotDB.inventories[playerName] then
        debug("Creating new inventory for player: " .. tostring(playerName))
        WowGachaBotDB.inventories[playerName] = {
            items = {},
            totalOpens = 0,
            lastOpen = time()
        }
    end
    return WowGachaBotDB.inventories[playerName]
end

local function addItemToInventory(playerName, weapon)
    debug("Adding item to inventory for player: " .. tostring(playerName))
    debug("Weapon name: " .. tostring(weapon and weapon.name or "nil"))

    -- Ensure database is properly initialized
    ensureDatabaseInitialized()

    local inventory = getPlayerInventory(playerName)

    -- Check if inventory is full
    local maxSize = WowGachaBotDB.settings.maxInventorySize or 50
    if #inventory.items >= maxSize then
        -- Remove oldest item (FIFO)
        table.remove(inventory.items, 1)
    end

    -- Add new item with timestamp
    local itemData = {
        weapon = weapon,
        timestamp = time(),
        id = #inventory.items + 1
    }

    table.insert(inventory.items, itemData)
    inventory.totalOpens = inventory.totalOpens + 1
    inventory.lastOpen = time()

    debug("Added " .. weapon.name .. " to " .. playerName .. "'s inventory")
end

local function getPlayerName()
    return UnitName("player")
end

-- Inventory UI
local inventoryFrame = nil

local function createInventoryWindow()
    if inventoryFrame then
        return inventoryFrame
    end

    -- Create main frame
    inventoryFrame = CreateFrame("Frame", "WowGachaBotInventoryFrame", UIParent, "BasicFrameTemplateWithInset")
    inventoryFrame:SetSize(400, 300)
    inventoryFrame:SetPoint("CENTER")
    inventoryFrame:SetFrameStrata("HIGH")
    inventoryFrame:SetMovable(true)
    inventoryFrame:EnableMouse(true)
    inventoryFrame:RegisterForDrag("LeftButton")
    inventoryFrame:SetScript("OnDragStart", inventoryFrame.StartMoving)
    inventoryFrame:SetScript("OnDragStop", inventoryFrame.StopMovingOrSizing)
    inventoryFrame:Hide()

    -- Title
    local title = inventoryFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    title:SetPoint("TOP", 0, -10)
    title:SetText("Gacha Inventory")

    -- Scroll frame
    local scrollFrame = CreateFrame("ScrollFrame", nil, inventoryFrame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 10, -30)
    scrollFrame:SetPoint("BOTTOMRIGHT", -30, 10)

    -- Content frame
    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(350, 1)
    scrollFrame:SetScrollChild(content)

    -- Store references
    inventoryFrame.scrollFrame = scrollFrame
    inventoryFrame.content = content
    inventoryFrame.title = title

    return inventoryFrame
end

local function showInventoryWindow(playerName)
    local frame = createInventoryWindow()
    local inventory = getPlayerInventory(playerName)

    -- Clear existing content
    local content = frame.content
    for i = 1, content:GetNumChildren() do
        local child = select(i, content:GetChildren())
        if child then
            child:Hide()
            child:SetParent(nil)
        end
    end

    -- Update title
    frame.title:SetText("Gacha Inventory - " .. playerName .. " (" .. #inventory.items .. " items)")

    -- Add items
    local yOffset = 0
    for i, itemData in ipairs(inventory.items) do
        local weapon = itemData.weapon

        -- Create item frame
        local itemFrame = CreateFrame("Frame", nil, content)
        itemFrame:SetSize(350, 20)
        itemFrame:SetPoint("TOPLEFT", 0, -yOffset)

        -- Item link
        local itemLink
        if weapon.special_effect == "rainbow" then
            itemLink = "|cffff0000|Hitem:" .. weapon.item_id .. ":0:0:0:0:0:0:0|h[" .. weapon.name .. "]|h|r (RAINBOW)"
        elseif weapon.special_effect == "shiny" then
            itemLink = "|cff87ceeb|Hitem:" .. weapon.item_id .. ":0:0:0:0:0:0:0|h[" .. weapon.name .. "]|h|r (SHINY)"
        elseif weapon.special_effect == "golden" then
            itemLink = "|cffffd700|Hitem:" .. weapon.item_id .. ":0:0:0:0:0:0:0|h[" .. weapon.name .. "]|h|r (GOLDEN)"
        else
            itemLink = "|c" ..
                (weapon.quality_color or "ff9d9d9d") ..
                "|Hitem:" .. weapon.item_id .. ":0:0:0:0:0:0:0|h[" .. weapon.name .. "]|h|r"
        end

        -- Item text
        local itemText = itemFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        itemText:SetPoint("LEFT", 5, 0)
        itemText:SetText(itemLink)
        itemText:SetJustifyH("LEFT")

        -- Timestamp
        local timeText = itemFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        timeText:SetPoint("RIGHT", -5, 0)
        timeText:SetText(date("%H:%M", itemData.timestamp))
        timeText:SetTextColor(0.7, 0.7, 0.7)

        yOffset = yOffset + 20
    end

    -- Update content height
    content:SetHeight(math.max(250, yOffset))

    -- Show frame
    frame:Show()
end

-- String utility function
local function trim(s)
    return s:match("^%s*(.-)%s*$")
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

        -- Add weapon to player's inventory
        local playerName = getPlayerName()
        addItemToInventory(playerName, weapon)

        -- Send the item link to chat
        SendChatMessage(itemLink, "SAY")

        -- Also print to chat frame for confirmation
        print("[" .. addonName .. "] " .. itemLink)

        -- Show inventory if setting is enabled
        local showInventory = WowGachaBotDB.settings and WowGachaBotDB.settings.showInventoryOnOpen
        if showInventory then
            showInventoryWindow(playerName)
        end
    else
        -- Fallback if no weapon found
        SendChatMessage("No weapon found!", "SAY")
        print("[" .. addonName .. "] No weapon found!")
    end
end

-- Event handler for chat messages
local function OnEvent(self, event, ...)
    if not config.enabled() then
        return
    end
    if event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER" or event == "CHAT_MSG_SAY" then
        local message, sender = ...


        -- Check if the message is "!open" (case insensitive)
        if message and string.lower(trim(message)) == "!open" then
            debug("Detected !open command from " .. (sender or "unknown"))
            handleOpenCommand()
        end
    end
end

-- Initialize the addon
local function InitializeAddon()
    print("Initializing " .. addonName)

    -- Ensure database is properly initialized
    ensureDatabaseInitialized()

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
    local command = string.lower(trim(msg))

    if command == "toggle" then
        WowGachaBotDB.enabled = not WowGachaBotDB.enabled
        print("[" .. addonName .. "] " .. (WowGachaBotDB.enabled and "Enabled" or "Disabled"))
    elseif command == "debug" then
        WowGachaBotDB.debug = not WowGachaBotDB.debug
        print("[" .. addonName .. "] Debug mode " .. (WowGachaBotDB.debug and "enabled" or "disabled"))
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
    elseif command == "inventory" or command == "inv" then
        local playerName = getPlayerName()
        showInventoryWindow(playerName)
    elseif command == "clear" then
        local playerName = getPlayerName()
        WowGachaBotDB.inventories[playerName] = {
            items = {},
            totalOpens = 0,
            lastOpen = time()
        }
        print("[" .. addonName .. "] Cleared " .. playerName .. "'s inventory")
    elseif command == "stats" then
        local playerName = getPlayerName()
        local inventory = getPlayerInventory(playerName)
        print("[" .. addonName .. "] " .. playerName .. "'s Stats:")
        print("  Total Opens: " .. inventory.totalOpens)
        print("  Items in Inventory: " .. #inventory.items)
        print("  Last Open: " .. date("%Y-%m-%d %H:%M:%S", inventory.lastOpen))
    elseif command == "autoshow" then
        -- Ensure settings exist
        if not WowGachaBotDB.settings then
            WowGachaBotDB.settings = {
                maxInventorySize = 50,
                showInventoryOnOpen = true
            }
        end
        WowGachaBotDB.settings.showInventoryOnOpen = not WowGachaBotDB.settings.showInventoryOnOpen
        print("[" ..
            addonName ..
            "] Auto-show inventory " .. (WowGachaBotDB.settings.showInventoryOnOpen and "enabled" or "disabled"))
    elseif command == "dbinfo" then
        print("[" .. addonName .. "] Database Info:")
        print("  WowGachaBotDB exists: " .. tostring(WowGachaBotDB ~= nil))
        print("  inventories exists: " .. tostring(WowGachaBotDB.inventories ~= nil))
        print("  settings exists: " .. tostring(WowGachaBotDB.settings ~= nil))
        if WowGachaBotDB.inventories then
            local count = 0
            for k, v in pairs(WowGachaBotDB.inventories) do
                count = count + 1
            end
            print("  Number of player inventories: " .. count)
        end
    elseif command == "help" or command == "" then
        print("[" .. addonName .. "] Commands:")
        print("  /wgb toggle - Enable/disable the addon")
        print("  /wgb debug - Toggle debug mode")
        print("  /wgb test - Test the !open command (get random weapon)")
        print("  /wgb testmode - Toggle high-chance special effects mode")
        print("  /wgb normal - Set normal special effects rates")
        print("  /wgb inventory - Show your gacha inventory")
        print("  /wgb clear - Clear your inventory")
        print("  /wgb stats - Show your gacha statistics")
        print("  /wgb autoshow - Toggle auto-show inventory on open")
        print("  /wgb dbinfo - Show database debug information")
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
