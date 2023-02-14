local QUI = LibStub("AceAddon-3.0"):GetAddon("QUI")
QUI.skin_scrollframe(MerchantFrame)

QUI.KillFrameLMRBorder(MerchantFrameTab1)
QUI.KillFrameLMRBorder(MerchantFrameTab2)

QUI.setalphazeroframe(MerchantExtraCurrencyInset)
QUI.setalphazeroframe(MerchantMoneyInset)

QUI.setalphazeroframe(BuybackBG)
MerchantFrameBottomLeftBorder:SetAlpha(0)
MerchantFrameBottomRightBorder:SetAlpha(0)



for i=1,BUYBACK_ITEMS_PER_PAGE do
	QUI.TextureIcons(_G["MerchantItem"..i.."ItemButton"])
	QUI.setalphazeroframe(_G["MerchantItem"..i.."SlotTexture"])
	QUI.setalphazeroframe(_G["MerchantItem"..i.."NameFrame"]:SetAlpha(0))
end

QUI.TextureIcons(MerchantBuyBackItemItemButton)
MerchantBuyBackItemSlotTexture:SetAlpha(0)
MerchantBuyBackItemNameFrame:SetAlpha(0)

if MerchantFrameLootFilter then
QUI.skin_dropdown("MerchantFrameLootFilter")
QUI.skin_button(MerchantFrameLootFilter.Button)
end

