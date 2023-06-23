local QUI = LibStub("AceAddon-3.0"):GetAddon("QUI")
local skinscrollframe = QUI.skin_scrollframe
skinscrollframe(GossipFrame)

if GossipGreetingScrollFrameTop then
GossipGreetingScrollFrameTop:SetAlpha(0)
GossipGreetingScrollFrameMiddle:SetAlpha(0)
GossipGreetingScrollFrameBottom:SetAlpha(0)
GossipGreetingScrollFrameScrollBar:SetAlpha(0)
end

local function skinbutton(button)
	button.Left:SetAlpha(0)
	button.Middle:SetAlpha(0)
	button.Right:SetAlpha(0)
	button:SetNormalTexture([[Interface\DialogFrame\UI-DialogBox-Background-Dark]])
	button:SetHighlightTexture("")
end

if GossipFrameGreetingGoodbyeButton then
skinbutton(GossipFrameGreetingGoodbyeButton)
end

QUI.KillFrameNineSlice(QuestFrame)


skinbutton(QuestFrameCompleteQuestButton)
skinbutton(QuestFrameGoodbyeButton)
skinbutton(QuestFrameCompleteButton)
skinbutton(QuestFrameDeclineButton)
skinbutton(QuestFrameAcceptButton)
skinbutton(QuestFrameGreetingGoodbyeButton)

skinscrollframe(QuestRewardScrollFrame)
skinscrollframe(QuestDetailScrollFrame)
skinscrollframe(QuestGreetingScrollFrame)
skinscrollframe(QuestNPCModelTextScrollFrame)
