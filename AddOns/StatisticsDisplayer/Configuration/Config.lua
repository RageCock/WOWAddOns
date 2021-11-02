
function AdjustCheckButtons()
    local i = 1
    local statedAttributes = moduleStatisticsDisplayer.diskizationVariablesPerCharacter.configuration.statedAttributes
    for key, value in pairs(statedAttributes) do
        checkButton = CreateFrame("CheckButton", "CheckButton"..i, ConfigFrame, "UICheckButtonTemplate")
            
        if i == 1 then
            checkButton:SetPoint("TOPLEFT", "ConfigFrame", "TOPLEFT", 20, -50)
        else
            checkButton:SetPoint("TOPLEFT", "CheckButton"..(i-1), "BOTTOMLEFT", 0, 0)
        end

        checkButton.text:SetText(key)
        checkButton:SetChecked(value)

        i = i + 1
    end
end

local function GetCheckButtonsFromUI()
    local children = {ConfigFrame:GetChildren()}
    local checkButtons = {}

    for _, value in pairs(children) do
        if value:GetObjectType() == "CheckButton" then
            table.insert(checkButtons, value)
        end
    end

    return checkButtons
end


local function AddIcon()
    local index = GetNumSpecializations(false, false)
    local id, name, description, icon, background, role = GetSpecializationInfo(index, false, false, UnitSex("player"))
    print(icon, background, role)

    ConfigFrame.ic = ConfigFrame:CreateTexture(nil, "BACKGROUND")
    ConfigFrame.ic:SetPoint("TOPLEFT", "ConfigFrame", "TOPLEFT", 20, -50)
    ConfigFrame.ic:SetTexture(icon)
end


local function OnClick_Apply()
    local checkButtons = GetCheckButtonsFromUI()
    local statedAttributes = moduleStatisticsDisplayer.diskizationVariablesPerCharacter.configuration.statedAttributes
    for _, value in pairs(checkButtons) do
        local key = value.text:GetText()
        local isChecked = value:GetChecked()
        statedAttributes[key] = isChecked
    end
end

local function OnClick_Confirm()
    OnClick_Apply()
    AddIcon()
    ConfigFrame:Hide()
end

local function OnClick_Cancel()
    ConfigFrame:Hide()
end

local function ShowConfig()
    ConfigFrame:Show()
end

local function InitializeConfigurationFrame(self, event, ...)
    AdjustCheckButtons()
    ConfigFrame:Hide()
end
-----------------------------------------------------------------------
-- Execute code
ApplyButton:SetScript("OnClick", OnClick_Apply)
ConfirmButton:SetScript("OnClick", OnClick_Confirm)
CancelButton:SetScript("OnClick", OnClick_Cancel)

local ADDON_LOADED_HandlerArray = moduleStatisticsDisplayer.ADDON_LOADED_HandlerArray
table.insert(ADDON_LOADED_HandlerArray, InitializeConfigurationFrame)




