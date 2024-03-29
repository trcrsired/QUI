local QUI = LibStub("AceAddon-3.0"):GetAddon("QUI")
local minimap = QUI:NewModule("Minimap","AceEvent-3.0")
Minimap:SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground')
local QUI_KillFrame = QUI.KillFrame

QUI_KillFrame(MinimapBorder)
QUI_KillFrame(MinimapBorderTop)
QUI_KillFrame(MiniMapWorldMapButton)
QUI_KillFrame(MinimapNorthTag)
QUI_KillFrame(GameTimeFrame)
QUI_KillFrame(MinimapZoomIn)
QUI_KillFrame(MinimapZoomOut)
QUI_KillFrame(MinimapBackdrop)

--[[
MinimapBorder:Hide()
MinimapBorderTop:Hide()
MiniMapWorldMapButton:Hide()
MinimapNorthTag:SetParent(QUI.UIHider)
GameTimeFrame:SetParent(QUI.UIHider)

MinimapZoomIn:SetAlpha(0)
MinimapZoomIn:SetScale(0.0001)
MinimapZoomIn:SetParent(QUI.UIHider)
MinimapZoomOut:SetAlpha(0)
MinimapZoomOut:SetScale(0.0001)
MinimapZoomOut:SetParent(QUI.UIHider)
]]

Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel",function(self,val,...)
	local zoom = Minimap:GetZoom() + val
	if zoom + val < 0 or Minimap:GetZoomLevels() < zoom then
		return
	end
	Minimap:SetZoom(zoom)
end)
local GarrisonLandingPageMinimapButton = GarrisonLandingPageMinimapButton
if GarrisonLandingPageMinimapButton then
	GarrisonLandingPageMinimapButton:SetAlpha(0)
end
function GetMinimapShape() return 'SQUARE' end

function minimap:OnEnable()
	if TimeManagerClockButton then
		TimeManagerClockButton:SetParent(QUI.UIHider)
	end
	self.OnEnable = nil
end

local coordinates = Minimap:CreateFontString(nil,nil,"GameFontNormalSmall")
minimap.coordinates = coordinates
coordinates:SetPoint("TOP",Minimap,"BOTTOM")

local SetFormattedText = coordinates.SetFormattedText
local SetText = coordinates.SetText

C_Timer.NewTicker(1,function()
	local x,y=UnitPosition("player")
	if x and y then
		SetFormattedText(coordinates,"%.1f,%.1f",x,y)
	else
		SetText(coordinates,"")
	end
end)

if ExpansionLandingPageMinimapButton then
local expansionlandingpageminimapbuttonframe = CreateFrame("Frame",nil,Minimap)
expansionlandingpageminimapbuttonframe:SetSize(25,25)
ExpansionLandingPageMinimapButton:SetParent(expansionlandingpageminimapbuttonframe)
ExpansionLandingPageMinimapButton:ClearAllPoints()
ExpansionLandingPageMinimapButton:SetAllPoints(expansionlandingpageminimapbuttonframe)
expansionlandingpageminimapbuttonframe:SetPoint("TOP",Minimap,"BOTTOMRIGHT",0,-30)
expansionlandingpageminimapbuttonframe:Show()
minimap.expansionlandingpageminimapbuttonframe = expansionlandingpageminimapbuttonframe
end
