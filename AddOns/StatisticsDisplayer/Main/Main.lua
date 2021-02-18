-- moduleStatisticsDisplayer.
moduleStatisticsDisplayer.slotSpacing = 8 -- the spacing between every slots, min 0 - max 10
moduleStatisticsDisplayer.formatDigits = 2 -- the format digits, min 0 - max 5


local slotSpacing = moduleStatisticsDisplayer.slotSpacing
local formatDigits = moduleStatisticsDisplayer.formatDigits

local parentFrame = CharacterStatisticsDetailFrame

local function Format(value)
    return string.format("%0."..formatDigits.."f", value)
end


local function GetCrit()
    return "Crit: "..Format(GetCritChance()).."%"
end

local function GetHaste()
    return "Haste: "..Format(UnitSpellHaste("player")).."%"
end

local function GetMastery()
    return "Mastry: "..Format(GetMasteryEffect()).."%"
end

local function GetVersatility()
    return "Versatility: "..Format(GetCombatRatingBonus(29)).." / "..Format(GetCombatRatingBonus(29)/2).."%"
end

local function GetLifesteal()
    return "Lifesteal: "..Format(GetCombatRatingBonus(17)).."%"
end

local function GetSpeed()
    return "Speed: "..Format(GetCombatRatingBonus(14)).."%"
end

local function GetAvoidance()
    return "Avoidance: "..Format(GetCombatRatingBonus(21)).."%"
end

local function GetBlock()
    return "Block: "..Format(GetBlockChance()).."%"
end

local function GetParry()
    return "Parry: "..Format(GetParryChance()).."%"
end

local function GetDodge()
    return "Dodge: "..Format(GetDodgeChance()).."%"
end

-- Attributes sequence
moduleStatisticsDisplayer.sequenceAttributes = {
    "Crit", "Haste", "Mastery", "Versatility", "Lifesteal", "Speed",
    "Avoidance", "Block", "Parry", "Dodge"
}

-- Attributes getters
local attributeGetters = {}
attributeGetters["Crit"] = GetCrit
attributeGetters["Haste"] = GetHaste
attributeGetters["Mastery"] = GetMastery
attributeGetters["Versatility"] = GetVersatility
attributeGetters["Lifesteal"] = GetLifesteal
attributeGetters["Speed"] = GetSpeed
attributeGetters["Avoidance"] =  GetAvoidance
attributeGetters["Block"] = GetBlock
attributeGetters["Parry"] = GetParry
attributeGetters["Dodge"] = GetDodge

--[[
    Count the num of actived attributes
--]] 
local function CountActivedAttributes()
    local numActived = 0
    local statedAttributes = moduleStatisticsDisplayer.diskizationVariablesPerCharacter.configuration.statedAttributes
    for key,value in pairs(statedAttributes) do
       if value == true then numActived = numActived + 1 end
    end
    return numActived
end

--[[
    Create slots, the func will only be called once time when the plugin loaded.

--]]
local function CreateFontStringSlots(slotsNum)
    local fontStringSlots = {}

    local header = parentFrame:CreateFontString("FontString1", "OVERLAY")
    header:SetFontObject("CharacterStatisticsStandardFont")
    header:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 10, -10)
    header:SetText("Header")
    fontStringSlots[1] = header

    if slotsNum > 1 then
        for i = 2, slotsNum, 1 do
            local fontString = parentFrame:CreateFontString("FontString"..i, "OVERLAY")
            fontString:SetFontObject("CharacterStatisticsStandardFont")
            fontString:SetPoint("TOPLEFT", "FontString"..(i-1), "BOTTOMLEFT", 0, -slotSpacing)
            fontString:SetText("This is text")

            fontStringSlots[i] = fontString
        end
    end

    return fontStringSlots
end

-- Update
local cachedActivedAttributes = 10
local function Update()
    local numActivedAttributes = CountActivedAttributes()

    -- Adjust other state
    parentFrame:SetSize(240, 
        13 * numActivedAttributes + (numActivedAttributes - 1) * slotSpacing + 20)

    -- Get Slots
    local regions = {parentFrame:GetRegions()}
    local slots = {}
    local i = 1
    for _, value in pairs(regions) do
        if value:GetObjectType() == "FontString" then
            slots[i] = value
            i = i + 1
        end
    end

    -- Adjust slots "hiden or shown"
    if numActivedAttributes > cachedActivedAttributes then
        for i = cachedActivedAttributes + 1, numActivedAttributes do 
            slots[i]:Show()
        end
    elseif numActivedAttributes < cachedActivedAttributes then
        for i = numActivedAttributes + 1, cachedActivedAttributes do
            slots[i]:Hide()
        end
    end
    cachedActivedAttributes = numActivedAttributes

    -- Get avaliable slots:
    local avaliableSlots = {}
    i = 1
    for _, value in pairs(slots) do
        if i > numActivedAttributes then break end
        avaliableSlots[i] = slots[i]
        i = i + 1
    end
    
    -- Set text
    if #avaliableSlots == numActivedAttributes then
        local j = 1
        local sequenceAttributes = moduleStatisticsDisplayer.sequenceAttributes
        local statedAttributes = moduleStatisticsDisplayer.diskizationVariablesPerCharacter.configuration.statedAttributes
        for _, value in pairs(sequenceAttributes) do
            if statedAttributes[value] == true then
                avaliableSlots[j]:SetText(attributeGetters[value]())
                j = j + 1
            end
        end
    end

end

local function OnUpdate_UpdateCore()
    Update()
end

CreateFontStringSlots(10)
parentFrame:SetScript("OnUpdate", OnUpdate_UpdateCore)


--     local BonusWeaponSkill = GetCombatRatingBonus(1)
--     local BonusDefenseSkill = GetCombatRatingBonus(2)
--     local BonusDodge = GetCombatRatingBonus(3)
--     local BonusParry = GetCombatRatingBonus(4)
--     local BonusBlock = GetCombatRatingBonus(5)
--     local BonusHitMelee = GetCombatRatingBonus(6)
--     local BonusHitRanged = GetCombatRatingBonus(7)
--     local BonusHitSpell = GetCombatRatingBonus(8)
--     local BonusCritMelee = GetCombatRatingBonus(9)
--     local BonusCritRanged = GetCombatRatingBonus(10)
--     local BonusCritSpell = GetCombatRatingBonus(11)
--     local BonusMultiStrike = GetCombatRatingBonus(12)
--     local BonusReadiness = GetCombatRatingBonus(13)
--     local BonusSpeed = GetCombatRatingBonus(14)
--     local BonusCombatRatingResilienceCritTaken = GetCombatRatingBonus(15)
--     local BonusCombatRatingResiliencePlayerDamageTaken = GetCombatRatingBonus(16)
--     local BonusLifesteal = GetCombatRatingBonus(17)
--     local BonusHasteMelee = GetCombatRatingBonus(18) -- 近战急速
--     local BonusHasteRanged = GetCombatRatingBonus(19) -- 远程急速
--     local BonusHasteSpell = GetCombatRatingBonus(20) -- 法术急速
--     local BonusAvoidance = GetCombatRatingBonus(21)
--     local BonusWeaponSkillOffHand = GetCombatRatingBonus(22)
--     local BonusWeaponSkillRanged = GetCombatRatingBonus(23)
--     local BonusExpertise = GetCombatRatingBonus(24)
--     local BonusArmorPenetration = GetCombatRatingBonus(25)
--     local BonusMastery = GetCombatRatingBonus(26)
--     local BonusPVPPower = GetCombatRatingBonus(27)
--     local BonusVersatilityDamageDone = GetCombatRatingBonus(29)
--     local BonusVersatilityDamageTaken = GetCombatRatingBonus(31)

--     local FinalCrit = GetCritChance()
--     local FinalHaste = UnitSpellHaste("player")
--     local FinalMastery = GetMasteryEffect()
--     local FinalLifesteal = BonusLifesteal
--     local FinalSpeed = BonusSpeed
--     local FinalAvoidance = BonusAvoidance;
--     local FinalBlockChance = GetBlockChance()
--     local ShieldBlock = GetShieldBlock()
--     local FinalParryChance = GetParryChance()
--     local FinalDodgeChance = GetDodgeChance()