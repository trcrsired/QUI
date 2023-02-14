local QUI = LibStub("AceAddon-3.0"):GetAddon("QUI")
QUI.skin_scrollframe("AddonList")

local type = type
for k,v in pairs(AddonList) do
	if type(k) == "string" and k~="CloseButton" and k:find("Button") and type(v) == "table" then
		QUI.KillFrameBackgroundBySearch(v)
		v:SetNormalTexture([[Interface\DialogFrame\UI-DialogBox-Background-Dark]])
		v:SetHighlightTexture([[Interface\DialogFrame\UI-DialogBox-Gold-Background]])
	end
end

QUI.skin_button(AddonListForceLoad)
QUI.skin_button(AddonCharacterDropDown.Button)

for i=1,MAX_ADDONS_DISPLAYED do
	QUI.skin_button(_G["AddonListEntry"..i.."Enabled"])
end
QUI.skin_dropdown("AddonCharacterDropDown")
