#!/usr/bin/env lua
-- Test script to get 10 random weapons from WeaponsDB

-- Load the WeaponsDB module
dofile("WeaponsDB.lua")
local WeaponsDB = _G.WeaponsDB

-- ANSI color codes for terminal output
local colors = {
    reset = "\27[0m",
    bright = "\27[1m",
    dim = "\27[2m",
    red = "\27[31m",
    green = "\27[32m",
    yellow = "\27[33m",
    blue = "\27[34m",
    magenta = "\27[35m",
    cyan = "\27[36m",
    white = "\27[37m",
    gray = "\27[90m"
}

-- Function to convert WoW color code to ANSI color
local function wowColorToAnsi(qualityColor)
    if not qualityColor then return colors.white end

    -- Convert hex color to ANSI (simplified mapping)
    local colorMap = {
        ["ff9d9d9d"] = colors.gray,    -- Poor (Gray)
        ["ffffffff"] = colors.white,   -- Common (White)
        ["ff1eff00"] = colors.green,   -- Uncommon (Green)
        ["ff0070dd"] = colors.blue,    -- Rare (Blue)
        ["ffa335ee"] = colors.magenta, -- Epic (Purple)
        ["ffff8000"] = colors.yellow,  -- Legendary (Orange)
        ["ffe6cc80"] = colors.cyan     -- Artifact (Gold)
    }

    return colorMap[qualityColor] or colors.white
end

-- Function to get special effect display info
local function getSpecialEffectDisplay(specialEffect)
    if not specialEffect then
        return "", ""
    end

    local effectMap = {
        ["shiny"] = { symbol = "*", color = colors.white, name = "Shiny" },
        ["rainbow"] = { symbol = "~", color = colors.magenta, name = "Rainbow" },
        ["golden"] = { symbol = "+", color = colors.yellow, name = "Golden" }
    }

    local effect = effectMap[specialEffect]
    if effect then
        return effect.symbol, effect.color, effect.name
    end

    return "", "", ""
end

-- Function to print weapon info with colors
local function printWeapon(weapon, index)
    if weapon then
        local qualityColor = wowColorToAnsi(weapon.quality_color)
        local tbcColor = weapon.is_tbc and colors.cyan or colors.dim

        -- Get special effect display info
        local effectSymbol, effectColor, effectName = getSpecialEffectDisplay(weapon.special_effect)

        -- Build weapon name with special effect
        local weaponDisplayName = weapon.name
        if effectSymbol ~= "" then
            weaponDisplayName = string.format("%s %s%s%s", effectSymbol, effectColor, weapon.name, colors.reset)
        end

        print(string.format("%s%d. %s%s%s",
            colors.bright, index, qualityColor, weaponDisplayName, colors.reset))

        -- Build quality line with special effect
        local qualityLine = string.format("   %sType:%s %s | %sQuality:%s %s%s%s | %sLevel:%s %d | %sTBC:%s %s%s%s",
            colors.dim, colors.reset, weapon.subclass_name,
            colors.dim, colors.reset, qualityColor, weapon.quality_name, colors.reset,
            colors.dim, colors.reset, weapon.required_level,
            colors.dim, colors.reset, tbcColor, weapon.is_tbc and "Yes" or "No", colors.reset
        )

        if effectSymbol ~= "" then
            qualityLine = qualityLine .. string.format(" | %sEffect:%s %s%s%s",
                colors.dim, colors.reset, effectColor, effectName, colors.reset)
        end

        print(qualityLine)

        if weapon.damage and #weapon.damage > 0 then
            local dmg = weapon.damage[1]
            print(string.format("   %sDamage:%s %d-%d",
                colors.dim, colors.reset, dmg.min, dmg.max))
        end
        print("")
    else
        print(string.format("%s%d. %sNo weapon found%s",
            colors.bright, index, colors.red, colors.reset))
    end
end

-- Main test function
local function testRandomWeapons()
    print(string.format("%s=== Testing Gacha Distribution (10%% Epic, 30%% Rare, 30%% Uncommon, 30%% Common) ===%s",
        colors.bright, colors.reset))
    print("")

    local qualityCounts = { [1] = 0, [2] = 0, [3] = 0, [4] = 0 }
    local qualityNames = { [1] = "Common", [2] = "Uncommon", [3] = "Rare", [4] = "Epic" }
    local effectCounts = { shiny = 0, rainbow = 0, golden = 0, none = 0 }

    -- Test 100 weapons to see distribution
    print(string.format("%sTesting 100 weapons to verify distribution:%s", colors.cyan, colors.reset))
    for i = 1, 100 do
        local weapon = WeaponsDB:GetRandomWeapon()
        if weapon then
            qualityCounts[weapon.quality] = qualityCounts[weapon.quality] + 1
            if weapon.special_effect then
                effectCounts[weapon.special_effect] = effectCounts[weapon.special_effect] + 1
            else
                effectCounts.none = effectCounts.none + 1
            end
        end
    end

    -- Print distribution results
    for quality = 1, 4 do
        local count = qualityCounts[quality]
        local percentage = math.floor((count / 100) * 100)
        local color = wowColorToAnsi(_G.qualityColors[quality])
        print(string.format("  %s%s:%s %d%% (%d/100)",
            color, qualityNames[quality], colors.reset, percentage, count))
    end

    print("")
    print(string.format("%sSpecial Effects Distribution:%s", colors.cyan, colors.reset))
    local effectNames = { shiny = "Shiny", rainbow = "Rainbow", golden = "Golden", none = "None" }
    local effectColors = { shiny = colors.white, rainbow = colors.magenta, golden = colors.yellow, none = colors.dim }
    for effect, count in pairs(effectCounts) do
        local percentage = math.floor((count / 100) * 100)
        local color = effectColors[effect]
        print(string.format("  %s%s:%s %d%% (%d/100)",
            color, effectNames[effect], colors.reset, percentage, count))
    end

    print("")
    print(string.format("%s=== Sample 10 Random Weapons ===%s", colors.bright, colors.reset))
    print("")

    -- Test basic random weapons
    for i = 1, 10 do
        local weapon = WeaponsDB:GetRandomWeapon()
        if weapon then
            printWeapon(weapon, i)
        else
            print(string.format("%s%d. %sNo weapon found%s",
                colors.bright, i, colors.red, colors.reset))
        end
    end
end

-- Run the test
testRandomWeapons()
