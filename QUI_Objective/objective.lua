if ObjectiveTrackerFrame and ObjectiveTrackerFrame.HeaderMenu then
local m = ObjectiveTrackerFrame.HeaderMenu.MinimizeButton
if m == nil then
	return
end
m:SetNormalTexture("interface/buttons/white8x8")
m:GetNormalTexture():SetVertexColor(1,0,1,0.2)
m:SetPushedTexture("interface/buttons/white8x8")
m:GetPushedTexture():SetVertexColor(1,0,1,0.2)
end
