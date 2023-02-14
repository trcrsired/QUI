local QUI = LibStub("AceAddon-3.0"):GetAddon("QUI")
QUI.KillFrameNineSlice(GossipFrame)

GossipGreetingScrollFrameTop:SetAlpha(0)
GossipGreetingScrollFrameMiddle:SetAlpha(0)
GossipGreetingScrollFrameBottom:SetAlpha(0)
GossipGreetingScrollFrameScrollBar:SetAlpha(0)


local function skinbutton(button)
	button.Left:SetAlpha(0)
	button.Middle:SetAlpha(0)
	button.Right:SetAlpha(0)
	button:SetNormalTexture([[Interface\DialogFrame\UI-DialogBox-Background-Dark]])
	button:SetHighlightTexture("")
end

skinbutton(GossipFrameGreetingGoodbyeButton)

QUI.KillFrameNineSlice(QuestFrame)


skinbutton(QuestFrameCompleteQuestButton)
skinbutton(QuestFrameGoodbyeButton)
skinbutton(QuestFrameCompleteButton)
skinbutton(QuestFrameDeclineButton)
skinbutton(QuestFrameAcceptButton)
skinbutton(QuestFrameGreetingGoodbyeButton)

local function skinscrollframe(frame)
	local name = frame:GetName()
	_G[name.."Top"]:SetAlpha(0)
	_G[name.."Middle"]:SetAlpha(0)
	_G[name.."Bottom"]:SetAlpha(0)
	_G[name.."ScrollBar"]:SetAlpha(0)
end

skinscrollframe(QuestRewardScrollFrame)
skinscrollframe(QuestDetailScrollFrame)
skinscrollframe(QuestGreetingScrollFrame)
--skinscrollframe(QuestNPCModelTextScrollFrame)
