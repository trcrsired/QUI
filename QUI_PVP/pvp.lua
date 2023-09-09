local QUI = LibStub("AceAddon-3.0"):GetAddon("QUI")

local skin_checkbox = QUI.skin_checkbox

HonorFrame.ConquestBar.Border:Hide()
HonorFrame.ConquestBar.Background:SetTexture([[Interface\DialogFrame\UI-DialogBox-Background-Dark]])
ConquestFrame.ConquestBar.Border:Hide()
ConquestFrame.ConquestBar.Background:SetTexture([[Interface\DialogFrame\UI-DialogBox-Background-Dark]])

HonorFrame.QueueButton.Left:SetAlpha(0)
HonorFrame.QueueButton.Middle:SetVertexColor(0,0,0,1)
HonorFrame.QueueButton.Right:SetAlpha(0)
HonorFrame.QueueButton:SetHighlightTexture("")
ConquestFrame.JoinButton.Left:SetAlpha(0)
ConquestFrame.JoinButton.Middle:SetVertexColor(0,0,0,1)
ConquestFrame.JoinButton.Right:SetAlpha(0)
ConquestFrame.JoinButton:SetHighlightTexture("")

HonorFrameTypeDropDownLeft:SetAlpha(0)
HonorFrameTypeDropDownMiddle:SetTexture("Interface\\Common\\Common-Input-Border")
HonorFrameTypeDropDownMiddle:SetHeight(20)
HonorFrameTypeDropDownMiddle:SetTexCoord(0.0625,0.9375,0.1,0.525)
HonorFrameTypeDropDownRight:SetAlpha(0)
local button = HonorFrameTypeDropDown.Button
button:GetNormalTexture():SetTexCoord(0.25,0.75,0.28,0.75)
button:GetDisabledTexture():SetTexCoord(0.25,0.75,0.28,0.75)
button:GetPushedTexture():SetTexCoord(0.25,0.75,0.28,0.75)
button:GetHighlightTexture():SetTexCoord(0.25,0.75,0.28,0.75)

HonorFrame.TankIcon:SetPoint("BOTTOMLEFT",HonorFrame.Inset,"TOPLEFT",9,7)
skin_checkbox(HonorFrame.TankIcon.checkButton)
skin_checkbox(HonorFrame.HealerIcon.checkButton)
skin_checkbox(HonorFrame.DPSIcon.checkButton)
HonorFrame.BonusFrame.WorldBattlesTexture:Hide()
HonorFrame.Inset:Hide()

ConquestFrame.TankIcon:SetPoint("BOTTOMLEFT",ConquestFrame.Inset,"TOPLEFT",9,7)
skin_checkbox(ConquestFrame.TankIcon.checkButton)
skin_checkbox(ConquestFrame.HealerIcon.checkButton)
skin_checkbox(ConquestFrame.DPSIcon.checkButton)
ConquestFrame.RatedBGTexture:Hide()
ConquestFrame.Inset:Hide()

local ConquestTooltip = ConquestTooltip

ConquestTooltip:SetBackdropColor(0,0,0,1)
ConquestTooltip:SetBackdropBorderColor(0,0,0,0)

local HonorInset = PVPQueueFrame.HonorInset

PVPQueueFrame.HonorInset.NineSlice:SetAlpha(0)

local regions = {HonorInset:GetRegions()}
regions[1]:SetTexture([[Interface\DialogFrame\UI-DialogBox-Background]])

regions[1]:Show()
regions[2]:SetAlpha(0)
