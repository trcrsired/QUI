local QUI = LibStub("AceAddon-3.0"):GetAddon("QUI")
local skinbutton = QUI.skin_button

local _G = _G
local setalphazeroframe = QUI.setalphazeroframe
for i=1,10 do
	local t =_G["ChatFrame"..i.."Tab"]
	setalphazeroframe(t.left)
	setalphazeroframe(t.middle)
	setalphazeroframe(t.right)
	setalphazeroframe(t.leftActive)
	setalphazeroframe(t.middleActive)
	setalphazeroframe(t.rightActive)

	setalphazeroframe(t.leftTexture)
	setalphazeroframe(t.middleTexture)
	setalphazeroframe(t.rightTexture)
	setalphazeroframe(t.leftSelectedTexture)
	setalphazeroframe(t.middleSelectedTexture)
	setalphazeroframe(t.rightSelectedTexture)

	setalphazeroframe(_G["ChatFrame"..i.."EditBoxLeft"])
	setalphazeroframe(_G["ChatFrame"..i.."EditBoxRight"])
	setalphazeroframe(_G["ChatFrame"..i.."EditBoxMid"])
	setalphazeroframe(_G["ChatFrame"..i.."EditBoxFocusLeft"])
	setalphazeroframe(_G["ChatFrame"..i.."EditBoxFocusRight"])
	setalphazeroframe(_G["ChatFrame"..i.."EditBoxFocusMid"])
	_G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false)
end
skinbutton(ChatFrameMenuButton)
skinbutton(ChatFrameChannelButton)
skinbutton(ChatFrameToggleVoiceDeafenButton)
skinbutton(ChatFrameToggleVoiceMuteButton)
QUI.KillFrame(QuickJoinToastButton)
