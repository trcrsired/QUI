local QUI = LibStub("AceAddon-3.0"):GetAddon("QUI")
QUI.KillFrameNineSlice(MacroFrame)

MacroHorizontalBarLeft:SetAlpha(0)

local regions = {MacroFrame:GetRegions()}
for i=1,#regions do
	local region = regions[i]
	if region:IsObjectType("Texture") and region:GetTexture()=="Interface\\ClassTrainerFrame\\UI-ClassTrainer-HorizontalBar" then
		region:SetAlpha(0)
	end
end


local _G = _G
QUI.skin_dropdown("MacroFrameTab1")
QUI.skin_dropdown("MacroFrameTab2")

if MacroButton1 then

local function skinmacrobutton(macroButtonName)
	local macroButton = _G[macroButtonName]
	local Icon = macroButton.Icon
	if Icon == nil then
		Icon = _G[macroButtonName.."Icon"]
	end
	Icon:SetTexCoord(0.1,0.9,0.1,0.9)
	QUI.KillFrameBackgroundBySearch(macroButton,"Interface\\Buttons\\UI-EmptySlot-Disabled");
end

for i=1, max(MAX_ACCOUNT_MACROS, MAX_CHARACTER_MACROS) do
	skinmacrobutton("MacroButton"..i)
end

skinmacrobutton("MacroFrameSelectedMacroButton")

end

MacroFrameSelectedMacroBackground:SetAlpha(0)

if MacroButtonScrollFrameTop then
MacroButtonScrollFrameTop:SetAlpha(0)
MacroButtonScrollFrameMiddle:SetAlpha(0)
MacroButtonScrollFrameBottom:SetAlpha(0)
MacroButtonScrollFrameScrollBar:SetAlpha(0)
end

local skinbutton = QUI.skin_button
skinbutton(MacroEditButton)
skinbutton(MacroCancelButton)
skinbutton(MacroSaveButton)
skinbutton(MacroDeleteButton)
skinbutton(MacroNewButton)
skinbutton(MacroExitButton)

MacroFrameTextBackground:SetAlpha(0)
MacroPopupFrame.BorderBox:SetAlpha(0)
