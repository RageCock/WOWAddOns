--[[
    functions:
    Broadcast messages when you interrupt an enemey's spell casting.
    Broadcast messages when you dispel an enemey's buff or an teammate's debuff.
    Broadcast messages when you steal an enemey's buff.
    Broadcast messages when you reflect an enemey's spell to you.
    Broadcast messages when you cast a spell(23920).
--]]

local function CLEU_Handler(...)
    local timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = select(1, ...)

    if subEvent == "SPELL_INTERRUPT"
    and bit.band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0 
    and bit.band(destFlags, COMBATLOG_OBJECT_AFFILIATION_OUTSIDER) > 0 then
        local spellID, spellName, spellSchool, extraSpellID, extraSpellName, extraSpellSchool = select(12, ...)
        SendChatMessage("已打断" .. destName .. "的" .. GetSpellLink(extraSpellID), "emote")
    
    elseif subEvent == "SPELL_DISPEL" and bit.band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0  then
        local spellID, spellName, spellSchool, extraSpellID, extraSpellName, extraSpellSchool = select(12, ...)
        SendChatMessage("已驱散" .. destName .. "的" .. GetSpellLink(extraSpellID), "emote")
    
    elseif subEvent == "SPELL_STOLEN" and bit.band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0  then
        local spellID, spellName, spellSchool, extraSpellID, extraSpellName, extraSpellSchool = select(12, ...)
        SendChatMessage("已偷取" .. destName .. "的" .. GetSpellLink(extraSpellID), "emote")
    
    elseif subEvent == "SPELL_MISSED" and bit.band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_OUTSIDER) > 0 then
        local spellID, spellName, spellSchool, missType, isOffHand, amountMissed, critical = select(12, ...)
        if missType == "REFLECT" then
            SendChatMessage("已反射" .. sourceName .. "的" .. GetSpellLink(spellID), "emote")
        end
    
    elseif subEvent == "SPELL_CAST_SUCCESS" and bit.band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0 then
        local spellID, spellName, spellSchool = select(12, ...)
        if spellID == 23920 then
            SendChatMessage(GetSpellLink(23920).."已激活", "emote")
        end
    end
    
end

local function OnEvent_Handler(self, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        CLEU_Handler(CombatLogGetCurrentEventInfo())
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", OnEvent_Handler)



-- COMBAT_LOG_EVENT_UNFILTERED
-- Basic Params(11): timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags 

-- SPELL / SPELL_PERIODIC / SPELL_BUILDING (3): spellID, spellName, spellSchool

-- DAMAGE(10): amount, overKill, school, resisited, blocked, absorbed, critical, glancing, crushing, isOffHand
-- MISSED(4): missType, isOffHand, amountMissed, critical
-- HEAL(4): amount, overhealing, absorbed, critical
-- ENERGIZE(4): amount, overEnergize, powerType, alternatePowerType
-- DRAIN, LEECH(3): amount, powerType, extraAmount
-- INTERRUPT, DISPEL, DISPEL_FAILED, STOLEN(3): extraSpellID, extraSpellName, extreaSpellSchool
-- EXTRA_ATTACKS(1): amount

-- missType: ABSORB(吸收) BLOCK(格挡) DEFLECT(偏转) DODGE(躲闪) EVADE() IMMUNE(免疫) MISS() PARRY(招架) REFLECT(反射) RESIST(抵抗)

 -- the unit’s controller relationship relative to YOU. Either it is controlled by you(MINE), your party, your raid or someone else.