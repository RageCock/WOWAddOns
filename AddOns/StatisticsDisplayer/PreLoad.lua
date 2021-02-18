--[[
    GlobalModule
    1.some descriptionInfo
    2.eventHandlerMap
--]]
moduleStatisticsDisplayer = {}
moduleStatisticsDisplayer.addOnName = "StatisticsDisplayer"
moduleStatisticsDisplayer.addOnVersion = "1.0"
moduleStatisticsDisplayer.addOnApplicableVersion = "*.*.*"
----------------------------------------------------------------------
--[[
    EventFrame
    We use a map to store an "event-handler", the actually registering action will be done at the 'PostLoad.lua', cause we need to collect all map values.
    All handlers, including subhandlers, need to obey this parameter list: (self, event, ...). This rule may cause more consumption, but more stable structure.
--]]
-- Create eventHandlerMap, set OnEvent_EventHandler as script.
moduleStatisticsDisplayer.eventHandlerMap = {}
local eventHandlerMap = moduleStatisticsDisplayer.eventHandlerMap

local function OnEvent_EventHandler(self, event, ...)
    local handler = eventHandlerMap[event]
    if handler ~= nil then 
        handler(self, event, ...) 
    end
end

moduleStatisticsDisplayer.eventFrame = CreateFrame("Frame")
moduleStatisticsDisplayer.eventFrame:SetScript("OnEvent", OnEvent_EventHandler);

-- Create ADDON_LOADED_HandlerArray, set handler and add it to map.
moduleStatisticsDisplayer.ADDON_LOADED_HandlerArray = {}
local ADDON_LOADED_HandlerArray = moduleStatisticsDisplayer.ADDON_LOADED_HandlerArray

local function ADDON_LOADED_Handler(self, event, ...)
    local addOnName = select(1, ...)
    if addOnName == "JAO-StatisticsDisplayer" then
        for i,value in pairs(ADDON_LOADED_HandlerArray) do
            value(self, event, ...)
        end
    end
end

eventHandlerMap["ADDON_LOADED"] = ADDON_LOADED_Handler
-----------------------------------------------------------------------
--[[
    Diskization Variables
    1. statisticsDisplayerDiskizationVars
    2. statisticsDisplayerDiskizationVarsPerCharacter
--]]
-- Set initializer and register it.
moduleStatisticsDisplayer.diskizationVariables = {}
moduleStatisticsDisplayer.diskizationVariablesPerCharacter = {}
moduleStatisticsDisplayer.bIsDiskizationVariablesReady = false
moduleStatisticsDisplayer.bIsDiskizationVariablesPerCharacterReady = false

local function InitializeDiskizationVariables(self, event, ...)
    if statisticsDisplayerDiskizationVars == nil then
        statisticsDisplayerDiskizationVars = {"blank"}
    end
    
    if statisticsDisplayerDiskizationVarsPerCharacter == nil then
        statisticsDisplayerDiskizationVarsPerCharacter = {}
        statisticsDisplayerDiskizationVarsPerCharacter.configuration = {}
        statisticsDisplayerDiskizationVarsPerCharacter.configuration.statedAttributes = {
            ["Crit"] = true,
            ["Haste"] = true,
            ["Mastery"] = true,
            ["Versatility"] = true,
            ["Lifesteal"] = false,
            ["Speed"] = true,
            ["Avoidance"] = true,
            ["Block"] = true,
            ["Parry"] = true,
            ["Dodge"] = true
        }  
    end
    
    moduleStatisticsDisplayer.diskizationVariables = statisticsDisplayerDiskizationVars
    moduleStatisticsDisplayer.diskizationVariablesPerCharacter = statisticsDisplayerDiskizationVarsPerCharacter

    moduleStatisticsDisplayer.bIsDiskizationVariablesReady = true
    moduleStatisticsDisplayer.bIsDiskizationVariablesPerCharacterReady = true
end

table.insert(ADDON_LOADED_HandlerArray, InitializeDiskizationVariables)
-----------------------------------------------------------------------
--[[
    PreSlashCommonds
--]] 
-- slash reload ui
SLASH_RELOADUI1 = "/ReloadUI"
SLASH_RELOADUI2 = "/RELOADUI"
SLASH_RELOADUI3 = "/reloadui"
SLASH_RELOADUI4 = "/rl"
SlashCmdList.RELOADUI = ReloadUI

-- slash open frame stack
-- SLASH_FRAMESTK1 = "/FrameStack"
-- SLASH_FRAMESTK2 = "/FRAMESTACK"
-- SLASH_FRAMESTK1 = "/framestack"
-- SLASH_FRAMESTK4 = "/fs"
-- SlashCmdList.FRAMESTK = function()
--     LoadAddOn('Blizzard_DebugTools')
--     FrameStackTooltip_Toggle()
-- end



-- local health = UnitHealth("player");
-- local healthMax = UnitHealthMax("player");

-- -- character statistics
-- --local ArmorPenetration = GetArmorPenetration();
-- local AttackPowerForStat = GetAttackPowerForStat(stat, value);
-- local AverageItemLevel = GetAverageItemLevel();
-- local BlockChance = GetBlockChance();
-- local CombatRating = GetCombatRating(ratingID);
-- local CombatRatingBonus = GetCombatRatingBonus(ratingID);
-- local MaxCombatRatingBonus = GetMaxCombatRatingBonus(lowestRating);
-- local CritChance = GetCritChance();
-- local DodgeChance = GetDodgeChance();
-- local Expertise = GetExpertise();
-- local ExpertisePercent = GetExpertisePercent();
-- local Lifesteal = GetLifesteal();
-- local ManaRegen = GetManaRegen();
-- local Mastery =  GetMastery();
-- local MasteryEffect = GetMasteryEffect();
-- local ParryChance = GetParryChance();
-- local PetSpellBonusDamage = GetPetSpellBonusDamage();
-- local PowerRegen = GetPowerRegen();
-- local SpellBonusDamage = GetSpellBonusDamage(spellTreeID);
-- local RangedCritChance = GetRangedCritChance();
-- local SpellBonusHealing = GetSpellBonusHealing();
-- local SpellCritChance = GetSpellCritChance(school);
-- local ShieldBlock = GetShieldBlock()
-- local SpellCritChanceFromIntellect = GetSpellCritChanceFromIntellect("unit")
-- local SpellPenetration = GetSpellPenetration();

