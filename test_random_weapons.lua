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

-- Function to print weapon info with colors
local function printWeapon(weapon, index)
    if weapon then
        local qualityColor = wowColorToAnsi(weapon.quality_color)
        local tbcColor = weapon.is_tbc and colors.cyan or colors.dim

        print(string.format("%s%d. %s%s%s",
            colors.bright, index, qualityColor, weapon.name, colors.reset))

        print(string.format("   %sType:%s %s | %sQuality:%s %s%s%s | %sLevel:%s %d | %sTBC:%s %s%s%s",
            colors.dim, colors.reset, weapon.subclass_name,
            colors.dim, colors.reset, qualityColor, weapon.quality_name, colors.reset,
            colors.dim, colors.reset, weapon.required_level,
            colors.dim, colors.reset, tbcColor, weapon.is_tbc and "Yes" or "No", colors.reset
        ))

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
    print(string.format("%s=== Testing 10 Random Weapons from WeaponsDB ===%s",
        colors.bright, colors.reset))
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
