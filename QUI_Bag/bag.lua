local QUI = LibStub("AceAddon-3.0"):GetAddon("QUI")
local function on_enter()
	MainMenuBarBackpackButton.icon:SetAlpha(1)
	MainMenuBarBackpackButton.Count:SetAlpha(1)
	for i=0,3 do
		local slot = _G["CharacterBag"..i.."Slot"]
		slot.icon:SetAlpha(1)
		slot.IconBorder:SetAlpha(1)
	end
end

local function on_leave()
	MainMenuBarBackpackButton.icon:SetAlpha(0)
	MainMenuBarBackpackButton.Count:SetAlpha(0)
	for i=0,3 do
		local slot = _G["CharacterBag"..i.."Slot"]
		slot.icon:SetAlpha(0)
		slot.IconBorder:SetAlpha(0)
	end
end

local function set_bag_background(texture)
	texture:SetVertexColor(0,0,0,0.4)
end

local function skinbag(name)
	local bagframe = _G[name]
	set_bag_background(_G[name.."BackgroundTop"])
	set_bag_background(_G[name.."BackgroundMiddle1"])
	set_bag_background(_G[name.."BackgroundMiddle2"])
	set_bag_background(_G[name.."BackgroundBottom"])
end

local function skinbutton(button)
	button:SetNormalTexture("")
	button.icon:SetTexCoord(0.1,0.9,0.1,0.9)
	button:SetParent(UIParent)
	button:HookScript("OnEnter",on_enter)
	button:HookScript("OnLeave",on_leave)
end

if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
	MainMenuBarBackpackButton:ClearAllPoints()
	MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT",0,0)
end

skinbutton(MainMenuBarBackpackButton)

for i=0,3 do
	skinbutton(_G["CharacterBag"..i.."Slot"])
end

on_leave()

for i=1,13 do
	skinbag("ContainerFrame"..i)
	for j=1,100 do
		local button =  _G["ContainerFrame"..i.."Item"..j]
		if button == nil then
			break
		end
		button:SetNormalTexture("")
		button.icon:SetTexCoord(0.1,0.9,0.1,0.9)
		button.IconBorder:SetAlpha(0)
	end
end

local function skin_auto_sort_button(button)
	if button == nil then
		return
	end
	button:GetNormalTexture():SetTexCoord(0.2,0.8,0.2,0.8)
	button:GetHighlightTexture():SetTexCoord(0.2,0.8,0.2,0.8)
	button:GetPushedTexture():SetTexCoord(0.2,0.8,0.2,0.8)
end

skin_auto_sort_button(BagItemAutoSortButton)
skin_auto_sort_button(BankItemAutoSortButton)


local selljunkbutton=CreateFrame("Button",nil,ContainerFrame1)
QUI.selljunkbutton = selljunkbutton
selljunkbutton:SetSize(20,20)
selljunkbutton:SetNormalAtlas("bags-junkcoin")
local BagItemSearchBox = BagItemSearchBox
if BagItemSearchBox == nil then
	selljunkbutton:SetPoint("TOPLEFT",ContainerFrame1,"TOP",0,-25)
else
	selljunkbutton:SetPoint("RIGHT",BagItemSearchBox,"LEFT",-4,-5)
end

selljunkbutton:SetScript("OnClick",function()
	if GetMerchantItemInfo(1) then
		local GetContainerItemInfo = GetContainerItemInfo
		local le_item_quality_poor = Enum.ItemQuality.Poor
		for i=0,NUM_BAG_SLOTS do
			for j=1,GetContainerNumSlots(i) do
				local texture, itemCount, locked, quality, readable, lootable, itemLink , isFiltered, noValue, itemID = GetContainerItemInfo(i,j)
				if quality == le_item_quality_poor and not noValue then
					UseContainerItem(i,j)
				end
			end
		end
	end
end)
selljunkbutton:SetScript("OnEnter",function(self)
	GameTooltip:SetOwner(self,"ANCHOR_TOPRIGHT")
	GameTooltip:AddLine(BAG_FILTER_JUNK)
	GameTooltip:Show()
end)
selljunkbutton:SetScript("OnLeave",function()
	GameTooltip:Hide()
end)
selljunkbutton:Show()

local function skin_item_search_box(box)
	if box == nil then
		return
	end
	box.Left:Hide()
	box.Middle:Hide()
	box.Right:Hide()
end

QUI.KillFrameNineSlice(BankFrame)

skin_item_search_box(BagItemSearchBox)
skin_item_search_box(BankItemSearchBox)
QUI.KillFrameBackgroundBySearch(BankSlotsFrame)
QUI.KillFrameBackgroundBySearch(BankFrame,"Interface\\BankFrame\\Bank-Background")

QUI.KillFrameLMRBorder(BankFrameTab1)
QUI.KillFrameLMRBorder(BankFrameTab2)

QUI.KillFrameBorderInset(BankFrameMoneyFrame)


local BankSlotsFrame = BankSlotsFrame
for i=1,7 do
	QUI.TextureIcons(BankSlotsFrame["Bag"..i])
end

for i=1,NUM_BANKGENERIC_SLOTS do
	QUI.TextureIcons(BankSlotsFrame["Item"..i])
end

if ReagentBankFrame then
QUI:SecureHookScript(ReagentBankFrame,"OnShow",function()
	remove_shadow(ReagentBankFrame)
	for i=1,98 do
		QUI.TextureIcons(ReagentBankFrame["Item"..i])
	end
	QUI:Unhook(ReagentBankFrame,"OnShow")
end)

local DespositButton = ReagentBankFrame.DespositButton

if DespositButton then
ReagentBankFrame.DespositButton.Left:SetAlpha(0)
ReagentBankFrame.DespositButton.Right:SetAlpha(0)
ReagentBankFrame.DespositButton.Middle:SetVertexColor(0,0,0,1)
ReagentBankFrame.DespositButton:SetHighlightTexture("")
end
end