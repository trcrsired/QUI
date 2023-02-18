local QUI = LibStub("AceAddon-3.0"):GetAddon("QUI")
QUI.KillFrameNineSlice(TradeSkillFrame)

if TradeSkillFrame.RecipeList then
QUI.KillFrameLMRBorder(TradeSkillFrame.RecipeList.LearnedTab)
QUI.KillFrameLMRBorder(TradeSkillFrame.RecipeList.UnlearnedTab)
end
