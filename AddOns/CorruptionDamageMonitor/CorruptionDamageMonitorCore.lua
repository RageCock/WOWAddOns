
local TwilightDevastationID = 317159  -- 暮光炮
local InfiniteStarsID -- 无尽之星
local TwistedAppendageID -- 触须
local EchoingVoidID -- 虚空回响
local GushingWoundID --龟裂创伤

-- 315179

local totalTwilightDevastationDamage = 0
local totalHitEnemies = 0
local firstTimestamp = 0
local flag = false

local function AcculateTwilightDevastationDamage(timestamp, spellID, amount)
    if spellID == TwilightDevastationID then
        if flag == false then
            flag = true
            firstTimestamp = timestamp
            PlaySoundFile("Interface/AddOns/JP-CorruptionDamageMonitor/fire.ogg")
        end

        totalHitEnemies = totalHitEnemies + 1
        totalTwilightDevastationDamage = totalTwilightDevastationDamage + amount
    end

    if (timestamp - firstTimestamp > 2 or totalHitEnemies == 10) and flag == true then
        SendChatMessage("暮光毁灭击中了"..totalHitEnemies.."名敌人，共计".. string.format("%.1f", totalTwilightDevastationDamage * 0.0001).."万的伤害", "emote")
        totalTwilightDevastationDamage = 0
        totalHitEnemies = 0
        firstTimestamp = 0
        flag = false
    end
end


local function CLEUHandler(...)
    local timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = select(1, ...)
    if subEvent == "SPELL_DAMAGE" and bit.band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0 then
            local spellID, spellName, spellSchool, amount, overKill, school, resisited, blocked, absorbed, critical, glancing, crushing, isOffHand = select(12, ...)
            AcculateTwilightDevastationDamage(timestamp, spellID, amount)
    end

    if subEvent == "SPELL_CAST_SUCCESS" then
        local spellID, spellName, spellSchool = select(12, ...)
        if spellID == 317159 then
            SendChatMessage("暮光毁灭触发了", "emote")
        end
    end
    
end

local function EventHandlerProxy(self, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        CLEUHandler(CombatLogGetCurrentEventInfo())
    end
end


local f = CreateFrame("Frame")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", EventHandlerProxy)