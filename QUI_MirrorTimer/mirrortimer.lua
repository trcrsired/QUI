local _G = _G
for i=1,MIRRORTIMER_NUMTIMERS do
	local mirot = _G["MirrorTimer"..i]
	local border = mirot.Border
	if border == nil then
		border = _G["MirrorTimer"..i.."Border"]
	end
	border:SetAlpha(0)
	local statusbar = mirot.StatusBar
	if statusbar == nil then
		statusbar = _G["MirrorTimer"..i.."StatusBar"]
	end
	statusbar:SetStatusBarTexture("interface/buttons/white8x8")
	local text = mirot.Text
	if text == nil then
		text = _G["MirrorTimer"..i.."Text"]
	end
	text:ClearAllPoints()
	text:SetPoint("TOP",statusbar,"TOP",0,0)
end
