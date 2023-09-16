local QUI = LibStub("AceAddon-3.0"):GetAddon("QUI")
local ActionBar = QUI:NewModule("ActionBar","AceEvent-3.0")

do
	local KillFrame = QUI.KillFrame
	KillFrame(MultiBarBottomLeft)
	KillFrame(MultiBarBottomRight)
	KillFrame(MultiBarLeft)
	KillFrame(MultiBarRight)
	-- Hide MultiBar Buttons, but keep the bars alive

	if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
		for i=1,12 do
			KillFrame(_G["ActionButton" .. i])
			KillFrame(_G["MultiBarBottomLeftButton" .. i])
			KillFrame(_G["MultiBarBottomRightButton" .. i])
			KillFrame(_G["MultiBarLeftButton" .. i])
			KillFrame(_G["MultiBarRightButton" .. i])
			KillFrame(_G["VehicleMenuBarActionButton" .. i])
			KillFrame(_G["OverrideActionBarButton" .. i])
			KillFrame(_G["MultiCastActionButton" .. i])
		end
	end
	if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
		if ActionBarController then
			ActionBarController:UnregisterAllEvents()
		end
		ActionBarController:RegisterEvent('PLAYER_ENTERING_WORLD')
	end
	KillFrame(MainMenuBar)
	if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
		if MicroButtonAndBagsBar then
			MicroButtonAndBagsBar:Show()
		end
		KillFrame(MicroButtonAndBagsBar)
	end
	KillFrame(MainMenuBarArtFrame)
	KillFrame(StatusTrackingBarManager)
	KillFrame(StanceBarFrame)
	KillFrame(OverrideActionBar)
	KillFrame(PossessBarFrame)
	KillFrame(PetActionBarFrame)
	KillFrame(MultiCastActionBarFrame)
end

local sformat = string.format
local GetBindingKey = GetBindingKey

local function getbindingkeyandfiltering(str)
	local text = GetBindingKey(str)
	if text then
		local n = text:len()
		if n > 1 then
			text = gsub(text, 'SHIFT%-', "S")
			text = gsub(text, 'ALT%-', "A")
			text = gsub(text, 'CTRL%-', "C")
			text = gsub(text, 'BUTTON', "MwB")
			text = gsub(text, 'MOUSEWHEELUP', "MwU")
			text = gsub(text, 'MOUSEWHEELDOWN', "MwD")
			text = gsub(text, 'NUMPAD', "Num")
			text = gsub(text, 'PAGEUP', "PgUp")
			text = gsub(text, 'PAGEDOWN', "PgDn")
			text = gsub(text, 'SPACE', "SpB")
			text = gsub(text, 'INSERT', "Ins")
			text = gsub(text, 'HOME', "Hm")
			text = gsub(text, 'DELETE', "Del")
			text = gsub(text, 'NMULTIPLY', "*")
			text = gsub(text, 'NMINUS', "-")
			text = gsub(text, 'NPLUS', "+")
			text = gsub(text, 'NEQUALS', "=")
		end
	end
	return text
end

local nop = nop
local HasVehicleActionBar = HasVehicleActionBar or nop
local HasOverrideActionBar = HasOverrideActionBar or nop
local HasTempShapeshiftActionBar = HasTempShapeshiftActionBar or nop
local HasBonusActionBar = HasBonusActionBar or nop
local GetVehicleBarIndex = GetVehicleBarIndex or nop
local GetBonusBarIndex = GetBonusBarIndex or nop
local GetOverrideBarIndex = GetOverrideBarIndex or nop
local GetTempShapeshiftBarIndex = GetTempShapeshiftBarIndex or nop
local GetActionBarPage = GetActionBarPage
local MainMenuBarArtFrameOrMenuBar = MainMenuBarArtFrame or MainMenuBar
local IsActionInRange = IsActionInRange
local UnitExists = UnitExists
local C_Timer = C_Timer
local NewTicker = C_Timer.NewTicker
local RegisterStateDriver = RegisterStateDriver
local CreateFramePool = CreateFramePool
local wipe = wipe
local GetTime = GetTime

local function get_action_bar_page()
	if HasVehicleActionBar() then
		return GetVehicleBarIndex()
	elseif HasOverrideActionBar() then
		return GetOverrideBarIndex()
	elseif HasTempShapeshiftActionBar() then
		return GetTempShapeshiftBarIndex()
	elseif HasBonusActionBar() then
		return GetBonusBarIndex()
	end
	local page = MainMenuBarArtFrameOrMenuBar:GetAttribute("actionpage")
	if page == nil then
		page = GetActionBarPage()
	end
	return page
end

local GameTooltip_SetDefaultAnchor = GameTooltip_SetDefaultAnchor
local GameTooltip = GameTooltip
local UIParent = UIParent

local function action_button_onenter(actionbutton)
	GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
	local action = actionbutton:GetAttribute("action")
	if action < 13 then
		action = (get_action_bar_page()-1)*12+action
	end
	GameTooltip:SetAction(action)
end

local function action_button_onleave()
	GameTooltip:Hide()
end

local UnitOnTaxi = UnitOnTaxi
local CanExitVehicle = CanExitVehicle or nop
local UnitControllingVehicle = UnitControllingVehicle or nop
local TAXI_CANCEL_DESCRIPTION = TAXI_CANCEL_DESCRIPTION
local BINDING_NAME_VEHICLEEXIT = BINDING_NAME_VEHICLEEXIT
local CreateFrame = CreateFrame
local IsUsableAction = IsUsableAction
local GetActionCount = GetActionCount
local GetActionTexture = GetActionTexture
local GetActionCharges = GetActionCharges
local GetActionCooldown = GetActionCooldown
local GetSpellCooldown = GetSpellCooldown
local FlyoutHasSpell = FlyoutHasSpell
local GetMacroSpell = GetMacroSpell
local GetActionInfo = GetActionInfo

local function leavevehicle_button_onenter(actionbutton)
	local text
	if UnitOnTaxi("player") then
		text = TAXI_CANCEL_DESCRIPTION
	elseif UnitControllingVehicle("player") and CanExitVehicle() then
		text = BINDING_NAME_VEHICLEEXIT
	end
	if text then
		GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
		GameTooltip:SetText(text)
	end
end

local function create(frame,ipstart,location,width,macro,vehicle)
	local templatename = "SecureActionButtonTemplate"
	if vehicle then
		templatename = "InsecureActionButtonTemplate"
	end
	local actionbutton = CreateFrame("Button",nil,frame,templatename)
	location = location * width
	actionbutton:SetPoint("TOPLEFT",frame,"TOPLEFT",location,0)
	actionbutton:SetPoint("BOTTOMLEFT",frame,"BOTTOMLEFT",location,0)
	actionbutton:SetWidth(width)
	local texture = actionbutton:CreateTexture(nil,"OVERLAY")
	texture:SetTexCoord(0.1,0.9,0.1,0.9)
	texture:SetAllPoints(actionbutton)
	actionbutton:SetMouseClickEnabled(true)
	actionbutton:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
	if vehicle then
		texture:SetTexture([[Interface\Icons\Spell_Shadow_SacrificialShield]])
		actionbutton:SetScript("OnClick",function()
			if UnitOnTaxi("player") and TaxiRequestEarlyLanding then
				TaxiRequestEarlyLanding()
			elseif UnitControllingVehicle and UnitControllingVehicle("player") and CanExitVehicle() then
				VehicleExit()
			elseif PetDismiss then
				PetDismiss()
			end
		end)
	else
		texture:SetTexture(GetActionTexture(ipstart))
		actionbutton:SetAttribute("type", "action")
		actionbutton:SetAttribute("action", ipstart)
	end
	actionbutton[2] = texture
	local cd = CreateFrame("Cooldown", nil, actionbutton, "CooldownFrameTemplate")
	cd:SetHideCountdownNumbers(true)
	actionbutton[3] = cd
	local charges = actionbutton:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	charges:SetPoint("BOTTOMRIGHT", actionbutton, "BOTTOMRIGHT",0, 0)
	charges:SetFont([[FONTS\FRIZQT__.ttf]],12)
	actionbutton[4] = charges
	local keybind = actionbutton:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	keybind:SetPoint("TOPRIGHT", actionbutton, "TOPRIGHT",0, 0)
	keybind:SetFont([[FONTS\FRIZQT__.ttf]],12)
	keybind:SetIndentedWordWrap(true)
	actionbutton[5] = keybind
	local cd_text = actionbutton:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	cd_text:SetPoint("CENTER", actionbutton, "CENTER",0, 0)
	cd_text:SetFont([[FONTS\FRIZQT__.ttf]],12)
	actionbutton[6] = cd_text
	local onenter = action_button_onenter
	if vehicle then
		onenter = leavevehicle_button_onenter
	end
	actionbutton:SetScript("OnEnter",onenter)
	actionbutton:SetScript("OnLeave",action_button_onleave)
	return actionbutton
end

local function maincofunc()
--	RegisterStateDriver(OverrideActionBar, "visibility", "[overridebar][vehicleui][possessbar,@vehicle,exists] show; hide")
	local gcd = 1.5
	local function update(index,button,gtime,current_page)
		if index < 13 then
			index = (current_page-1)*12+index
		end
		local texture = button[2]
		texture:SetTexture(GetActionTexture(index))
		local usable,oom = IsUsableAction(index)
		local alpha = usable and 1 or 0.3
		if oom then
			texture:SetVertexColor(0.1,0.1,1,alpha)
		else
			texture:SetVertexColor(1,1,1,alpha)
		end
		local currentCharges, maxCharges, cooldownStart, cooldownDuration, chargeModRate = GetActionCharges(index)
		local gg
		if currentCharges == maxCharges then
			cooldownStart,cooldownDuration,chargeModRate = GetActionCooldown(index)
			if maxCharges == 0 then
				local counts = GetActionCount(index)
				if counts~=0 then
					button[4]:SetText(counts)
				else
					button[4]:SetText(nil)
				end
			else
				button[4]:SetText(currentCharges)
			end
			if cooldownDuration <= gcd then
				if cooldownDuration == 0.001 then
					button[3]:SetCooldown(gtime,2147483647)
				else
					button[3]:SetCooldown(cooldownStart,cooldownDuration,chargeModRate)					
				end
				button[6]:SetText(nil)
				return
			end
		else
			button[4]:SetText(currentCharges)
		end
		if chargeModRate  == 0.001 then
			button[3]:SetCooldown(gtime,2147483647)
		else
			button[3]:SetCooldown(cooldownStart,cooldownDuration,chargeModRate)
		end
		gg = cooldownStart+cooldownDuration-gtime
		local cd = button[6]
		if gg < 0 then
			cd:SetText(nil)
			return
		elseif 30 < gg then
			cd:SetFormattedText("%.0f",gg)
			cd:SetTextColor(0,0,1,1)
		else
			cd:SetFormattedText("%.1f",gg)
			if 3 < gg then
				cd:SetTextColor(1,1,1,1)
			else
				cd:SetTextColor(1,0,0,1)
			end
		end
		return true
	end
	local buttons={}
	local function actionbar(start,...)
		local frame = CreateFrame("Frame",nil, UIParent,"SecureHandlerStateTemplate")
		frame:SetPoint(...)
		frame:SetSize(360,30)
		RegisterStateDriver(frame, "visibility", "[petbattle] hide; show")
		frame:SetAttribute("_onstate-visibility",[[
			if self:IsShown() then
				self:Hide()
			else
				self:Show()
			end
		]])
		start = start * 12
		local macro = start == 0
		for i = 1,12 do
			buttons[#buttons+1] = create(frame,i+start,i-1,30,macro)
		end
		if macro then
			RegisterStateDriver(frame, "page", "[possessbar] 12; [overridebar] 14; [shapeshift] 13; [form,noform] 0; [bar:1] 1; [bar:2] 2; [bar:3] 3; [bar:4] 4; [bar:5] 5; [bar:6] 6")
			
			if MainMenuBarArtFrame then
				frame:SetFrameRef("MainMenuBarArtFrame", MainMenuBarArtFrame)
				frame:SetAttribute("_onstate-page", [[self:GetFrameRef("MainMenuBarArtFrame"):SetAttribute("actionpage", newstate)]])
			else
				frame:SetFrameRef("MainMenuBar", MainMenuBar)
				frame:SetAttribute("_onstate-page", [[self:GetFrameRef("MainMenuBar"):SetAttribute("actionpage", newstate)]])
			end
		end
		return frame
	end
	local frame0 = actionbar(0,"BOTTOM",UIParent,"BOTTOM",0,0)
	actionbar(1,"BOTTOM",UIParent,"BOTTOM",-370,30)
	actionbar(2,"BOTTOM",UIParent,"BOTTOM",-370,0)
	actionbar(3,"BOTTOM",UIParent,"BOTTOM",370,30)
	actionbar(4,"BOTTOM",UIParent,"BOTTOM",0,30)
	actionbar(5,"BOTTOM",UIParent,"BOTTOM",370,0)
	local extrabuttonframe = CreateFrame("Frame",nil, UIParent)
	extrabuttonframe:SetPoint("BOTTOM",UIParent,"BOTTOM",630,0)
	extrabuttonframe:SetSize(30,30)
	local extrabutton = create(extrabuttonframe,169,0,30)
	buttons[169] = extrabutton
	local leavevehiclebuttonframe = CreateFrame("Frame",nil, UIParent)
	leavevehiclebuttonframe:SetPoint("BOTTOM",UIParent,"BOTTOM",-165,60)
	leavevehiclebuttonframe:SetSize(30,30)
	local leavevehiclebutton = create(leavevehiclebuttonframe,0,0,30,nil,true)
	local leavevehiclebuttontexture = leavevehiclebutton[2]
	local current = coroutine.running()
	local function resume(...)
		QUI.resume(current,...)
	end
	do
		local tbls 
		if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
			tbls = {{"ACTIONBAR_UPDATE_STATE","ACTIONBAR_UPDATE_USABLE","COMPANION_UPDATE","PLAYER_TALENT_UPDATE","ACTIONBAR_UPDATE_USABLE","SPELL_UPDATE_CHARGES","PLAYER_REGEN_ENABLED","PLAYER_REGEN_DISABLED","PLAYER_ENTER_COMBAT","PLAYER_LEAVE_COMBAT"
--[[
			,"ACTION_RANGE_CHECK_UPDATE"
]]
		},
		{"UPDATE_BINDINGS","ACTIVE_TALENT_GROUP_CHANGED","UPDATE_SHAPESHIFT_FORMS","ACTIONBAR_PAGE_CHANGED","UPDATE_SHAPESHIFT_COOLDOWN","UPDATE_BONUS_ACTIONBAR","UPDATE_VEHICLE_ACTIONBAR","UPDATE_OVERRIDE_ACTIONBAR","UPDATE_SHAPESHIFT_FORM","UPDATE_EXTRA_ACTIONBAR","UPDATE_SHAPESHIFT_FORMS","UPDATE_SHAPESHIFT_USABLE","UNIT_ENTERED_VEHICLE",
		"UNIT_ENTERING_VEHICLE","UNIT_EXITED_VEHICLE","VEHICLE_UPDATE","PLAYER_EQUIPMENT_CHANGED",

		"ACTIONBAR_SHOWGRID","ACTIONBAR_HIDEGRID","ACTIONBAR_SLOT_CHANGED","UPDATE_BINDINGS","LEARNED_SPELL_IN_TAB","SPELL_UPDATE_ICON","SPELL_UPDATE_CHARGES",
		"UNIT_SPELLCAST_INTERRUPTED","UNIT_SPELLCAST_SUCCEEDED","UNIT_SPELLCAST_START","UNIT_SPELLCAST_STOP",
		"UNIT_SPELLCAST_CHANNEL_START","UNIT_SPELLCAST_CHANNEL_STOP","UNIT_SPELLCAST_SENT",
		"UPDATE_SHAPESHIFT_FORM","UPDATE_SHAPESHIFT_FORMS","UPDATE_SHAPESHIFT_USABLE","UPDATE_BONUS_ACTIONBAR","UNIT_DISPLAYPOWER","UPDATE_POSSESS_BAR","UNIT_INVENTORY_CHANGED","UNIT_MODEL_CHANGED"
		},
		{"SPELL_ACTIVATION_OVERLAY_GLOW_SHOW","SPELL_ACTIVATION_OVERLAY_GLOW_HIDE"},{"LOADING_SCREEN_DISABLED","UPDATE_MOUSEOVER_UNIT"},{"PLAYER_TARGET_CHANGED","PLAYER_FOCUS_CHANGED"}}
		else
			tbls = {{"ACTIONBAR_UPDATE_STATE","ACTIONBAR_UPDATE_COOLDOWN","ACTIONBAR_UPDATE_USABLE","PLAYER_REGEN_ENABLED","PLAYER_REGEN_DISABLED","PLAYER_ENTER_COMBAT","PLAYER_LEAVE_COMBAT"},{"UPDATE_BINDINGS","UPDATE_BONUS_ACTIONBAR","UPDATE_SHAPESHIFT_FORM","UPDATE_SHAPESHIFT_FORMS","UPDATE_SHAPESHIFT_USABLE"},
		{},{"LOADING_SCREEN_DISABLED","UPDATE_MOUSEOVER_UNIT"}}
		end
		for j = 1, #tbls do
			local tbl = tbls[j]
			for i = 1, #tbl do
				ActionBar:RegisterEvent(tbl[i],resume,j)
			end
		end
	end
	
	local function resume4()
		coroutine.resume(current,4)
	end
	local ticker
	local function updaterange(i,button,current_page)
		if i < 13 then
			i = (current_page-1)*12+i
		end
		local inrange = IsActionInRange(i)
		local r,g,b,a
		if inrange then
			r,g,b,a = 0,1,0,1
		elseif inrange == false then
			r,g,b,a = 1,0,0,1
		else
			r,g,b,a = 1,1,1,1
		end
		button[4]:SetTextColor(r,g,b,a)
		button[5]:SetTextColor(r,g,b,a)
	end

	local cds = {}
	local tag,arg1,arg2,arg3,arg4 = 2, nil, nil, nil, nil
	local spell_activation_pool = CreateFramePool("Frame",UIParent,"ActionBarButtonSpellActivationAlert")
	while true do
		repeat
		local gtime = GetTime()
		local gcds,gcdt = GetSpellCooldown(61304)
		if 0~= gcdt then
			gcd = gcdt + 0.01
		end
		if 3 < tag then
			local current_page = get_action_bar_page()
			for i=1,#cds do
				local e = cds[i]
				update(e,buttons[e],gtime,current_page)
			end
			for i=1,#buttons do
				updaterange(i,buttons[i],current_page)
			end
			updaterange(169,extrabutton,current_page)
			break
		elseif tag == 3 then
			local current_page = get_action_bar_page()
			for i=1,#buttons do
				local j = i
				if i < 13 then
					j = (current_page-1)*12+j
				end
				local actionType, id, subType = GetActionInfo(j);
				local isthisspell = false
				if actionType == "spell" and id == arg2 then
					isthisspell = true
				elseif actionType == "macro" then
					local spellId = GetMacroSpell(id)
					if spellId and spellId == arg2 then
						isthisspell = true
					end
				elseif actionType == "flyout" and FlyoutHasSpell(id, arg2) then
					isthisspell = true
				end
				if isthisspell then
					local button = buttons[i]
					if button then
						local overlay = button.overlay
						if arg1 == "SPELL_ACTIVATION_OVERLAY_GLOW_SHOW" then
							if overlay == nil then
								overlay = spell_activation_pool:Acquire()
								button.cooldown = button[3]
								button.overlay = overlay
								overlay:SetParent(button);
								overlay:ClearAllPoints();
								local frameWidth, frameHeight = button:GetSize();
								overlay:SetSize(frameWidth * 1.4, frameHeight * 1.4);
								overlay:SetPoint("TOPLEFT", button, "TOPLEFT", -frameWidth * 0.2, frameHeight * 0.2);
								overlay:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", frameWidth * 0.2, -frameHeight * 0.2);
							end
							local ProcStartAnim = overlay.ProcStartAnim
							if ProcStartAnim then
								if ProcStartAnim:IsPlaying() then
									ProcStartAnim:Stop();
								end
								ProcStartAnim:Play();
							elseif overlay.animOut then
								if overlay.animOut:IsPlaying() then
									overlay.animOut:Stop();
								end
								overlay.animIn:Play();
							end
							overlay:Show()
						elseif overlay then
							spell_activation_pool:Release(overlay)
							button.cooldown = nil
							button.overlay = nil
						end
					end
				end
			end
			break
		end
		if tag == 2 then
			for i=1,12 do
				buttons[i][5]:SetText(getbindingkeyandfiltering("ACTIONBUTTON"..i))
				buttons[i+24][5]:SetText(getbindingkeyandfiltering("MULTIACTIONBAR3BUTTON"..i))
				buttons[i+36][5]:SetText(getbindingkeyandfiltering("MULTIACTIONBAR4BUTTON"..i))
				buttons[i+48][5]:SetText(getbindingkeyandfiltering("MULTIACTIONBAR2BUTTON"..i))
				buttons[i+60][5]:SetText(getbindingkeyandfiltering("MULTIACTIONBAR1BUTTON"..i))
			end
			if UnitOnTaxi("player") or (UnitControllingVehicle and UnitControllingVehicle("player") and CanExitVehicle()) then
				leavevehiclebuttontexture:Show()
			else
				leavevehiclebuttontexture:Hide()
			end
			tag = 1
		end
		if tag == 1 then
			wipe(cds)
			local current_page = get_action_bar_page()
			for i=1,#buttons do
				if update(i,buttons[i],gtime,current_page) then
					cds[#cds+1] = i
				end
			end
			if update(169,extrabutton,gtime,current_page) then
				cds[#cds+1] = 169
			end
		end
		until true
		if tag == 1 or tag == 5 then
			if #cds~= 0 or UnitExists("target") or UnitExists("focus") then
				if ticker == nil then
					ticker = NewTicker(0.1,resume4)
				end
			else
				if ticker then
					ticker:Cancel()
					ticker=nil
				end
			end
		end
		tag,arg1,arg2,arg3,arg4 = coroutine.yield()
	end
end

coroutine.wrap(maincofunc)()
