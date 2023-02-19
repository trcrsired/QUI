local QUI = LibStub("AceAddon-3.0"):GetAddon("QUI")

QUI.KillFrameNineSlice(CollectionsJournal)

for i=1, 5 do
	QUI.KillFrameLMRBorder('CollectionsJournalTab'..i)
end
