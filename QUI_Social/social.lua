local QUI = LibStub("AceAddon-3.0"):GetAddon("QUI")

QUI.KillFrameNineSlice(FriendsFrame)

QUI.KillFrameLMRBorder("FriendsFrameTab1")
QUI.KillFrameLMRBorder("FriendsFrameTab2")
QUI.KillFrameLMRBorder("FriendsFrameTab3")
QUI.KillFrameLMRBorder("FriendsFrameTab4")

QUI.KillFrameLMRBorder("FriendsTabHeaderTab1")
QUI.KillFrameLMRBorder("FriendsTabHeaderTab2")
QUI.KillFrameLMRBorder("FriendsTabHeaderTab3")


local skinbutton = QUI.skin_button

skinbutton(FriendsFrameSendMessageButton)
skinbutton(FriendsFrameAddFriendButton)
skinbutton(WhoFrameWhoButton)
skinbutton(WhoFrameAddFriendButton)
skinbutton(WhoFrameGroupInviteButton)
skinbutton(RaidFrameConvertToRaidButton)
skinbutton(RaidFrameRaidInfoButton)
skinbutton(RaidFrameRaidInfoButton)
if QuickJoinFrame then
skinbutton(QuickJoinFrame.JoinQueueButton)
end
WhoFrameEditBoxInset:SetAlpha(0)

WhoFrameListInset:SetAlpha(0)
