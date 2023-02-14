local AceAddon = LibStub("AceAddon-3.0")
local QUI = AceAddon:GetAddon("QUI")
local QUI_Options = AceAddon:NewAddon("QUI_Options","AceEvent-3.0")
QUI_Options.options = {
	type = "group",
	name = "QUI",
	args = {profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(QUI.db)}
}
function QUI_Options:OnInitialize()
	LibStub("AceConfig-3.0"):RegisterOptionsTable("QUI", QUI_Options.options)
	QUI.db.RegisterCallback(QUI_Options, "OnProfileChanged")
	QUI.db.RegisterCallback(QUI_Options, "OnProfileCopied", "OnProfileChanged")
	QUI.db.RegisterCallback(QUI_Options, "OnProfileReset", "OnProfileChanged")
end

function QUI_Options:QUI_ChatCommand(message,input)
	if not input or input:trim() == "" then
		LibStub("AceConfigDialog-3.0"):Open("QUI")
	else
		LibStub("AceConfigCmd-3.0"):HandleCommand("QUI", "QUI",input)
	end
end

function QUI_Options:OnProfileChanged()
	QUI_Options:SendMessage("QUI_OnProfileChanged")
end

function QUI_Options.set_func(info,val)
	local id = tonumber(info[2])
	local p = QUI.db.profile[id][info[1]]
	local meta = getmetatable(p)
	local name = info[3]
	if meta[name] == val then
		val = nil
	end
	rawset(p,name,val)
	coroutine.resume(QUI[info[1]][id],0)
end

function QUI_Options.get_func(info)
	return QUI.db.profile[tonumber(info[2])][info[1]][info[3]]
end

function QUI_Options.set_func_color(info,r,g,b,a)
	local id = tonumber(info[2])
	local p = QUI.db.profile[id][info[1]]
	local n = info[3]
	local meta = getmetatable(p)
	local function mrawset(c,val)
		local nm = n..c
		if meta[nm] == val then
			val = nil
		end
		rawset(p,nm,val)
	end
	mrawset("R",r)
	mrawset("G",g)
	mrawset("B",b)
	mrawset("A",a)
	coroutine.resume(QUI[info[1]][id],0)
end

function QUI_Options.get_func_color(info)
	local id = tonumber(info[2])
	local p = QUI.db.profile[id][info[1]]
	local n = info[3]
	return p[n.."R"],p[n.."G"],p[n.."B"],p[n.."A"]
end

function QUI_Options.GenerateB(key,name,b)
	local gm = {}
	for k,v in pairs(QUI[key]) do
		gm[tostring(k)] = 
		{
			name = GetSpellInfo(k),
			type = "group",
			args = b
		}
	end
	QUI_Options.options.args[key] = 
	{
		type = "group",
		name = name,
		args = gm
	}
end