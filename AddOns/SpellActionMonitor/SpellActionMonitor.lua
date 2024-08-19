local function CLEU_Handler(...)
    local timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags =
        select(1, ...)

    if subEvent == "SPELL_INTERRUPT"
        and bit.band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0
        and bit.band(destFlags, COMBATLOG_OBJECT_AFFILIATION_OUTSIDER) > 0 then
        local spellID, spellName, spellSchool, extraSpellID, extraSpellName, extraSpellSchool = select(12, ...)
        local link, spellId = C_Spell.GetSpellLink(extraSpellID)
        SendChatMessage("已打断" .. destName .. "的" .. link, "emote")
    elseif subEvent == "SPELL_DISPEL" and bit.band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0 then
        local spellID, spellName, spellSchool, extraSpellID, extraSpellName, extraSpellSchool = select(12, ...)
        local link, spellId = C_Spell.GetSpellLink(extraSpellID)
        SendChatMessage("已驱散" .. destName .. "的" .. link, "emote")
    elseif subEvent == "SPELL_STOLEN" and bit.band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0 then
        local spellID, spellName, spellSchool, extraSpellID, extraSpellName, extraSpellSchool = select(12, ...)
        local link, spellId = C_Spell.GetSpellLink(extraSpellID)
        SendChatMessage("已偷取" .. destName .. "的" .. link, "emote")
    elseif subEvent == "SPELL_MISSED" and bit.band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_OUTSIDER) > 0 then
        local spellID, spellName, spellSchool, missType, isOffHand, amountMissed, critical = select(12, ...)
        if missType == "REFLECT" then
            local link, spellId = C_Spell.GetSpellLink(extraSpellID)
            SendChatMessage("已反射" .. sourceName .. "的" .. link, "emote")
        end
    elseif subEvent == "SPELL_CAST_SUCCESS" and bit.band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0 then
        local spellID, spellName, spellSchool = select(12, ...)
        if spellID == 23920 then
            local link, spellId = C_Spell.GetSpellLink(23920)
            SendChatMessage(link .. "已激活", "emote")
        end
    end
end


local f = CreateFrame("frame")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

f:SetScript("OnEvent", function(self, event, ...)
    CLEU_Handler(CombatLogGetCurrentEventInfo())
end)
