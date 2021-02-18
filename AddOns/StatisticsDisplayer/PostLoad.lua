SLASH_CONFIG1 = "/config"
SlashCmdList.CONFIG = function()
    ConfigFrame:Show()
end

----------------------------------------------------------------------
--[[
    EventFrame
    Register all events.
--]]
for key, _ in pairs(moduleStatisticsDisplayer.eventHandlerMap) do
    moduleStatisticsDisplayer.eventFrame:RegisterEvent(key);
end