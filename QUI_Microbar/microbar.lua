local QUI = LibStub("AceAddon-3.0"):GetAddon("QUI")

if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then

do
local microbar = CreateFrame("Frame",nil,UIParent)
microbar:SetPoint("TOPLEFT",UIParent,"TOPLEFT",0,0)
local MICRO_BUTTONS = MICRO_BUTTONS
local _G = _G
local width,height=_G[MICRO_BUTTONS[1]]:GetSize()
microbar:SetSize(width,height*#MICRO_BUTTONS)
QUI.microbar = microbar
local MICRO_BUTTONS = MICRO_BUTTONS

if GuildMicroButton then
QUI.KillFrame(GuildMicroButton.NotificationOverlay)
end

local function on_enter()
	for i=1,#MICRO_BUTTONS do
		local microbutton = _G[MICRO_BUTTONS[i]]
		local pushed = microbutton:GetPushedTexture()
		local normal = microbutton:GetNormalTexture()
		local disabled = microbutton:GetDisabledTexture()
		pushed:SetAlpha(1)
		normal:SetAlpha(1)
		if disabled then
			disabled:SetAlpha(1)
		end
	end
	MicroButtonPortrait:Show()
	if GuildMicroButtonTabard then
		GuildMicroButtonTabard:Show()
	end
end
MainMenuBarPerformanceBar:SetAlpha(0)
MainMenuBarPerformanceBar:SetScale(0.00001)
local function on_leave()
	for i=1,#MICRO_BUTTONS do
		local microbutton = _G[MICRO_BUTTONS[i]]
		local pushed = microbutton:GetPushedTexture()
		local normal = microbutton:GetNormalTexture()
		local disabled = microbutton:GetDisabledTexture()
		pushed:SetAlpha(0)
		normal:SetAlpha(0)
		if disabled then
			disabled:SetAlpha(0)
		end
	end
	MicroButtonPortrait:Hide()
	if GuildMicroButtonTabard then
		GuildMicroButtonTabard:Hide()
	end
end
if GuildMicroButtonTabard then
GuildMicroButtonTabard.background:SetParent(GuildMicroButtonTabard)
GuildMicroButtonTabard.background:SetTexCoord(0.17, 0.87, 0.5, 0.908)
end
MicroButtonPortrait:SetAllPoints(CharacterMicroButton)
on_leave()

for i=1,#MICRO_BUTTONS do
	local microbutton = _G[MICRO_BUTTONS[i]]
	local pushed = microbutton:GetPushedTexture()
	local normal = microbutton:GetNormalTexture()
	local disabled = microbutton:GetDisabledTexture()
	pushed:SetTexCoord(0.22, 0.81, 0.26, 0.82)
	normal:SetTexCoord(0.22, 0.81, 0.26, 0.82)
	if disabled then
		disabled:SetTexCoord(0.22, 0.81, 0.26, 0.82)
	end
	microbutton:HookScript("OnEnter",on_enter)
	microbutton:HookScript("OnLeave",on_leave)
end

end
if GuildMicroButtonTabard then
function QUI:UpdateMicroButtons()
	local pushed = GuildMicroButton:GetNormalTexture()
	if pushed:GetAlpha() == 0 then
		GuildMicroButtonTabard:Hide()
	else
		GuildMicroButtonTabard:Show()
	end
end
QUI:SecureHook("UpdateMicroButtons")
end
MoveMicroButtons("TOPLEFT", QUI.microbar, "TOPLEFT", 0,0)

function QUI:MoveMicroButtons(point,frame)
	if frame ~= QUI.microbar then
		MoveMicroButtons("TOPLEFT", QUI.microbar, "TOPLEFT", 0,0)
		if GuildMicroButtonTabard then
			GuildMicroButtonTabard:Hide()
		end
	end
end

function QUI:UpdateMicroButtonsParent()
	for i=1,#MICRO_BUTTONS do
		_G[MICRO_BUTTONS[i]]:SetParent(QUI.microbar)
	end
end

QUI:UpdateMicroButtonsParent()
QUI:SecureHook("UpdateMicroButtonsParent")
QUI:SecureHook("MoveMicroButtons")

end
