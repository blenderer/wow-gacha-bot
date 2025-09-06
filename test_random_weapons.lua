#!/usr/bin/env lua
-- Test script to get 10 random weapons from WeaponsDB

-- Load the WeaponsDB module
local WeaponsDB = require("WeaponsDB")

-- Function to print weapon info
local function printWeapon(weapon, index)
    if weapon then
        print(string.format("%d. %s", index, weapon.name))
        print(string.format("   Type: %s | Quality: %s | Level: %d | TBC: %s",
            weapon.subclass_name,
            weapon.quality_name,
            weapon.required_level,
            weapon.is_tbc and "Yes" or "No"
        ))
        if weapon.damage and #weapon.damage > 0 then
            local dmg = weapon.damage[1]
            print(string.format("   Damage: %d-%d", dmg.min, dmg.max))
        end
        print("")
    else
        print(string.format("%d. No weapon found", index))
    end
end

-- Main test function
local function testRandomWeapons()
    print("=== Testing 10 Random Weapons from WeaponsDB ===")
    print("")

    -- Test basic random weapons
    for i = 1, 5 do
        local weapon = WeaponsDB:GetRandomWeapon()
        printWeapon(weapon, i)
    end

    -- print("2. Random Epic Weapons:")
    -- for i = 1, 3 do
    --     local weapon = WeaponsDB:GetRandomWeaponByQuality(4) -- Epic quality
    --     printWeapon(weapon, i)
    -- end

    -- print("3. Random TBC Weapons:")
    -- for i = 1, 2 do
    --     local weapon = WeaponsDB:GetRandomTBCWeapon()
    --     printWeapon(weapon, i)
    -- end
end

-- Run the test
testRandomWeapons()
