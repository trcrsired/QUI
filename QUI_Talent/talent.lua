local QUI = LibStub("AceAddon-3.0"):GetAddon("QUI")
QUI.KillFrameNineSlice(PlayerTalentFrame)

local _G = _G

QUI.KillFrameLMRBorder("PlayerTalentFrameTab1")
QUI.KillFrameLMRBorder("PlayerTalentFrameTab2")
QUI.KillFrameLMRBorder("PlayerTalentFrameTab3")

if PlayerTalentFrameSpecialization then
PlayerTalentFrameSpecialization.bg:SetAlpha(0)

QUI.KillFrameBackgroundBySearch(PlayerTalentFrameSpecialization)

PlayerTalentFrameSpecializationTLCorner:SetAlpha(0)
PlayerTalentFrameSpecializationTRCorner:SetAlpha(0)
PlayerTalentFrameSpecializationBLCorner:SetAlpha(0)
PlayerTalentFrameSpecializationBRCorner:SetAlpha(0)
end

if MAX_TALENT_TIERS then

for i=1,MAX_TALENT_TIERS do
	_G["PlayerTalentFrameTalentsTalentRow"..i.."Bg"]:SetAlpha(0)
	_G["PlayerTalentFrameTalentsTalentRow"..i.."LeftCap"]:SetAlpha(0)
	_G["PlayerTalentFrameTalentsTalentRow"..i.."RightCap"]:SetAlpha(0)
	local talentframe = PlayerTalentFrameTalents["tier"..i]
	for j=1,NUM_TALENT_COLUMNS do
		_G["PlayerTalentFrameTalentsTalentRow"..i.."Separator"..j]:SetAlpha(0)
		talentframe["talent"..j].icon:SetTexCoord(0.1,0.9,0.1,0.9)
		talentframe["talent"..j].Slot:SetAlpha(0)
	end
end

end

QUI.KillFrameBackgroundBySearch(PlayerTalentFrameTalents)
QUI.KillFrameBackgroundBySearch(PlayerTalentFrameTalentsPvpTalentFrame,"Interface\\Common\\bluemenu-vert")


QUI.setalphazeroframe(PlayerTalentFrameTalentsPvpTalentFrameTLCorner)
QUI.setalphazeroframe(PlayerTalentFrameTalentsPvpTalentFrameTRCorner)
QUI.setalphazeroframe(PlayerTalentFrameTalentsPvpTalentFrameBLCorner)
QUI.setalphazeroframe(PlayerTalentFrameTalentsPvpTalentFrameBRCorner)
