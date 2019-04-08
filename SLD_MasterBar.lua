local AIO = AIO or require("AIO")
local SLD_LIB = SLD_LIB or require("SLD_LIB")
local SLD_Frames = SLD_Frames or require("SLD_Frames")
local SLD_Frames2 = SLD_Frames2 or require("SLD_Frames2")

assert(not SLD_MasterBar, "SLD_MasterBar is already loaded. Possibly different versions!")
-- SLD_Frames main table
SLD_MasterBar =
{
    -- SLD_Frames flavour functions
    unpack = unpack,
}



local SLD_MasterBar = SLD_MasterBar
if not AIO.AddAddon() then
   LD_MasterFrame = CreateFrame ( "Frame", "LD_MasterFrame", UIParent )
   LD_MasterFrame:SetSize(320, 350)
   LD_MasterFrame.MyTitle = LD_MasterFrame:CreateTitleRegion()
   LD_MasterFrame.MyTitle:SetSize(320, 300) 
   LD_MasterFrame.MyTitle:SetPoint("TOPLEFT", LD_MasterFrame, "TOPLEFT", 0, 0)   
   LD_MasterFrame:SetPoint("TOPRIGHT", -40, -170)
   LD_MasterFrame:SetMovable(true)
   LD_MasterFrame:EnableMouse(true)
   local LD_MasterFrameBackground = LD_MasterFrame:CreateTexture("LD_MasterFrameBackground", "BACKGROUND")
   LD_MasterFrameBackground:SetTexture(0, 1, 1, 0.1)
   LD_MasterFrameBackground:SetAllPoints()

   LD_MasterFrame.NPC1B = LD_ButtonFrame ( 5, 330, LD_MasterFrame, "Interface\\ICONS\\ability_druid_flightform" )
   LD_MasterFrame.NPC1B:SetScript("OnClick", function ()
      if UnitName("target") == nil then
	     return
      end
	  LD_MasterFrame.NPC1N:SetText(UnitName("target"))
	  LD_MasterFrame.NPC1G:SetText(UnitGUID("target"))
	  end)
   LD_MasterFrame.NPC1N = LD_LabelTopColors (30,0,LD_MasterFrame,"",0,1,0,1)
   LD_MasterFrame.NPC1G = LD_LabelTopColors (30,0,LD_MasterFrame,"",0,0,0,0)
   LD_MasterFrame.NPC1T = LD_EditFrameTrans (LD_MasterFrame, 5, -15, 300, 15, 1, "", false, 0.2)
   LD_MasterFrame.NPC1T:SetScript("OnEscapePressed", function (self)
      self:SetText("")
      self:ClearFocus()	  
      end)
   LD_MasterFrame.NPC1T:SetScript("OnEnterPressed", function (self)
      local MyUnitGUID = LD_MasterFrame.NPC1G:GetText()
      LDSendMsg("NPSAY#" .. 
	             string.sub(MyUnitGUID,3) .. 
				 "#" .. string.sub(MyUnitGUID, -6, -1) .. 
				 "#" .. string.sub(MyUnitGUID, -12, -7) .. 
				 "#" .. LD_MasterFrame.NPC1T:GetText()) 
      LD_MasterFrame.NPC1T:SetText("")				 
      end)
   
   LD_MasterFrame.NPC2B = LD_ButtonFrame ( 5, 300, LD_MasterFrame, "Interface\\ICONS\\ability_druid_flightform" )
   LD_MasterFrame.NPC2B:SetScript("OnClick", function ()
      if UnitName("target") == nil then
	     return
      end
	  LD_MasterFrame.NPC2N:SetText(UnitName("target"))
	  LD_MasterFrame.NPC2G:SetText(UnitGUID("target"))
	  end)
   LD_MasterFrame.NPC2N = LD_LabelTopColors (30,-30,LD_MasterFrame,"",0,1,0,1)
   LD_MasterFrame.NPC2G = LD_LabelTopColors (30,-30,LD_MasterFrame,"",0,0,0,0)
   LD_MasterFrame.NPC2T = LD_EditFrameTrans (LD_MasterFrame, 5, -45, 300, 15, 1, "", false, 0.2)
   LD_MasterFrame.NPC2T:SetScript("OnEscapePressed", function (self)
      self:SetText("")
      self:ClearFocus()	  
      end)
      
   LD_MasterFrame.NPC2T:SetScript("OnEnterPressed", function (self)
      local MyUnitGUID = LD_MasterFrame.NPC2G:GetText()
      LDSendMsg("NPSAY#" .. 
	             string.sub(MyUnitGUID,3) .. 
				 "#" .. string.sub(MyUnitGUID, -6, -1) .. 
				 "#" .. string.sub(MyUnitGUID, -12, -7) .. 
				 "#" .. LD_MasterFrame.NPC2T:GetText()) 
      self:SetText("")
      self:ClearFocus()	  
      end)
   
   LD_MasterFrame.NPC3B = LD_ButtonFrame ( 5, 270, LD_MasterFrame, "Interface\\ICONS\\ability_druid_flightform" )
   LD_MasterFrame.NPC3B:SetScript("OnClick", function ()
      if UnitName("target") == nil then
	     return
      end
	  LD_MasterFrame.NPC3N:SetText(UnitName("target"))
	  LD_MasterFrame.NPC3G:SetText(UnitGUID("target"))
	  end)
   LD_MasterFrame.NPC3N = LD_LabelTopColors (30,-60,LD_MasterFrame,"",0,1,0,1)
   LD_MasterFrame.NPC3G = LD_LabelTopColors (30,-60,LD_MasterFrame,"",0,0,0,0)
   LD_MasterFrame.NPC3T = LD_EditFrameTrans (LD_MasterFrame, 5, -75, 300, 15, 1, "", false, 0.2)
   LD_MasterFrame.NPC3T:SetScript("OnEscapePressed", function (self)
      self:SetText("")
      self:ClearFocus()	  
      end)
      
   LD_MasterFrame.NPC3T:SetScript("OnEnterPressed", function (self)
      local MyUnitGUID = LD_MasterFrame.NPC3G:GetText()
      LDSendMsg("NPSAY#" .. 
	             string.sub(MyUnitGUID,3) .. 
				 "#" .. string.sub(MyUnitGUID, -6, -1) .. 
				 "#" .. string.sub(MyUnitGUID, -12, -7) .. 
				 "#" .. LD_MasterFrame.NPC3T:GetText()) 
      self:SetText("")
      self:ClearFocus()	  
      end)

   LD_MasterFrame.NPC4B = LD_ButtonFrame ( 5, 240, LD_MasterFrame, "Interface\\ICONS\\ability_druid_flightform" )
   LD_MasterFrame.NPC4B:SetScript("OnClick", function ()
      if UnitName("target") == nil then
	     return
      end
	  LD_MasterFrame.NPC4N:SetText(UnitName("target"))
	  LD_MasterFrame.NPC4G:SetText(UnitGUID("target"))
	  end)
   LD_MasterFrame.NPC4N = LD_LabelTopColors (30,-90,LD_MasterFrame,"",0,1,0,1)
   LD_MasterFrame.NPC4G = LD_LabelTopColors (30,-90,LD_MasterFrame,"",0,0,0,0)
   LD_MasterFrame.NPC4T = LD_EditFrameTrans (LD_MasterFrame, 5, -105, 300, 15, 1, "", false, 0.2)
   LD_MasterFrame.NPC4T:SetScript("OnEscapePressed", function (self)
      self:SetText("")
      self:ClearFocus()	  
      end)
      
   LD_MasterFrame.NPC4T:SetScript("OnEnterPressed", function (self)
      local MyUnitGUID = LD_MasterFrame.NPC4G:GetText()
      LDSendMsg("NPSAY#" .. 
	             string.sub(MyUnitGUID,3) .. 
				 "#" .. string.sub(MyUnitGUID, -6, -1) .. 
				 "#" .. string.sub(MyUnitGUID, -12, -7) .. 
				 "#" .. LD_MasterFrame.NPC4T:GetText()) 
      self:SetText("")
      self:ClearFocus()	  
      end)
      
   LD_MasterFrame.OpenCombat = LD_ButtonFrame ( 5, 210, LD_MasterFrame, "Interface\\ICONS\\ability_warrior_charge" )
   LD_MasterFrame.OpenCombat:SetScript("OnEnter", function(self)
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff Abrir entrenamiento");
	  GameTooltip:Show()
	  end)
   LD_MasterFrame.OpenCombat:SetScript("OnLeave", function(self)
	  self:SetAlpha(0.5) 
      GameTooltip:Hide()
	  end)
   LD_MasterFrame.OpenCombat:SetScript("OnClick", function(self)
      LDSendMsg("OPCMT#OPCMT")
	  end)
	  
   LD_MasterFrame.CloseCombat = LD_ButtonFrame ( 35, 210, LD_MasterFrame, "Interface\\ICONS\\ability_seal" )
   LD_MasterFrame.CloseCombat:SetScript("OnEnter", function(self)
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff Cerrar entrenamiento");
	  GameTooltip:Show()
	  end)
   LD_MasterFrame.CloseCombat:SetScript("OnLeave", function(self)
	  self:SetAlpha(0.5) 
      GameTooltip:Hide()
	  end)
   LD_MasterFrame.CloseCombat:SetScript("OnClick", function(self)
      LDSendMsg("CLCMT#CLCMT")
	  end)
	  
   -- LD_MasterFrame.FoeList = LD_ButtonFrame ( 65, 80, LD_MasterFrame, "Interface\\ICONS\\ability_warrior_rampage" )
   -- LD_MasterFrame.FoeList:SetScript("OnEnter", function(self)
   --    self:SetAlpha(1) 
   --    GameTooltip:SetOwner(self, "ANCHOR_LEFT");
   --    GameTooltip:AddLine("|cff00ffff Lista de enemigos");
	--   GameTooltip:Show()
	--   end)
   -- LD_MasterFrame.FoeList:SetScript("OnLeave", function(self)
	--   self:SetAlpha(0.5) 
   --    GameTooltip:Hide()
	--   end)
   -- LD_MasterFrame.FoeList:SetScript("OnClick", function(self)
   --    print("Calma campeón, que todavia me quedan cosas por hacer")
	--   end)
	--   
   -- LD_MasterFrame.Iniciativa = LD_ButtonFrame ( 95, 80, LD_MasterFrame, "Interface\\ICONS\\ability_rogue_sprint" )
   -- LD_MasterFrame.Iniciativa:SetScript("OnEnter", function(self)
   --    self:SetAlpha(1) 
   --    GameTooltip:SetOwner(self, "ANCHOR_LEFT");
   --    GameTooltip:AddLine("|cff00ffff Iniciativa");
	--   GameTooltip:Show()
	--   end)
   -- LD_MasterFrame.Iniciativa:SetScript("OnLeave", function(self)
	--   self:SetAlpha(0.5) 
   --    GameTooltip:Hide()
	--   end)
   -- LD_MasterFrame.Iniciativa:SetScript("OnClick", function(self)
   --    print("Calma campeón, que todavia me quedan cosas por hacer")
	--   end)
	  
   LD_MasterFrame.PJ1B = LD_ButtonFrame ( 5, 180, LD_MasterFrame, "Interface\\ICONS\\ability_druid_dash" )
   LD_MasterFrame.PJ1B:SetScript("OnClick", function ()
      if UnitName("target") == nil then
         return
      end
      LD_MasterFrame.PJ1N:SetText(UnitName("target"))
      LD_MasterFrame.PJ1G:SetText(UnitGUID("target"))
   end)
   LD_MasterFrame.PJ1N = LD_LabelTopColors (30,-150,LD_MasterFrame,"",0,1,0,1)
   LD_MasterFrame.PJ1G = LD_LabelTopColors (30,-150,LD_MasterFrame,"",0,0,0,0)
   LD_MasterFrame.PJ1T = LD_EditFrameTrans (LD_MasterFrame, 5, -165, 300, 15, 1, "", false, 0.2)
   LD_MasterFrame.PJ1T:SetScript("OnEscapePressed", function (self)
      self:SetText("")
      self:ClearFocus()	  
   end)
   LD_MasterFrame.PJ1T:SetScript("OnEnterPressed", function (self)
      local MyUnitGUID = LD_MasterFrame.PJ1G:GetText()
      LDSendMsg("SYSTXTTOPJ#" .. 
         LD_MasterFrame.PJ1N:GetText() .. 
         "#" .. LD_MasterFrame.PJ1T:GetText()) 
      LD_MasterFrame.PJ1T:SetText("")				 
   end)

   LD_MasterFrame.DNadarL = LD_LabelTopColors (0,-190,LD_MasterFrame,"Diff Nadar:",1,1,0,1)
   LD_MasterFrame.DNadarT = LD_EditFrameTrans (LD_MasterFrame, 75, -190, 20, 15, 1, tostring(LD_BasicHabilitiesFrame.Nadar.Diff), false, 0.2)
   LD_MasterFrame.DNadarT:SetScript("OnEscapePressed", function (self)
      self:SetText(tostring(LD_BasicHabilitiesFrame.Nadar.Diff))
      self:ClearFocus()	  
   end)
   LD_MasterFrame.DNadarT:SetScript("OnEnterPressed", function (self)
      LDSendMsg("HABIL#DNADAR#" .. 
         LD_MasterFrame.DNadarT:GetText() .. 
         "#" .. LD_MasterFrame.DNadarT:GetText()) 
      self:ClearFocus()	  
   end)
   
   LD_MasterFrame.CNadarL = LD_LabelTopColors (100,-190,LD_MasterFrame,"Coste Nadar:",1,1,0,1)
   LD_MasterFrame.CNadarT = LD_EditFrameTrans (LD_MasterFrame, 185, -190, 20, 15, 1, tostring(LD_BasicHabilitiesFrame.Nadar.CosteEner), false, 0.2)
   LD_MasterFrame.CNadarT:SetScript("OnEscapePressed", function (self)
      self:SetText(tostring(LD_BasicHabilitiesFrame.Nadar.CosteEner))
      self:ClearFocus()	  
   end)
   LD_MasterFrame.CNadarT:SetScript("OnEnterPressed", function (self)
      LDSendMsg("HABIL#CNADAR#" .. 
         LD_MasterFrame.CNadarT:GetText() .. 
         "#" .. LD_MasterFrame.CNadarT:GetText()) 
      self:ClearFocus()	  
   end)
	  
   LD_MasterFrame.DSaltarL = LD_LabelTopColors (0,-205,LD_MasterFrame,"Diff Saltar:",1,1,0,1)
   LD_MasterFrame.DSaltarT = LD_EditFrameTrans (LD_MasterFrame, 75, -205, 20, 15, 1, tostring(LD_BasicHabilitiesFrame.Nadar.Diff), false, 0.2)
   LD_MasterFrame.DSaltarT:SetScript("OnEscapePressed", function (self)
      self:SetText(tostring(LD_BasicHabilitiesFrame.Saltar.Diff))
      self:ClearFocus()	  
   end)
   LD_MasterFrame.DSaltarT:SetScript("OnEnterPressed", function (self)
      LDSendMsg("HABIL#DSALTAR#" .. 
         LD_MasterFrame.DSaltarT:GetText() .. 
         "#" .. LD_MasterFrame.DSaltarT:GetText()) 
      self:ClearFocus()	  
   end)
   
   LD_MasterFrame.CSaltarL = LD_LabelTopColors (100,-205,LD_MasterFrame,"Coste Saltar:",1,1,0,1)
   LD_MasterFrame.CSaltarT = LD_EditFrameTrans (LD_MasterFrame, 185, -205, 20, 15, 1, tostring(LD_BasicHabilitiesFrame.Saltar.CosteEner), false, 0.2)
   LD_MasterFrame.CSaltarT:SetScript("OnEscapePressed", function (self)
      self:SetText(tostring(LD_BasicHabilitiesFrame.Saltar.CosteEner))
      self:ClearFocus()	  
   end)
   LD_MasterFrame.CSaltarT:SetScript("OnEnterPressed", function (self)
      LDSendMsg("HABIL#CSALTAR#" .. 
         LD_MasterFrame.CSaltarT:GetText() .. 
         "#" .. LD_MasterFrame.CSaltarT:GetText()) 
      self:ClearFocus()	  
   end)
   
   LD_MasterFrame.CSigiloL = LD_LabelTopColors (210,-205,LD_MasterFrame,"Coste Sigilo:",1,1,0,1)
   LD_MasterFrame.CSigiloT = LD_EditFrameTrans (LD_MasterFrame, 290, -205, 20, 15, 1, tostring(LD_BasicHabilitiesFrame.Sigilo.CosteEner), false, 0.2)
   LD_MasterFrame.CSigiloT:SetScript("OnEscapePressed", function (self)
      self:SetText(tostring(LD_BasicHabilitiesFrame.Sigilo.CosteEner))
      self:ClearFocus()	  
   end)
   LD_MasterFrame.CSigiloT:SetScript("OnEnterPressed", function (self)
      LDSendMsg("HABIL#CSIGILO#" .. 
         LD_MasterFrame.CSigiloT:GetText() .. 
         "#" .. LD_MasterFrame.CSigiloT:GetText()) 
      self:ClearFocus()	  
   end)
   
   LD_MasterFrame.DLanzarL = LD_LabelTopColors (0,-220,LD_MasterFrame,"Diff Lanzar:",1,1,0,1)
   LD_MasterFrame.DLanzarT = LD_EditFrameTrans (LD_MasterFrame, 75, -220, 20, 15, 1, tostring(LD_BasicHabilitiesFrame.Lanzar.Diff), false, 0.2)
   LD_MasterFrame.DLanzarT:SetScript("OnEscapePressed", function (self)
      self:SetText(tostring(LD_BasicHabilitiesFrame.Lanzar.Diff))
      self:ClearFocus()	  
   end)
   LD_MasterFrame.DLanzarT:SetScript("OnEnterPressed", function (self)
      LDSendMsg("HABIL#DLANZAR#" .. LD_MasterFrame.DLanzarT:GetText() .. "#" .. LD_MasterFrame.DLanzarT:GetText()) 
      self:ClearFocus()	  
   end)
   
   LD_MasterFrame.CLanzarL = LD_LabelTopColors (100,-220,LD_MasterFrame,"Coste Lanzar:",1,1,0,1)
   LD_MasterFrame.CLanzarT = LD_EditFrameTrans (LD_MasterFrame, 185, -220, 20, 15, 1, tostring(LD_BasicHabilitiesFrame.Lanzar.CosteEner), false, 0.2)
   LD_MasterFrame.CLanzarT:SetScript("OnEscapePressed", function (self)
      self:SetText(tostring(LD_BasicHabilitiesFrame.Lanzar.CosteEner))
      self:ClearFocus()	  
   end)
   LD_MasterFrame.CLanzarT:SetScript("OnEnterPressed", function (self)
      LDSendMsg("HABIL#CLANZAR#" .. 
         LD_MasterFrame.CLanzarT:GetText() .. 
         "#" .. LD_MasterFrame.CLanzarT:GetText()) 
      self:ClearFocus()	  
   end)
   
   LD_MasterFrame:Hide()	  
else
   PrintInfo("SLD Master Bar Loaded ...")
end