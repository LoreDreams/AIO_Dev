local AIO = AIO or require("AIO")
local SLD_LIB = SLD_LIB or require("SLD_LIB")
local SLD_Player = SLD_Player or require("LD_Player")
assert(not SLD_RolFrame, "SLD_RolFrame is already loaded. Possibly different versions!")

SLD_RolFrame =
{
    unpack = unpack,
}

--
-- MARCO DONDE SE TIRAN DADOS Y SE PREPARAN TEXTOS/EMOTES
--
if not AIO.AddAddon() then
--
-- CONTENEDOR PRINCIPAL
--
LD_ROLFrame = CreateFrame ( "Frame", "LD_ROLFrame", UIParent )
local LD_ROLFrameBackground = LD_ROLFrame:CreateTexture("LD_ROLFrameBackground", "BACKGROUND")
LD_ROLFrameBackground:SetTexture(0, 0, 1, 0.1)
LD_ROLFrameBackground:SetAllPoints()
LD_ROLFrame:SetSize(400, 170)
LD_ROLFrame:SetPoint("BOTTOMRIGHT", 0, 50)
LD_ROLFrame:SetMovable(true)
LD_ROLFrame:EnableMouse(true)
LD_ROLFrame.MyTitle = LD_ROLFrame:CreateTitleRegion()
LD_ROLFrame.MyTitle:SetSize(400, 100) 
LD_ROLFrame.MyTitle:SetPoint("TOPLEFT", LD_ROLFrame, "TOPLEFT", 0, 0)

--
-- Zona de comunicados
--
LD_ROLFrame.AlertZone=CreateFrame( "Frame", "LD_ROLFrameAlertZone", LD_ROLFrame )
LD_ROLFrame.AlertZone:SetPoint("TOPLEFT", 5,-5)
LD_ROLFrame.AlertZone:SetSize(200,40)
LD_ROLFrame.AlertZone:SetBackdrop({
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	edgeSize = 14,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
})
LD_ROLFrame.AlertZone.TxtAlert=LD_ROLFrame.AlertZone:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_ROLFrame.AlertZone.TxtAlert:SetTextColor(1, 0.5, 0, 1)
LD_ROLFrame.AlertZone.TxtAlert:SetPoint("TOPLEFT", 5 , -5)
LD_ROLFrame.AlertZone.TxtAlert:SetSize(190, 30)
LD_ROLFrame.AlertZone.TxtAlert:SetText("")

LD_ROLFrame.TurnZone=CreateFrame( "Frame", "LD_ROLFrameTurnZone", LD_ROLFrame )
LD_ROLFrame.TurnZone:SetPoint("TOPLEFT", 210,-5)
LD_ROLFrame.TurnZone:SetSize(180,40)
LD_ROLFrame.TurnZone:SetBackdrop({
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	edgeSize = 14,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
})
LD_ROLFrame.TurnZone.TxtAlert=LD_ROLFrame.TurnZone:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_ROLFrame.TurnZone.TxtAlert:SetTextColor(1, 0.5, 0, 1)
LD_ROLFrame.TurnZone.TxtAlert:SetPoint("TOPLEFT", 5 , -5)
LD_ROLFrame.TurnZone.TxtAlert:SetSize(170, 30)
LD_ROLFrame.TurnZone.TxtAlert:SetText("")

-- DADOS 1
LD_ROLFrame.Dice1Txt1 = LD_LabelTopColors(5,-50,LD_ROLFrame,"Dados(1) Min:",1,1,1,1)
LD_ROLFrame.Dice1Min  = LD_EditFrame ( LD_ROLFrame, 100, -50, 20, 15, 1, SLD_Player.Dice1Min, true)
LD_ROLFrame.Dice1Min:SetScript("OnLeave" ,
   function(self)
      SLD_Player.Dice1Min = tonumber(self:GetText())
      SLD_Player:SetPjVar("DICE1", "DICE1MIN", self:GetText())
   end)
LD_ROLFrame.Dice1Txt2 = LD_LabelTopColors(125,-50,LD_ROLFrame,"Max:",1,1,1,1)
LD_ROLFrame.Dice1Max = LD_EditFrame (LD_ROLFrame, 160, -50, 30, 15, 2, SLD_Player.Dice1Max, true)
LD_ROLFrame.Dice1Max:SetScript("OnLeave" ,
   function(self)
      SLD_Player.Dice1Max = tonumber(self:GetText())
      SLD_Player:SetPjVar("DICE1", "DICE1MAX", self:GetText())
   end)
LD_ROLFrame.Dice1 = LD_ButtonFrameTop ( 195, -50, LD_ROLFrame, "Interface\\ICONS\\inv_misc_dice_02" )
LD_ROLFrame.Dice1:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff LANZAR (I)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Dice1:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Dice1:SetScript("OnClick", 
   function(self) 
      RandomRoll(tonumber(LD_ROLFrame.Dice1Min:GetText()), tonumber(LD_ROLFrame.Dice1Max:GetText()))
   end)
 
-- DADOS 2
LD_ROLFrame.Dice2Txt1 = LD_LabelTopColors(5,-75,LD_ROLFrame,"Dados(2) Min:",1,1,1,1)
LD_ROLFrame.Dice2Min  = LD_EditFrame (LD_ROLFrame, 100, -75, 20, 15, 3, SLD_Player.Dice2Min, true)
LD_ROLFrame.Dice2Min:SetScript("OnLeave" ,
   function(self)
      SLD_Player.Dice2Min = tonumber(self:GetText())
      SLD_Player:SetPjVar("DICE2", "DICE2MIN", self:GetText())
   end)
LD_ROLFrame.Dice2Txt2 = LD_LabelTopColors(125,-75,LD_ROLFrame,"Max:",1,1,1,1)
LD_ROLFrame.Dice2Max  = LD_EditFrame (LD_ROLFrame, 160, -75, 30, 15, 4, SLD_Player.Dice2Max, true)
LD_ROLFrame.Dice2Max:SetScript("OnLeave" ,
   function(self)
      SLD_Player.Dice2Max = tonumber(self:GetText())
      SLD_Player:SetPjVar("DICE2", "DICE2MAX", self:GetText())
   end)
LD_ROLFrame.Dice2 = LD_ButtonFrameTop ( 195, -75, LD_ROLFrame, "Interface\\ICONS\\inv_misc_dice_02" )
LD_ROLFrame.Dice2:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ff00 LANZAR (II)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Dice2:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Dice2:SetScript("OnClick", 
   function(self) 
      RandomRoll(tonumber(LD_ROLFrame.Dice2Min:GetText()), tonumber(LD_ROLFrame.Dice2Max:GetText()))
   end)
   
-- TEXTO1   
LD_ROLFrame.Txt1 = LD_EditFrame (LD_ROLFrame, 10, -100, 300, 17, 5, "", false)
LD_ROLFrame.Txt1:SetScript("OnLeave", 
   function(self)
      if self:GetText() == nil then
	     self:SetText(" ")
	  end	 
      SLD_Player.Say1 = self:GetText()
      SLD_Player:SetPjVar( "SAY", "SAY1" , self:GetText())
   end)
LD_ROLFrame.Say1 = LD_ButtonFrame ( 315, 53, LD_ROLFrame, "Interface\\ICONS\\spell_holy_silence" )
LD_ROLFrame.Say1:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff DECIR (I)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Say1:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Say1:SetScript("OnClick", 
   function(self) 
      SendChatMessage(LD_ROLFrame.Txt1:GetText(), "SAY")
   end)
LD_ROLFrame.Emo1 = LD_ButtonFrame ( 340, 53, LD_ROLFrame, "Interface\\ICONS\\spell_brokenheart" )
LD_ROLFrame.Emo1:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff EMOCION (I)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Emo1:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Emo1:SetScript("OnClick", 
   function(self) 
      SendChatMessage(LD_ROLFrame.Txt1:GetText(), "EMOTE")
   end)
LD_ROLFrame.Gri1 = LD_ButtonFrame ( 365, 53, LD_ROLFrame, "Interface\\ICONS\\ability_druid_challangingroar" )
LD_ROLFrame.Gri1:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff GRITAR (I)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Gri1:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Gri1:SetScript("OnClick", 
   function(self) 
      SendChatMessage(LD_ROLFrame.Txt1:GetText(), "YELL")
   end)
-- 
--    
-- TEXTO2
--
LD_ROLFrame.Txt2 = LD_EditFrame (LD_ROLFrame, 10, -120, 300, 17, 6, "", false)
LD_ROLFrame.Txt2:SetScript("OnLeave", 
   function(self)
      if self:GetText() == nil then
	     self:SetText(" ")
	  end	 
      SLD_Player.Say2 = self:GetText()
      SLD_Player:SetPjVar( "SAY", "SAY2" , self:GetText())
   end)
LD_ROLFrame.Say2 = LD_ButtonFrame ( 315, 33, LD_ROLFrame, "Interface\\ICONS\\spell_holy_silence" )
LD_ROLFrame.Say2:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ff00 DECIR (II)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Say2:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Say2:SetScript("OnClick", 
   function(self) 
      SendChatMessage(LD_ROLFrame.Txt2:GetText(), "SAY")
   end)
LD_ROLFrame.Emo2 = LD_ButtonFrame ( 340, 33, LD_ROLFrame, "Interface\\ICONS\\spell_brokenheart" )
LD_ROLFrame.Emo2:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ff00 EMOCION (II)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Emo2:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Emo2:SetScript("OnClick", 
   function(self) 
      SendChatMessage(LD_ROLFrame.Txt2:GetText(), "EMOTE")
   end)
LD_ROLFrame.Gri2 = LD_ButtonFrame ( 365, 33, LD_ROLFrame, "Interface\\ICONS\\ability_druid_challangingroar" )
LD_ROLFrame.Gri2:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ff00 GRITAR (II)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Gri2:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Gri2:SetScript("OnClick", 
   function(self) 
      SendChatMessage(LD_ROLFrame.Txt2:GetText(), "YELL")
   end)
   
-- TEXTO3
LD_ROLFrame.Txt3 = LD_EditFrame (LD_ROLFrame, 10, -140, 300, 17, 7, "", false)
LD_ROLFrame.Txt3:SetScript("OnLeave", 
   function(self)
      SLD_Player.Say3 = self:GetText()
      SLD_Player:SetPjVar( "SAY", "SAY3" , self:GetText())
   end)
LD_ROLFrame.Say3 = LD_ButtonFrame ( 315, 13, LD_ROLFrame, "Interface\\ICONS\\spell_holy_silence" )
LD_ROLFrame.Say3:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cffff00ff DECIR (III)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Say3:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Say3:SetScript("OnClick", 
   function(self) 
      SendChatMessage(LD_ROLFrame.Txt3:GetText(), "SAY")
   end)
LD_ROLFrame.Emo3 = LD_ButtonFrame ( 340, 13, LD_ROLFrame, "Interface\\ICONS\\spell_brokenheart" )
LD_ROLFrame.Emo3:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cffff00ff EMOCION (III)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Emo3:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Emo3:SetScript("OnClick", 
   function(self) 
      SendChatMessage(LD_ROLFrame.Txt3:GetText(), "EMOTE")
   end)   
LD_ROLFrame.Gri3 = LD_ButtonFrame ( 365, 13, LD_ROLFrame, "Interface\\ICONS\\ability_druid_challangingroar" )
LD_ROLFrame.Gri3:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cffff00ff GRITAR (III)");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.Gri3:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.Gri3:SetScript("OnClick", 
   function(self) 
      SendChatMessage(LD_ROLFrame.Txt3:GetText(), "YELL")
   end)
LD_ROLFrame:SetScript("OnShow",
   function(self)
      self.Dice1Min:SetText(tostring(SLD_Player.Dice1Min))
      self.Dice1Max:SetText(tostring(SLD_Player.Dice1Max))
      self.Dice2Min:SetText(tostring(SLD_Player.Dice2Min))
      self.Dice2Max:SetText(tostring(SLD_Player.Dice2Max))
      self.Txt1:SetText(SLD_Player.Say1)
      self.Txt2:SetText(SLD_Player.Say2)
      self.Txt3:SetText(SLD_Player.Say3)
   end)   


--   
-- TIRADAS DE ATRIBUTO 
--
LD_ROLFrame.TAttr=LD_ROLFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_ROLFrame.TAttr:SetTextColor(1, 1, 0, 1)
LD_ROLFrame.TAttr:SetPoint("BOTTOMLEFT", 230,110)
LD_ROLFrame.TAttr:SetText("Tiradas de atributo:")

-- PERCEPCION  
LD_ROLFrame.DicePercep = LD_ButtonFrame ( 230, 80, LD_ROLFrame, "Interface\\ICONS\\ability_cheapshot" )
LD_ROLFrame.DicePercep:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff Tirada de Percepción");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.DicePercep:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.DicePercep:SetScript("OnClick", 
   function(self) 
      LDSendMsg("DICAT#" .. UnitName("player") .. 
	                        "#Percepcion#" .. 
							AIO_LD_CONFIG["ATRIBUTO"]["PERCEP"] .. "#" ..
                            AIO_LD_CONFIG["ATRIBUTO"]["MPERCEP"])
   end)

-- DESTREZA  
LD_ROLFrame.DiceDestre = LD_ButtonFrame ( 255, 80, LD_ROLFrame, "Interface\\ICONS\\ability_hunter_zenarchery" )
LD_ROLFrame.DiceDestre:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff Tirada de Destreza");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.DiceDestre:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.DiceDestre:SetScript("OnClick", 
   function(self) 
      LDSendMsg("DICAT#" .. UnitName("player") .. 
	                        "#Destreza#" .. 
							AIO_LD_CONFIG["ATRIBUTO"]["DESTRE"] .. "#" ..
                            AIO_LD_CONFIG["ATRIBUTO"]["MDESTRE"])
   end)

-- VOLUNTAD  
LD_ROLFrame.DiceSabidu = LD_ButtonFrame ( 280, 80, LD_ROLFrame, "Interface\\ICONS\\ability_rogue_masterofsubtlety" )
LD_ROLFrame.DiceSabidu:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff Tirada de Voluntad");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.DiceSabidu:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.DiceSabidu:SetScript("OnClick", 
   function(self) 
      LDSendMsg("DICAT#" .. UnitName("player") .. 
	                        "#Voluntad#" .. 
							AIO_LD_CONFIG["ATRIBUTO"]["SABIDU"] .. "#" ..
                            AIO_LD_CONFIG["ATRIBUTO"]["MSABIDU"])
   end)

-- FUERZA  
LD_ROLFrame.DiceFuerza = LD_ButtonFrame ( 305, 80, LD_ROLFrame, "Interface\\ICONS\\ability_golemthunderclap" )
LD_ROLFrame.DiceFuerza:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff Tirada de Fuerza");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.DiceFuerza:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.DiceFuerza:SetScript("OnClick", 
   function(self) 
      LDSendMsg("DICAT#" .. UnitName("player") .. 
	                        "#Fuerza#" .. 
							AIO_LD_CONFIG["ATRIBUTO"]["FUERZA"] .. "#" ..
                            AIO_LD_CONFIG["ATRIBUTO"]["MFUERZA"])
   end)

-- AGILIDAD  
LD_ROLFrame.DiceAgilid = LD_ButtonFrame ( 330, 80, LD_ROLFrame, "Interface\\ICONS\\ability_rogue_sprint" )
LD_ROLFrame.DiceAgilid:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff Tirada de Agilidad");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.DiceAgilid:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.DiceAgilid:SetScript("OnClick", 
   function(self) 
      LDSendMsg("DICAT#" .. UnitName("player") .. 
	                        "#Agilidad#" .. 
							AIO_LD_CONFIG["ATRIBUTO"]["AGILID"] .. "#" ..
                            AIO_LD_CONFIG["ATRIBUTO"]["MAGILID"])
   end)

-- Entendimiento  
LD_ROLFrame.DiceIntele = LD_ButtonFrame ( 355,80,LD_ROLFrame, "Interface\\ICONS\\ability_druid_lunarguidance")
LD_ROLFrame.DiceIntele:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff Tirada de Entendimiento");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.DiceIntele:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.DiceIntele:SetScript("OnClick", 
   function(self) 
      LDSendMsg("DICAT#" .. UnitName("player") .. 
	                        "#Entendimiento#" .. 
							AIO_LD_CONFIG["ATRIBUTO"]["INTELE"] .. "#" ..
                            AIO_LD_CONFIG["ATRIBUTO"]["MINTELE"])
   end)

-- Constitucion  
LD_ROLFrame.DiceConsti = LD_ButtonFrame ( 380,80,LD_ROLFrame, "Interface\\ICONS\\ability_warrior_innerrage" )
LD_ROLFrame.DiceConsti:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff Tirada de Constitución");
      GameTooltip:Show();		 
   end)
LD_ROLFrame.DiceConsti:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
LD_ROLFrame.DiceConsti:SetScript("OnClick", 
   function(self) 
      LDSendMsg("DICAT#" .. UnitName("player") .. 
	                        "#Constitución#" .. 
							AIO_LD_CONFIG["ATRIBUTO"]["CONSTI"] .. "#" ..
                            AIO_LD_CONFIG["ATRIBUTO"]["MCONSTI"])
   end)


   
LD_ROLFrame:Hide()

else
   PrintInfo("LD_ROLFrame Loaded ...")
end
