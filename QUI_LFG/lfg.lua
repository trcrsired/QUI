local QUI = LibStub("AceAddon-3.0"):GetAddon("QUI")

local function SetModifiedBackdrop(widget)
	QUI[1][widget]:SetTexture([[Interface\DialogFrame\UI-DialogBox-Gold-Background]])
end

local function SetOriginalBackdrop(widget)
	QUI[1][widget]:SetTexture([[Interface\DialogFrame\UI-DialogBox-Background-Dark]])
end

local function skininvitedialogbutton(button)
	button.Left:SetAlpha(0)
	button.Middle:SetVertexColor(0,0,0,1)
	button.Right:SetAlpha(0)
	button:SetHighlightTexture("")
end

local function skinbutton(button)
	if button == nil then
		return
	end
	local backdrops = QUI[1]
	if backdrops[button] then return end
	if button.SetNormalTexture then button:SetNormalTexture("") end
	if button.SetHighlightTexture then button:SetHighlightTexture("") end
	if button.SetPushedTexture then button:SetPushedTexture("") end
	if button.SetDisabledTexture then button:SetDisabledTexture("") end
	QUI.KillFrameBackgroundBySearch(button,1416467,true)
	local backdrop = button:CreateTexture(nil, "BACKGROUND")
	backdrop:SetAllPoints()
	backdrops[button] = backdrop
	SetOriginalBackdrop(button)
	button:HookScript("OnEnter", SetModifiedBackdrop)
	button:HookScript("OnLeave", SetOriginalBackdrop)
end

QUI:RegisterMessage("LFG_QUEST_BUTTON",function(message,button,questID,block)
	button:SetSize(22,22)
	skinbutton(button)
end)

local function skineditbox(w)
	w.Left:Hide()
	w.Right:Hide()
	w.Middle:SetTexCoord(0.0625,0.9375,0.15,0.525)
end

skineditbox(LFGListFrame.EntryCreation.Name)
skineditbox(LFGListFrame.EntryCreation.VoiceChat.EditBox)
skineditbox(LFGListFrame.SearchPanel.SearchBox)

local Description = LFGListFrame.EntryCreation.Description
for k,v in pairs(Description) do
	if type(k) == "string" and k:find("Tex") then
		v:Hide()
	end
end

Description.MiddleTex:Show()

QUI.killframecorneredge(LFGListInviteDialog.Border)


skininvitedialogbutton(LFGListInviteDialog.AcceptButton)
skininvitedialogbutton(LFGListInviteDialog.DeclineButton)
skininvitedialogbutton(LFGListInviteDialog.AcknowledgeButton)

skininvitedialogbutton(LFGListApplicationDialog.SignUpButton)
skininvitedialogbutton(LFGListApplicationDialog.CancelButton)

QUI.killframecorneredge(LFGListApplicationDialog.Border)

for k,v in pairs(LFGListApplicationDialog.Description) do
	if type(k) == "string" and type(v) == "table" and k:find("Tex$") then
		v:SetAlpha(0)
	end
end
