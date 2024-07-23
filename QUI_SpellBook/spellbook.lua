local QUI = LibStub("AceAddon-3.0"):GetAddon("QUI")

QUI.KillFrameNineSlice(SpellBookFrame)
if SpellBookPage1 then
SpellBookPage1:Hide()
SpellBookPage2:Hide()
end

local _G = _G
local spellsperpage = SPELLS_PER_PAGE
if spellsperpage == nil then
return
end
for i=1,spellsperpage do
	local button=_G["SpellButton"..i]
	local IconTextureBg = button.IconTextureBg
	if IconTextureBg then
		button.IconTextureBg:SetTexCoord(0.1,0.9,0.1,0.9)
	end
	_G["SpellButton"..i.."IconTexture"]:SetTexCoord(0.1,0.9,0.1,0.9)
	if button.TextBackground then
		button.TextBackground:Hide()
		button.TextBackground2:Hide()
	end
end


if SpellBookFrame.Tabs then
	for _,widget in pairs(SpellBookFrame.Tabs) do
		widget:SetAlpha(0)
	end
end

QUI.KillFrameLMRBorder(SpellBookFrameTabButton1)
QUI.KillFrameLMRBorder(SpellBookFrameTabButton2)

for i=1,8 do
	local tab = _G["SpellBookSkillLineTab"..i]
	if tab then
		QUI.TextureIcons(tab,"Interface\\SpellBook\\SpellBook-SkillLineTab")
		QUI.setalphazeroframe(_G["SpellBookSkillLineTab"..i.."TabardEmblem"])
	end
end

QUI.skin_button(SpellBookPrevPageButton)
QUI.skin_button(SpellBookNextPageButton)
