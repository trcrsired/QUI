local QUI = LibStub("AceAddon-3.0"):NewAddon("QUI","AceEvent-3.0","AceConsole-3.0","AceHook-3.0")

QUI.UIHider = CreateFrame("Frame")
QUI.UIHider:Hide()
QUI[1] = {}

local C_AddOns = C_AddOns
if C_AddOns == nil then
QUI.C_AddOns =
{
LoadAddOn = LoadAddOn,
GetNumAddOns = GetNumAddOns,
GetAddOnMetadata = GetAddOnMetadata,
IsAddOnLoaded = IsAddOnLoaded,
GetAddOnInfo = GetAddOnInfo,
GetAddOnDependencies = GetAddOnDependencies
}
else
	QUI.C_AddOns = C_AddOns
end

local QUI_C_AddOns = QUI.C_AddOns
local GetAddOnMetadata = QUI_C_AddOns.GetAddOnMetadata
local GetAddOnInfo = QUI_C_AddOns.GetAddOnInfo
local GetNumAddOns = QUI_C_AddOns.GetNumAddOns
local IsAddOnLoaded = QUI_C_AddOns.IsAddOnLoaded
local LoadAddOn = QUI_C_AddOns.LoadAddOn


function QUI:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("QUIDB",{profile = {}},true)
	local LibDualSpec = LibStub('LibDualSpec-1.0',true)
	if LibDualSpec then
		LibDualSpec:EnhanceDatabase(self.db, "QUI")
	end
	self:RegisterChatCommand("QUI", "ChatCommand")

	self:RegisterEvent("ADDON_LOADED")
	local lods = {}
	local GetAddOnMetadata = GetAddOnMetadata
	for i=1,GetNumAddOns() do
		local conflict = GetAddOnMetadata(i,"X-QUI-CONFLICT")
		if conflict and not IsAddOnLoaded(conflict) then
			LoadAddOn(i)
		end
		local meta = GetAddOnMetadata(i,"X-QUI-LOD")
		if meta then
			local addon, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i)
			if loadable == "DEMAND_LOADED" then
				lods[meta] = i
			end
		end
	end
	if next(lods) then
		QUI.lods = lods
		QUI:RegisterEvent("ADDON_LOADED")
	else
		QUI.ADDON_LOADED = nil
	end
	QUI.OnInitialize = nil
end

function QUI:ChatCommand(input)
end

function QUI:ADDON_LOADED(event,addon,...)
	local lods = QUI.lods
	local index = QUI.lods[addon]
	if not index then return end
	LoadAddOn(index)
	lods[addon] = nil
	if next(lods) == nil then
		QUI:UnregisterEvent("ADDON_LOADED")
		QUI.ADDON_LOADED = nil
	end
end

function QUI.resume(current,...)
	local current_status = coroutine.status(current)
	if current_status =="suspended" then
		local status, msg = coroutine.resume(current,...)
		if not status then
			QUI:Print(msg)
		end
		return status,msg
	end
	return current_status
end

function QUI.KillFrame(frame)
	if frame == nil then
		return
	end
	local hasevent = frame.UnregisterAllEvents
	if hasevent then
		frame:UnregisterAllEvents()
	end
	frame:SetAlpha(0)
	frame:SetScale(0.00001)
	frame:SetParent(QUI.UIHider)
	local hasmouse = frame.EnableMouse
	if hasmouse then
		frame:EnableMouse(false)
	end
	local hassetattribute = frame.SetAttribute
	if hassetattribute then
		frame:SetAttribute("statehidden", true)
	end
end

function QUI.setalphazeroframe(frame)
	if frame == nil then
		return
	end
	if frame.SetAlpha == nil then
		return
	end
	frame:SetAlpha(0)
end

function QUI.KillFrameNineSlice(frame)
	if frame == nil then
		return
	end
	local setalphazeroframe = QUI.setalphazeroframe
	setalphazeroframe(frame.NineSlice)
	setalphazeroframe(frame.topLeftCorner)
	setalphazeroframe(frame.topRightCorner)
	setalphazeroframe(frame.bottomLeftCorner)
	setalphazeroframe(frame.bottomRightCorner)
	setalphazeroframe(frame.topEdge)
	setalphazeroframe(frame.bottomEdge)
	setalphazeroframe(frame.leftEdge)
	setalphazeroframe(frame.rightEdge)
	setalphazeroframe(frame.center)

	setalphazeroframe(frame.TopTileStreaks)
	if frame.Bg then
		frame.Bg:SetTexture(131071)
	end
	if frame.TitleBg then
		frame.TitleBg:SetTexture(131071)
	end
end

function QUI.KillFrameBackgroundBySearch(frame,texture,besides)
	if frame == nil then
		return
	end
	local regions = {frame:GetRegions()}
	for i=1,#regions do
		local region = regions[i]
		if region:IsObjectType("Texture") then
			local regiontexture = region:GetTexture()
			local killit
			if besides then
				if regiontexture~=texture then
					killit = true
				end
			elseif region == nil or regiontexture==texture then
				killit = true
			end
			if killit then
				region:SetAlpha(0)
			end
		end
	end	
end

function QUI.KillFrameBorderBySearch(frame)
	if frame == nil then
		return
	end
	for k,v in pairs(frame) do
		if type(k)=="string" and type(v)=="table" and (k:find("Edge") or k:find("Corner")) then
			v:SetAlpha(0)
		end
	end
end

function QUI.KillFrameLMRBorder(frame)
	if frame == nil then
		return
	end
	local tp = type(frame) == "string"
	local setalphazeroframe = QUI.setalphazeroframe
	if tp then
		setalphazeroframe(_G[frame.."Left"])
		setalphazeroframe(_G[frame.."LeftDisabled"])
		setalphazeroframe(_G[frame.."Middle"])
		setalphazeroframe(_G[frame.."MiddleDisabled"])
		setalphazeroframe(_G[frame.."Right"])
		setalphazeroframe(_G[frame.."RightDisabled"])
	else
		setalphazeroframe(frame.Left)
		setalphazeroframe(frame.LeftDisabled)
		setalphazeroframe(frame.Middle)
		setalphazeroframe(frame.MiddleDisabled)
		setalphazeroframe(frame.Right)
		setalphazeroframe(frame.RightDisabled)
	end
end

function QUI.KillFrameBorderInset(frame)
	if frame == nil then
		return
	end
	local tp = type(frame) == "string"
	local setalphazeroframe = QUI.setalphazeroframe
	if tp then
		setalphazeroframe(_G[frame.."Border"])
		setalphazeroframe(_G[frame.."Inset"])
	else
		setalphazeroframe(frame.Border)
		setalphazeroframe(frame.Inset)
	end
end

function QUI.TextureIcons(frame)
	if frame == nil then
		return
	end
	local icon = frame.icon
	if icon then
		icon:SetTexCoord(0.1,0.9,0.1,0.9)
	end
	local iconborder = frame.IconBorder
	if iconborder then
		frame.IconBorder:SetAlpha(0)
	end
	if frame.SetNormalTexture then
		frame:SetNormalTexture("")
	end
end

function QUI.skin_texture_cord(texture)
	if texture == nil then
		return
	end
	local SetTexCoord = texture.SetTexCoord
	if texture.SetTexCoord then
		texture:SetTexCoord(0.22, 0.7, 0.28, 0.7)
	end
end

function QUI.skin_button(box)
	if box == nil then
		return
	end
	if box.GetNormalTexture then
		QUI.skin_texture_cord(box:GetNormalTexture())
	end
	if box.GetPushedTexture then
		QUI.skin_texture_cord(box:GetPushedTexture())
	end
	if box.GetHighlightTexture then
		QUI.skin_texture_cord(box:GetHighlightTexture())
	end
	if box.GetDisabledTexture then
		QUI.skin_texture_cord(box:GetDisabledTexture())
	end

	local left = box.Left

	local middle = box.Middle

	local right = box.Right

	if left then
		left:SetAlpha(0)
	end
	if middle then
		middle:SetAlpha(0)
	end
	if right then
		right:SetAlpha(0)
	end
	if box.SetNormalTexture then
		box:SetNormalTexture([[Interface\DialogFrame\UI-DialogBox-Background-Dark]])
	end
	if box.SetHighlightTexture then
		box:SetHighlightTexture([[Interface\DialogFrame\UI-DialogBox-Gold-Background]])
	end
end

function QUI.skin_dropdown(dropdownstr)
	if dropdownstr == nil then
		return
	end
	local tb = _G[dropdownstr]
	if tb == nil then
		return
	end
	local left = _G[dropdownstr.."Left"]
	if left == nil then
		left = tb.left
	end

	local middle = _G[dropdownstr.."Middle"]
	if middle == nil then
		middle = tb.middle
	end

	local right = _G[dropdownstr.."Right"]
	if right == nil then
		right = tb.right
	end

	if left then
		left:SetAlpha(0)
	end
	if middle then
		middle:SetAlpha(0)
	end
	if right then
		right:SetAlpha(0)
	end
	if dropdownstr.SetNormalTexture then
		dropdownstr:SetNormalTexture([[Interface\DialogFrame\UI-DialogBox-Background-Dark]])
	end
	if dropdownstr.SetHighlightTexture then
		dropdownstr:SetHighlightTexture([[Interface\DialogFrame\UI-DialogBox-Gold-Background]])
	end
end

function QUI.skin_scrollframe(scollframe)
	if scollframe == nil then
		return
	end
	local tb=scollframe
	local scollframetype = type(scollframe)
	local scollframeisstring = scollframetype == "string"
	if scollframeisstring then
		tb = _G[scollframe]
		if tb == nil then
			return
		end
	end
	QUI.KillFrameNineSlice(tb)
--[[

	QUI.setalphazeroframe(_G[scollframe.."ScrollFrame"])
	QUI.setalphazeroframe(tb.ScrollBox)
]]
	if tb.ScrollBar then
		tb.ScrollBar:SetAlpha(0)
	end
	if scollframeisstring then
		QUI.setalphazeroframe(_G[scollframe.."Inset"])
	end
	QUI.setalphazeroframe(tb.inset)
end

function QUI.skin_naiveskinframe(str)
	local frame = _G[str]
	local header = frame.Header
	if header == nil then
		return
	end
	header.LeftBG:Hide()
	header.CenterBG:Hide()
	header.RightBG:Hide()
	local header_text = header.Text
	header_text:ClearAllPoints()
	header_text:SetPoint("TOP",frame,"TOP",0,-15)
	for k,v in pairs(frame.Border) do
		if type(k)=="string" and type(v)=="table" and (k:find("Edge") or k:find("Corner")) then
			v:SetAlpha(0)
		end
	end
end


function QUI.skin_buttons_in_frame(frame)
	if frame == nil then
		return
	end
	if frame.GetChildren == nil then
		return
	end
	local slots = {frame:GetChildren()}
	local _G = _G
	for i=1,#slots do
		local slot=slots[i]
		if slot:IsObjectType("Button") or slot:IsObjectType("ItemButton") then
			QUI.setalphazeroframe(_G[slot:GetName().."Frame"])
			slot:SetNormalTexture("")
			slot:GetHighlightTexture():SetTexCoord(0.1,0.9,0.1,0.9)
			if slot:GetPushedTexture() then
				if slot:GetPushedTexture().SetTexCoord then
					slot:GetPushedTexture():SetTexCoord(0.1,0.9,0.1,0.9)
				end
			end
			QUI.TextureIcons(slot)
		end
	end
end


function QUI.killframecorneredge(frame)
	if frame then
		for k,v in pairs(frame) do
			if type(k) == "string" and (k:find("Corner") or k:find("Edge")) and type(v)=="table" then
				v:SetAlpha(0)
			end
		end
	end
end

function QUI.skinauraiconframes(frame)
	if frame == nil then
		return
	end
	local auraframes = frame.auraFrames
	for i=1,#auraframes do
		local icon = auraframes[i].Icon
		if icon then
			local settexcoord = icon.SetTexCoord
			if settexcoord then
				settexcoord(icon,0.1,0.9,0.1,0.9)
			end
		end
	end
end

function QUI.skin_checkbox(box)
	if box == nil then
		return
	end
	if box.GetNormalTexture then
		box:GetNormalTexture():SetTexCoord(0.3, 0.7, 0.3, 0.7)
		if box.GetPushedTexture then
			box:GetPushedTexture():SetTexCoord(0.3, 0.7, 0.3, 0.7)
		end
		if box.GetHighlightTexture then
			local texture = box:GetHighlightTexture()
			if texture then
				texture:SetTexCoord(0.3, 0.7, 0.3, 0.7)
			end
		end
		if box.GetCheckedTexture then
			box:GetCheckedTexture():SetTexCoord(0.2, 0.9, 0.1 ,0.9)
		end
		if box.SetScale then
			box:SetScale(0.7)
		end
	end
end

local UnitAura = UnitAura
if UnitAura then
QUI.UnitAura = UnitAura
else

local C_UnitAuras_GetAuraDataByIndex = C_UnitAuras.GetAuraDataByIndex
local AuraUtil_UnpackAuraData = AuraUtil.UnpackAuraData

function QUI.UnitAura(...)
	local auraData = C_UnitAuras_GetAuraDataByIndex(...)
	if not auraData then
		return
	end
	return AuraUtil_UnpackAuraData(auraData)
end

end