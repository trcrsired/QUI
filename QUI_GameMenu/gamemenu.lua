local QUI = LibStub("AceAddon-3.0"):GetAddon("QUI")
local skinbutton = QUI.skin_button
local Header = GameMenuFrame.Header
Header:SetPoint("TOP",0,-3)
Header.LeftBG:Hide()
Header.CenterBG:Hide()
Header.RightBG:Hide()
local type = type
GameMenuFrame.Border.Bg:SetVertexColor(0,0,0,0.4)
for k,v in pairs(GameMenuFrame.Border) do
	if type(k)=="string" and type(v)=="table" and (k:find("Edge") or k:find("Corner")) then
		v:Hide()
	end
end

local sb = QUI.skin_button
sb(GameMenuButtonHelp)
sb(GameMenuButtonStore)
sb(GameMenuButtonWhatsNew)
sb(GameMenuButtonMacros)
sb(GameMenuButtonAddons)
sb(GameMenuButtonRatings)
sb(GameMenuButtonLogout)
sb(GameMenuButtonQuit)
sb(GameMenuButtonContinue)
sb(GameMenuButtonOptions)
sb(GameMenuButtonUIOptions)
sb(GameMenuButtonKeybindings)
sb(GameMenuButtonSettings)
sb(GameMenuButtonEditMode)
