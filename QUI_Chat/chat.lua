local QUI = LibStub("AceAddon-3.0"):GetAddon("QUI")
local skinbutton = QUI.skin_button

local _G = _G

for i=1,10 do
	local t =_G["ChatFrame"..i.."Tab"]
	t.leftTexture:SetAlpha(0)
	t.middleTexture:SetAlpha(0)
	t.rightTexture:SetAlpha(0)
	t.leftSelectedTexture:SetAlpha(0)
	t.middleSelectedTexture:SetAlpha(0)
	t.rightSelectedTexture:SetAlpha(0)
	_G["ChatFrame"..i.."EditBoxLeft"]:SetAlpha(0)
	_G["ChatFrame"..i.."EditBoxRight"]:SetAlpha(0)
	_G["ChatFrame"..i.."EditBoxMid"]:SetAlpha(0)
	local EditBoxLeft = _G["ChatFrame"..i.."EditBoxFocusLeft"]
	if EditBoxLeft then
		_G["ChatFrame"..i.."EditBoxFocusLeft"]:SetAlpha(0)
		_G["ChatFrame"..i.."EditBoxFocusRight"]:SetAlpha(0)
		_G["ChatFrame"..i.."EditBoxFocusMid"]:SetAlpha(0)
	end
	_G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false)
end
skinbutton(ChatFrameMenuButton)
skinbutton(ChatFrameChannelButton)
skinbutton(ChatFrameToggleVoiceDeafenButton)
skinbutton(ChatFrameToggleVoiceMuteButton)
QUI.KillFrame(QuickJoinToastButton)
