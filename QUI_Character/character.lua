local QUI = LibStub("AceAddon-3.0"):GetAddon("QUI")
QUI.KillFrameNineSlice(CharacterFrame)
QUI.skin_buttons_in_frame(PaperDollItemsFrame)

local function hide_left_right(slot)
	local regions = {slot:GetRegions()}
	for i=1,#regions do
		local region = regions[i]
		if region:IsObjectType("Texture") and region:GetTexture()=="Interface\\CharacterFrame\\Char-Paperdoll-Parts" then
			region:Hide()
		end
	end
end

hide_left_right(CharacterMainHandSlot)
hide_left_right(CharacterSecondaryHandSlot)

if CharacterStatsPane then
CharacterStatsPane.ClassBackground:SetAlpha(0)
end

QUI.KillFrameLMRBorder("CharacterFrameTab1")
QUI.KillFrameLMRBorder("CharacterFrameTab2")
QUI.KillFrameLMRBorder("CharacterFrameTab3")
QUI.setalphazeroframe(ReputationListScrollFrame)
QUI.setalphazeroframe(TokenFrameContainerScrollBar)
QUI.setalphazeroframe(PaperDollTitlesPaneScrollBar)
QUI.setalphazeroframe(PaperDollEquipmentManagerPaneScrollBar)

QUI.KillFrameLMRBorder(PaperDollEquipmentManagerPaneSaveSet)
QUI.KillFrameLMRBorder(PaperDollEquipmentManagerPaneEquipSet)

for i=1,3 do
	local tab = _G["PaperDollSidebarTab"..i]
	if tab then
		QUI.setalphazeroframe(tab.TabBg)
	end
end

QUI.setalphazeroframe(ReputationDetailDivider)
QUI.setalphazeroframe(ReputationDetailCorner)


QUI.KillFrameBackgroundBySearch(ReputationDetailFrame.Border)

QUI.setalphazeroframe(TokenFramePopupCorner)

if TokenFramePopup then
QUI.KillFrameBorderBySearch(TokenFramePopup.Border)
end

local skin_checkbox = QUI.skin_button

skin_checkbox(ReputationDetailAtWarCheckBox)
skin_checkbox(ReputationDetailInactiveCheckBox)
skin_checkbox(ReputationDetailMainScreenCheckBox)
--skin_checkbox(ReputationDetailLFGBonusReputationCheckBox)
skin_checkbox(TokenFramePopupInactiveCheckBox)
skin_checkbox(TokenFramePopupBackpackCheckBox)

if CharacterModelFrame then
if CharacterModelFrame.BackgroundOverlay then
CharacterModelFrame.BackgroundOverlay:Hide()
end
local type = type
for k,v in pairs(CharacterModelFrame) do
	if type(k)=="string" and k:find("PaperDollInnerBorder") and type(v)=="table" then
		v:Hide()
	end
end

if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
function QUI:PaperDollBgDesaturate()
	CharacterModelFrameBackgroundTopLeft:SetDesaturated(false)
	CharacterModelFrameBackgroundTopRight:SetDesaturated(false)
	CharacterModelFrameBackgroundBotLeft:SetDesaturated(false)
	CharacterModelFrameBackgroundBotRight:SetDesaturated(false)
end

QUI:SecureHook("PaperDollBgDesaturate")
end
end
