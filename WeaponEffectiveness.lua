-- Classic WoW Weapon Effectiveness Chart
-- Pokemon-Style Type Matchups - Fair Distribution
-- Tighter range: 0.75 to 1.25

local WeaponEffectiveness = {
    -- Effectiveness Legend:
    -- [1.25] Super Effective - Highly effective against this weapon type
    -- [1.1]  Effective - Moderately effective against this weapon type
    -- [1.0]  Normal - Standard effectiveness
    -- [0.9]  Not Very Effective - Less effective against this weapon type
    -- [0.75] No Effect - Ineffective against this weapon type

    -- Weapon type indices for reference:
    -- 1 = Bow, 2 = Crossbow, 3 = Gun, 4 = Wand, 5 = Thrown
    -- 6 = Sword(1H), 7 = Sword(2H), 8 = Axe(1H), 9 = Axe(2H)
    -- 10 = Mace(1H), 11 = Mace(2H), 12 = Dagger, 13 = Staff, 14 = Polearm, 15 = Fist

    effectiveness = {
        -- Bow vs all weapon types (2x 0.75, 4x 0.9, 1x 1.0, 5x 1.1, 3x 1.25)
        [1] = {
            [1] = 1.0,  -- vs Bow
            [2] = 1.25, -- vs Crossbow
            [3] = 0.9,  -- vs Gun
            [4] = 1.1,  -- vs Wand
            [5] = 0.75, -- vs Thrown
            [6] = 1.1,  -- vs Sword(1H)
            [7] = 0.75, -- vs Sword(2H)
            [8] = 1.25, -- vs Axe(1H)
            [9] = 0.9,  -- vs Axe(2H)
            [10] = 1.1, -- vs Mace(1H)
            [11] = 0.9, -- vs Mace(2H)
            [12] = 1.1, -- vs Dagger
            [13] = 0.9, -- vs Staff
            [14] = 1.1, -- vs Polearm
            [15] = 1.25 -- vs Fist
        },

        -- Crossbow vs all weapon types (3x 0.75, 2x 0.9, 1x 1.0, 6x 1.1, 3x 1.25)
        [2] = {
            [1] = 0.9,   -- vs Bow
            [2] = 1.0,   -- vs Crossbow
            [3] = 1.1,   -- vs Gun
            [4] = 0.75,  -- vs Wand
            [5] = 1.25,  -- vs Thrown
            [6] = 0.9,   -- vs Sword(1H)
            [7] = 1.1,   -- vs Sword(2H)
            [8] = 1.1,   -- vs Axe(1H)
            [9] = 0.75,  -- vs Axe(2H)
            [10] = 1.25, -- vs Mace(1H)
            [11] = 1.1,  -- vs Mace(2H)
            [12] = 1.1,  -- vs Dagger
            [13] = 1.1,  -- vs Staff
            [14] = 0.75, -- vs Polearm
            [15] = 1.25  -- vs Fist
        },

        -- Gun vs all weapon types (2x 0.75, 4x 0.9, 1x 1.0, 5x 1.1, 3x 1.25)
        [3] = {
            [1] = 1.1,   -- vs Bow
            [2] = 0.9,   -- vs Crossbow
            [3] = 1.0,   -- vs Gun
            [4] = 1.25,  -- vs Wand
            [5] = 1.1,   -- vs Thrown
            [6] = 0.75,  -- vs Sword(1H)
            [7] = 1.25,  -- vs Sword(2H)
            [8] = 1.1,   -- vs Axe(1H)
            [9] = 0.9,   -- vs Axe(2H)
            [10] = 0.9,  -- vs Mace(1H)
            [11] = 1.1,  -- vs Mace(2H)
            [12] = 0.9,  -- vs Dagger
            [13] = 1.1,  -- vs Staff
            [14] = 1.25, -- vs Polearm
            [15] = 0.75  -- vs Fist
        },

        -- Wand vs all weapon types (3x each: 0.75, 0.9, 1.0, 1.1, 1.25)
        [4] = {
            [1] = 0.9,   -- vs Bow
            [2] = 1.25,  -- vs Crossbow
            [3] = 0.75,  -- vs Gun
            [4] = 1.0,   -- vs Wand
            [5] = 1.1,   -- vs Thrown
            [6] = 1.25,  -- vs Sword(1H)
            [7] = 0.9,   -- vs Sword(2H)
            [8] = 1.1,   -- vs Axe(1H)
            [9] = 1.1,   -- vs Axe(2H)
            [10] = 0.75, -- vs Mace(1H)
            [11] = 1.1,  -- vs Mace(2H)
            [12] = 1.1,  -- vs Dagger
            [13] = 0.9,  -- vs Staff
            [14] = 0.75, -- vs Polearm
            [15] = 1.25  -- vs Fist
        },

        -- Thrown vs all weapon types (3x each: 0.75, 0.9, 1.0, 1.1, 1.25)
        [5] = {
            [1] = 1.25,  -- vs Bow
            [2] = 0.75,  -- vs Crossbow
            [3] = 0.9,   -- vs Gun
            [4] = 0.9,   -- vs Wand
            [5] = 1.0,   -- vs Thrown
            [6] = 1.1,   -- vs Sword(1H)
            [7] = 0.9,   -- vs Sword(2H)
            [8] = 1.1,   -- vs Axe(1H)
            [9] = 1.25,  -- vs Axe(2H)
            [10] = 0.75, -- vs Mace(1H)
            [11] = 1.1,  -- vs Mace(2H)
            [12] = 1.1,  -- vs Dagger
            [13] = 0.9,  -- vs Staff
            [14] = 1.1,  -- vs Polearm
            [15] = 0.9   -- vs Fist
        },

        -- Sword(1H) vs all weapon types (3x each: 0.75, 0.9, 1.0, 1.1, 1.25)
        [6] = {
            [1] = 0.9,   -- vs Bow
            [2] = 1.1,   -- vs Crossbow
            [3] = 1.25,  -- vs Gun
            [4] = 0.75,  -- vs Wand
            [5] = 0.9,   -- vs Thrown
            [6] = 1.0,   -- vs Sword(1H)
            [7] = 1.1,   -- vs Sword(2H)
            [8] = 0.9,   -- vs Axe(1H)
            [9] = 1.1,   -- vs Axe(2H)
            [10] = 0.9,  -- vs Mace(1H)
            [11] = 1.25, -- vs Mace(2H)
            [12] = 0.75, -- vs Dagger
            [13] = 1.1,  -- vs Staff
            [14] = 1.1,  -- vs Polearm
            [15] = 0.9   -- vs Fist
        },

        -- Sword(2H) vs all weapon types (3x each: 0.75, 0.9, 1.0, 1.1, 1.25)
        [7] = {
            [1] = 1.25,  -- vs Bow
            [2] = 0.9,   -- vs Crossbow
            [3] = 0.75,  -- vs Gun
            [4] = 1.1,   -- vs Wand
            [5] = 1.1,   -- vs Thrown
            [6] = 0.9,   -- vs Sword(1H)
            [7] = 1.0,   -- vs Sword(2H)
            [8] = 1.1,   -- vs Axe(1H)
            [9] = 0.9,   -- vs Axe(2H)
            [10] = 1.1,  -- vs Mace(1H)
            [11] = 0.75, -- vs Mace(2H)
            [12] = 1.25, -- vs Dagger
            [13] = 0.9,  -- vs Staff
            [14] = 1.1,  -- vs Polearm
            [15] = 1.1   -- vs Fist
        },

        -- Axe(1H) vs all weapon types (3x each: 0.75, 0.9, 1.0, 1.1, 1.25)
        [8] = {
            [1] = 0.75,  -- vs Bow
            [2] = 0.9,   -- vs Crossbow
            [3] = 1.1,   -- vs Gun
            [4] = 1.1,   -- vs Wand
            [5] = 1.1,   -- vs Thrown
            [6] = 1.1,   -- vs Sword(1H)
            [7] = 0.9,   -- vs Sword(2H)
            [8] = 1.0,   -- vs Axe(1H)
            [9] = 1.25,  -- vs Axe(2H)
            [10] = 0.75, -- vs Mace(1H)
            [11] = 1.1,  -- vs Mace(2H)
            [12] = 1.1,  -- vs Dagger
            [13] = 0.9,  -- vs Staff
            [14] = 1.25, -- vs Polearm
            [15] = 0.9   -- vs Fist
        },

        -- Axe(2H) vs all weapon types (3x each: 0.75, 0.9, 1.0, 1.1, 1.25)
        [9] = {
            [1] = 1.1,   -- vs Bow
            [2] = 1.25,  -- vs Crossbow
            [3] = 1.1,   -- vs Gun
            [4] = 0.9,   -- vs Wand
            [5] = 0.75,  -- vs Thrown
            [6] = 0.9,   -- vs Sword(1H)
            [7] = 1.1,   -- vs Sword(2H)
            [8] = 0.75,  -- vs Axe(1H)
            [9] = 1.0,   -- vs Axe(2H)
            [10] = 1.1,  -- vs Mace(1H)
            [11] = 0.9,  -- vs Mace(2H)
            [12] = 1.1,  -- vs Dagger
            [13] = 1.25, -- vs Staff
            [14] = 0.75, -- vs Polearm
            [15] = 1.1   -- vs Fist
        },

        -- Mace(1H) vs all weapon types (3x each: 0.75, 0.9, 1.0, 1.1, 1.25)
        [10] = {
            [1] = 1.1,   -- vs Bow
            [2] = 0.75,  -- vs Crossbow
            [3] = 1.1,   -- vs Gun
            [4] = 1.25,  -- vs Wand
            [5] = 1.25,  -- vs Thrown
            [6] = 1.1,   -- vs Sword(1H)
            [7] = 0.9,   -- vs Sword(2H)
            [8] = 1.25,  -- vs Axe(1H)
            [9] = 0.9,   -- vs Axe(2H)
            [10] = 1.0,  -- vs Mace(1H)
            [11] = 1.1,  -- vs Mace(2H)
            [12] = 0.9,  -- vs Dagger
            [13] = 0.75, -- vs Staff
            [14] = 1.1,  -- vs Polearm
            [15] = 0.9   -- vs Fist
        },

        -- Mace(2H) vs all weapon types (3x each: 0.75, 0.9, 1.0, 1.1, 1.25)
        [11] = {
            [1] = 0.9,   -- vs Bow
            [2] = 0.9,   -- vs Crossbow
            [3] = 0.9,   -- vs Gun
            [4] = 1.1,   -- vs Wand
            [5] = 1.1,   -- vs Thrown
            [6] = 0.75,  -- vs Sword(1H)
            [7] = 1.25,  -- vs Sword(2H)
            [8] = 0.9,   -- vs Axe(1H)
            [9] = 1.1,   -- vs Axe(2H)
            [10] = 0.9,  -- vs Mace(1H)
            [11] = 1.0,  -- vs Mace(2H)
            [12] = 1.1,  -- vs Dagger
            [13] = 1.1,  -- vs Staff
            [14] = 0.75, -- vs Polearm
            [15] = 1.25  -- vs Fist
        },

        -- Dagger vs all weapon types (3x each: 0.75, 0.9, 1.0, 1.1, 1.25)
        [12] = {
            [1] = 1.1,   -- vs Bow
            [2] = 1.1,   -- vs Crossbow
            [3] = 1.25,  -- vs Gun
            [4] = 0.9,   -- vs Wand
            [5] = 0.9,   -- vs Thrown
            [6] = 1.25,  -- vs Sword(1H)
            [7] = 0.75,  -- vs Sword(2H)
            [8] = 0.9,   -- vs Axe(1H)
            [9] = 0.9,   -- vs Axe(2H)
            [10] = 1.1,  -- vs Mace(1H)
            [11] = 0.9,  -- vs Mace(2H)
            [12] = 1.0,  -- vs Dagger
            [13] = 1.1,  -- vs Staff
            [14] = 0.75, -- vs Polearm
            [15] = 1.25  -- vs Fist
        },

        -- Staff vs all weapon types (4x 0.75, 2x 0.9, 1x 1.0, 4x 1.1, 4x 1.25)
        [13] = {
            [1] = 0.75,  -- vs Bow
            [2] = 0.9,   -- vs Crossbow
            [3] = 0.9,   -- vs Gun
            [4] = 1.1,   -- vs Wand
            [5] = 1.1,   -- vs Thrown
            [6] = 0.75,  -- vs Sword(1H)
            [7] = 1.1,   -- vs Sword(2H)
            [8] = 1.1,   -- vs Axe(1H)
            [9] = 0.75,  -- vs Axe(2H)
            [10] = 1.25, -- vs Mace(1H)
            [11] = 1.25, -- vs Mace(2H)
            [12] = 1.25, -- vs Dagger
            [13] = 1.0,  -- vs Staff
            [14] = 1.25, -- vs Polearm
            [15] = 0.75  -- vs Fist
        },

        -- Polearm vs all weapon types (3x each: 0.75, 0.9, 1.0, 1.1, 1.25)
        [14] = {
            [1] = 0.9,   -- vs Bow
            [2] = 1.1,   -- vs Crossbow
            [3] = 0.75,  -- vs Gun
            [4] = 1.1,   -- vs Wand
            [5] = 1.1,   -- vs Thrown
            [6] = 0.9,   -- vs Sword(1H)
            [7] = 0.9,   -- vs Sword(2H)
            [8] = 0.75,  -- vs Axe(1H)
            [9] = 1.1,   -- vs Axe(2H)
            [10] = 0.9,  -- vs Mace(1H)
            [11] = 1.1,  -- vs Mace(2H)
            [12] = 1.25, -- vs Dagger
            [13] = 0.75, -- vs Staff
            [14] = 1.0,  -- vs Polearm
            [15] = 1.1   -- vs Fist
        },

        -- Fist Weapon vs all weapon types (4x 0.75, 3x 0.9, 1x 1.0, 4x 1.1, 3x 1.25)
        [15] = {
            [1] = 0.75,  -- vs Bow
            [2] = 0.9,   -- vs Crossbow
            [3] = 1.1,   -- vs Gun
            [4] = 0.75,  -- vs Wand
            [5] = 1.1,   -- vs Thrown
            [6] = 1.1,   -- vs Sword(1H)
            [7] = 0.9,   -- vs Sword(2H)
            [8] = 1.1,   -- vs Axe(1H)
            [9] = 0.9,   -- vs Axe(2H)
            [10] = 1.1,  -- vs Mace(1H)
            [11] = 0.75, -- vs Mace(2H)
            [12] = 0.75, -- vs Dagger
            [13] = 1.25, -- vs Staff
            [14] = 1.25, -- vs Polearm
            [15] = 1.0   -- vs Fist
        }
    },

    -- Weapon type names for reference
    weaponTypes = {
        [1] = "Bow",
        [2] = "Crossbow",
        [3] = "Gun",
        [4] = "Wand",
        [5] = "Thrown",
        [6] = "Sword(1H)",
        [7] = "Sword(2H)",
        [8] = "Axe(1H)",
        [9] = "Axe(2H)",
        [10] = "Mace(1H)",
        [11] = "Mace(2H)",
        [12] = "Dagger",
        [13] = "Staff",
        [14] = "Polearm",
        [15] = "Fist"
    },

    -- Function to get effectiveness between two weapon types
    getEffectiveness = function(attackerType, defenderType)
        if WeaponEffectiveness.effectiveness[attackerType] and
            WeaponEffectiveness.effectiveness[attackerType][defenderType] then
            return WeaponEffectiveness.effectiveness[attackerType][defenderType]
        end
        return 1.0 -- Default to normal effectiveness if not found
    end,

    -- Function to get weapon type name
    getWeaponTypeName = function(weaponType)
        return WeaponEffectiveness.weaponTypes[weaponType] or "Unknown"
    end,

    -- Function to get a random weapon from the database
    getRandomWeaponFromDB = function(weaponsDB)
        if not weaponsDB then
            -- Fallback to sample weapons if no database provided
            local sampleWeapons = {
                { name = "Rusty Sword",      type = 6,  level = 2,  subclass_name = "Sword (1H)" },
                { name = "Iron Mace",        type = 10, level = 15, subclass_name = "Mace (1H)" },
                { name = "Elven Bow",        type = 1,  level = 25, subclass_name = "Bow" },
                { name = "Steel Axe",        type = 8,  level = 30, subclass_name = "Axe (1H)" },
                { name = "Magic Staff",      type = 13, level = 40, subclass_name = "Staff" },
                { name = "Dwarven Crossbow", type = 2,  level = 35, subclass_name = "Crossbow" },
                { name = "Orcish Gun",       type = 3,  level = 20, subclass_name = "Gun" },
                { name = "Shadow Dagger",    type = 12, level = 45, subclass_name = "Dagger" },
                { name = "War Hammer",       type = 11, level = 50, subclass_name = "Mace (2H)" },
                { name = "Berserker Axe",    type = 9,  level = 55, subclass_name = "Axe (2H)" }
            }
            return sampleWeapons[math.random(1, #sampleWeapons)]
        end

        -- Get all weapon IDs from the database
        local weaponIDs = {}
        for id, weapon in pairs(weaponsDB) do
            if weapon.name and weapon.required_level and weapon.subclass_name then
                table.insert(weaponIDs, id)
            end
        end

        if #weaponIDs == 0 then
            return nil
        end

        -- Select a random weapon
        local randomID = weaponIDs[math.random(1, #weaponIDs)]
        local weapon = weaponsDB[randomID]

        -- Map subclass to weapon type
        local typeMap = {
            ["Bow"] = 1,
            ["Crossbow"] = 2,
            ["Gun"] = 3,
            ["Wand"] = 4,
            ["Thrown"] = 5,
            ["Sword (1H)"] = 6,
            ["Sword (2H)"] = 7,
            ["Axe (1H)"] = 8,
            ["Axe (2H)"] = 9,
            ["Mace (1H)"] = 10,
            ["Mace (2H)"] = 11,
            ["Dagger"] = 12,
            ["Staff"] = 13,
            ["Polearm"] = 14,
            ["Fist Weapon"] = 15
        }

        return {
            name = weapon.name,
            type = typeMap[weapon.subclass_name] or 6, -- Default to sword if unknown
            level = weapon.required_level or 1,
            subclass_name = weapon.subclass_name,
            quality = weapon.quality or 1,
            quality_name = weapon.quality_name or "Common"
        }
    end,

    -- Function to simulate a weapon battle between two random weapons
    simulateWeaponBattle = function(weaponsDB)
        -- Get random weapons from database or use sample weapons
        local weapon1 = WeaponEffectiveness.getRandomWeaponFromDB(weaponsDB)
        local weapon2 = WeaponEffectiveness.getRandomWeaponFromDB(weaponsDB)

        -- Make sure they're different
        local attempts = 0
        while weapon1 and weapon2 and weapon1.name == weapon2.name and attempts < 10 do
            weapon2 = WeaponEffectiveness.getRandomWeaponFromDB(weaponsDB)
            attempts = attempts + 1
        end


        -- Get effectiveness multiplier
        local effectiveness1 = effectiveness[weapon1.type][weapon2.type]
        local effectiveness2 = effectiveness[weapon2.type][weapon1.type]

        -- Calculate base rolls: random(1, required_level) * effectiveness
        local baseRoll1 = math.random(1, weapon1.level) * effectiveness1
        local baseRoll2 = math.random(1, weapon2.level) * effectiveness2

        -- Calculate maximum possible rolls
        local maxPossibleRoll1 = weapon1.level * effectiveness1
        local maxPossibleRoll2 = weapon2.level * effectiveness2

        -- Calculate half of opponent's maximum possible roll
        local halfOpponentMax1 = maxPossibleRoll2 * 0.5
        local halfOpponentMax2 = maxPossibleRoll1 * 0.5

        -- Random roll from 1 to half of opponent's max possible roll
        local randomGuaranteedRoll1 = math.random(1, math.max(1, math.floor(halfOpponentMax1)))
        local randomGuaranteedRoll2 = math.random(1, math.max(1, math.floor(halfOpponentMax2)))

        -- Use the higher of base roll or random guaranteed roll
        local roll1 = math.max(baseRoll1, randomGuaranteedRoll1)
        local roll2 = math.max(baseRoll2, randomGuaranteedRoll2)

        -- Determine winner
        local winner = roll1 > roll2 and weapon1 or weapon2
        local loser = roll1 > roll2 and weapon2 or weapon1
        local winningRoll = roll1 > roll2 and roll1 or roll2
        local losingRoll = roll1 > roll2 and roll2 or roll1

        return {
            weapon1 = weapon1,
            weapon2 = weapon2,
            roll1 = roll1,
            roll2 = roll2,
            baseRoll1 = baseRoll1,
            baseRoll2 = baseRoll2,
            effectiveness1 = effectiveness1,
            effectiveness2 = effectiveness2,
            randomGuaranteedRoll1 = randomGuaranteedRoll1,
            randomGuaranteedRoll2 = randomGuaranteedRoll2,
            halfOpponentMax1 = halfOpponentMax1,
            halfOpponentMax2 = halfOpponentMax2,
            winner = winner,
            loser = loser,
            winningRoll = winningRoll,
            losingRoll = losingRoll
        }
    end,

    -- Function to run multiple battles and show statistics
    runBattleTournament = function(weaponsDB, numBattles)
        numBattles = numBattles or 10
        local results = {
            totalBattles = 0,
            weaponTypeWins = {},
            qualityWins = {},
            levelRangeWins = {},
            guaranteeBoosts = 0
        }

        print("=== WEAPON BATTLE TOURNAMENT ===")
        print("Running " .. numBattles .. " battles from the database...")
        print("")

        for i = 1, numBattles do
            local battle = WeaponEffectiveness.simulateWeaponBattle(weaponsDB)
            if battle and battle.winner then
                results.totalBattles = results.totalBattles + 1

                -- Track weapon type wins
                local winnerType = battle.winner.subclass_name
                results.weaponTypeWins[winnerType] = (results.weaponTypeWins[winnerType] or 0) + 1

                -- Track quality wins
                local winnerQuality = battle.winner.quality_name
                results.qualityWins[winnerQuality] = (results.qualityWins[winnerQuality] or 0) + 1

                -- Track level range wins
                local levelRange = math.floor(battle.winner.level / 10) * 10
                local rangeKey = levelRange .. "-" .. (levelRange + 9)
                results.levelRangeWins[rangeKey] = (results.levelRangeWins[rangeKey] or 0) + 1

                -- Track guarantee boosts
                if battle.baseRoll1 < battle.randomGuaranteedRoll1 or battle.baseRoll2 < battle.randomGuaranteedRoll2 then
                    results.guaranteeBoosts = results.guaranteeBoosts + 1
                end

                print(string.format("Battle %2d: %-20s (L%d %s) vs %-20s (L%d %s) -> %s WINS!",
                    i, battle.weapon1.name, battle.weapon1.level, battle.weapon1.subclass_name,
                    battle.weapon2.name, battle.weapon2.level, battle.weapon2.subclass_name,
                    battle.winner.name))
            end
        end

        print("")
        print("=== TOURNAMENT STATISTICS ===")
        print("Total Battles: " .. results.totalBattles)
        print("Guarantee Boosts Applied: " .. results.guaranteeBoosts)
        print("")

        print("Weapon Type Win Distribution:")
        for weaponType, wins in pairs(results.weaponTypeWins) do
            local percentage = (wins / results.totalBattles) * 100
            print(string.format("  %-15s: %2d wins (%5.1f%%)", weaponType, wins, percentage))
        end
        print("")

        print("Quality Win Distribution:")
        for quality, wins in pairs(results.qualityWins) do
            local percentage = (wins / results.totalBattles) * 100
            print(string.format("  %-10s: %2d wins (%5.1f%%)", quality, wins, percentage))
        end
        print("")

        print("Level Range Win Distribution:")
        for range, wins in pairs(results.levelRangeWins) do
            local percentage = (wins / results.totalBattles) * 100
            print(string.format("  Level %-8s: %2d wins (%5.1f%%)", range, wins, percentage))
        end

        return results
    end
}

return WeaponEffectiveness
