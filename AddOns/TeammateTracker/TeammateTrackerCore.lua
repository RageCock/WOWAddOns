
SLASH_HELLO1 = "/helloworld"
SLASH_HELLO2 = "/hellow"

-- /helloworld name
-- /hellow name
local function Hello(name)

end

SlashCmdList["HELLO"] = Hello


--MyTexture:SetTexture(GetSpellTexture(51533))

local function GF_Handler(...)
    local category, partyGUID = select(1, ...)

    SendMessage("category:"..category.."partyGUID:"..partyGUID, emote)
end


local function OnEvent_Handler(self, event, ...)
    print(1111)
    if event == "GROUP_FORMED" then
        GF_Handler(...)
    end
end


local f = CreateFrame("Frame")
f:RegisterEvent("GROUP_FORMED")
f:SetScript("OnEvent", OnEvent_Handler)




