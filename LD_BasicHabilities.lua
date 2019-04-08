local AIO = AIO or require("AIO")
local SLD_LIB = SLD_LIB or require("SLD_LIB")
local SLD_Player = SLD_Player or require("LD_Player")

--
-- MODULO DE HABILIDADES BASICAS DEL JUGADOR
-- Correr
-- Saltar
-- Lanzar Objetos
-- Nadar
-- Sigilo
-- Pelea sin armas


assert(not SLD_BasicHabilities, "SLD_BasicHabilities is already loaded. Possibly different versions!")
-- SLD_BasicHabilities main table
SLD_BasicHabilities =
{
    -- SLD_BasicHabilities flavour functions
    unpack = unpack,
}


local SLD_BasicHabilities = SLD_BasicHabilities

if not AIO.AddAddon() then
   --
   -- Frame de Habilidades Básicas
   --
   LD_BasicHabilitiesFrame = CreateFrame ( "Frame", "LD_BasicHabilitiesFrame", UIParent )
   local LD_BasicHabilitiesFrameBackground = LD_BasicHabilitiesFrame:CreateTexture("LD_LD_BasicHabilitiesFB", "BACKGROUND")
   LD_BasicHabilitiesFrameBackground:SetTexture(1, 1, 0.5, 0.1)
   LD_BasicHabilitiesFrameBackground:SetAllPoints()
   LD_BasicHabilitiesFrame:SetBackdrop({
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	edgeSize = 14,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
   })
   LD_BasicHabilitiesFrame:SetSize(300, 50)
   LD_BasicHabilitiesFrame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -400, 0)
   LD_BasicHabilitiesFrame.Info = LD_LabelTopColors (10,-5,LD_BasicHabilitiesFrame,"Habilidades básicas",1,1,0,1)   
   LD_BasicHabilitiesFrame:Hide()
   --
   -- Correr
   --
   LD_BasicHabilitiesFrame.Correr = LD_ButtonFrame ( 10,5, LD_BasicHabilitiesFrame, "Interface\\ICONS\\spell_fire_burningspeed" )
   LD_BasicHabilitiesFrame.Correr:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff Correr (Rango " .. tostring(LD_BasicHabilitiesFrame.Correr.Level) .. ")");
      GameTooltip:Show();		 
   end)
   LD_BasicHabilitiesFrame.Correr:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
   LD_BasicHabilitiesFrame.Correr:SetScript("OnClick", 
   function(self) 
      LDSendMsg ( "HABIL#LCORRER#" .. GetUnitName("player") .. "#" .. 
         tostring(SLD_Player.Atributos.FUERZA - SLD_Player.Estorbos.FUERZA + SLD_Player.Bonificaciones.FUERZA) .. "#" .. 
         tostring(SLD_Player.Atributos.DESTRE - SLD_Player.Estorbos.DESTRE + SLD_Player.Bonificaciones.DESTRE) .. "#" ..
         tostring(SLD_Player.Atributos.AGILID - SLD_Player.Estorbos.AGILID + SLD_Player.Bonificaciones.AGILID) .. "#" ..
         tostring(LD_BasicHabilitiesFrame.Correr.Level) .. "#" .. 
         tostring(LD_BasicHabilitiesFrame.Correr.Diff) .. "#" ..
         tostring(SLD_Player.ENER))
   end)
   LD_BasicHabilitiesFrame.Correr.Level = 1
   LD_BasicHabilitiesFrame.Correr.Diff = 12
   LD_BasicHabilitiesFrame.Correr.CosteEner = 3
   
   --
   -- Saltar
   --
   LD_BasicHabilitiesFrame.Saltar = LD_ButtonFrame (35,5,LD_BasicHabilitiesFrame, "Interface\\ICONS\\Ability_vehicle_launchplayer")
   LD_BasicHabilitiesFrame.Saltar:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff Saltar (Rango " .. tostring(LD_BasicHabilitiesFrame.Saltar.Level) .. ")");
      GameTooltip:Show();		 
   end)
   LD_BasicHabilitiesFrame.Saltar:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
   LD_BasicHabilitiesFrame.Saltar:SetScript("OnClick", 
   function(self) 
      LDSendMsg ( "HABIL#LSALTAR#" .. GetUnitName("player") .. "#" .. 
         tostring(SLD_Player.Atributos.FUERZA - SLD_Player.Estorbos.FUERZA + SLD_Player.Bonificaciones.FUERZA) .. "#" .. 
         tostring(SLD_Player.Atributos.AGILID - SLD_Player.Estorbos.AGILID + SLD_Player.Bonificaciones.AGILID) .. "#" ..
         tostring(LD_BasicHabilitiesFrame.Saltar.Level) .. "#" .. 
         tostring(LD_BasicHabilitiesFrame.Saltar.Diff) .. "#" ..
         tostring(SLD_Player.ENER) .. "#" ..
         tostring(LD_BasicHabilitiesFrame.Saltar.CosteEner))
   end)
   LD_BasicHabilitiesFrame.Saltar.Level = 1
   LD_BasicHabilitiesFrame.Saltar.Diff = 12
   LD_BasicHabilitiesFrame.Saltar.CosteEner = 3
   
   --
   -- Lanzar objetos
   --
   LD_BasicHabilitiesFrame.Lanzar = LD_ButtonFrame ( 60, 5, LD_BasicHabilitiesFrame, "Interface\\ICONS\\INV_ThrowingKnife_07" ) 
   LD_BasicHabilitiesFrame.Lanzar:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff Lanzar objetos (Rango " .. tostring(LD_BasicHabilitiesFrame.Lanzar.Level) .. ")");
      GameTooltip:Show();		 
   end)
   LD_BasicHabilitiesFrame.Lanzar:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
   LD_BasicHabilitiesFrame.Lanzar:SetScript("OnClick", 
   function(self) 
      LDSendMsg ( "HABIL#LLANZAR#" .. GetUnitName("player") .. "#" .. 
         tostring(SLD_Player.Atributos.FUERZA - SLD_Player.Estorbos.FUERZA + SLD_Player.Bonificaciones.FUERZA) .. "#" .. 
         tostring(SLD_Player.Atributos.DESTRE - SLD_Player.Estorbos.DESTRE + SLD_Player.Bonificaciones.DESTRE) .. "#" ..
         tostring(SLD_Player.Atributos.PERCEP - SLD_Player.Estorbos.PERCEP + SLD_Player.Bonificaciones.PERCEP) .. "#" ..
         tostring(LD_BasicHabilitiesFrame.Lanzar.Level) .. "#" .. 
         tostring(LD_BasicHabilitiesFrame.Lanzar.Diff) .. "#" ..
         tostring(SLD_Player.ENER) .. "#" ..
         tostring(LD_BasicHabilitiesFrame.Lanzar.CosteEner))
   end)
   LD_BasicHabilitiesFrame.Lanzar.Level = 1
   LD_BasicHabilitiesFrame.Lanzar.Diff = 12
   LD_BasicHabilitiesFrame.Lanzar.CosteEner = 2


   --
   -- Nadar
   --
   LD_BasicHabilitiesFrame.Nadar = LD_ButtonFrame ( 85, 5, LD_BasicHabilitiesFrame, "Interface\\ICONS\\Ability_Druid_AquaticForm" )
   LD_BasicHabilitiesFrame.Nadar:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff Nadar (Rango " .. tostring(LD_BasicHabilitiesFrame.Nadar.Level) .. ")");
      GameTooltip:Show();		 
   end)
   LD_BasicHabilitiesFrame.Nadar:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
   LD_BasicHabilitiesFrame.Nadar:SetScript("OnClick", 
   function(self) 
      LDSendMsg ( "HABIL#LNADAR#" .. GetUnitName("player") .. "#" .. 
         tostring(SLD_Player.Atributos.FUERZA - SLD_Player.Estorbos.FUERZA + SLD_Player.Bonificaciones.FUERZA) .. "#" .. 
         tostring(SLD_Player.Atributos.DESTRE - SLD_Player.Estorbos.DESTRE + SLD_Player.Bonificaciones.DESTRE) .. "#" ..
         tostring(SLD_Player.Atributos.AGILID - SLD_Player.Estorbos.AGILID + SLD_Player.Bonificaciones.AGILID) .. "#" ..
         tostring(LD_BasicHabilitiesFrame.Nadar.Level) .. "#" .. 
         tostring(LD_BasicHabilitiesFrame.Nadar.Diff) .. "#" ..
         tostring(SLD_Player.VIDA) .. "#" ..
         tostring(SLD_Player.ENER) .. "#" ..
         tostring(LD_BasicHabilitiesFrame.Nadar.CosteEner))
   end)
   LD_BasicHabilitiesFrame.Nadar.Level = 1
   LD_BasicHabilitiesFrame.Nadar.Diff = 12
   LD_BasicHabilitiesFrame.Nadar.CosteEner = 3
   
   --
   -- Sigilo
   --
   LD_BasicHabilitiesFrame.Sigilo = LD_ButtonFrame ( 110, 5, LD_BasicHabilitiesFrame, "Interface\\ICONS\\ability_ambush" )
   LD_BasicHabilitiesFrame.Sigilo:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff Sigilo (Rango " .. tostring(LD_BasicHabilitiesFrame.Sigilo.Level) .. ")");
      GameTooltip:Show();		 
   end)
   LD_BasicHabilitiesFrame.Sigilo:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
   LD_BasicHabilitiesFrame.Sigilo:SetScript("OnClick", 
   function(self) 
      LDSendMsg ( "HABIL#LSIGILO#" .. GetUnitName("player") .. "#" .. 
         tostring(SLD_Player.Atributos.DESTRE - SLD_Player.Estorbos.DESTRE + SLD_Player.Bonificaciones.DESTRE) .. "#" .. 
         tostring(SLD_Player.Atributos.AGILID - SLD_Player.Estorbos.AGILID + SLD_Player.Bonificaciones.AGILID) .. "#" ..
         tostring(SLD_Player.Atributos.PERCEP - SLD_Player.Estorbos.PERCEP + SLD_Player.Bonificaciones.PERCEP) .. "#" ..
         tostring(LD_BasicHabilitiesFrame.Sigilo.Level) .. "#" .. 
         tostring(SLD_Player.ENER) .. "#" ..
         tostring(LD_BasicHabilitiesFrame.Sigilo.CosteEner))
   end)
   LD_BasicHabilitiesFrame.Sigilo.Level = 1
   LD_BasicHabilitiesFrame.Sigilo.CosteEner = 2

   --
   -- Lucha sin armas
   --
   LD_BasicHabilitiesFrame.BareFigth = LD_ButtonFrame ( 135, 5, LD_BasicHabilitiesFrame, "Interface\\ICONS\\Ability_Paladin_BlessedHands" )
   LD_BasicHabilitiesFrame.BareFigth:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff Lucha sin armas");
      GameTooltip:Show();		 
   end)
   LD_BasicHabilitiesFrame.BareFigth:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
--   LD_MainFrame.Button1:SetScript("OnClick", 
--      function(self) 
--      if LD_ATRFrame:IsVisible() then
--         LD_ATRFrame:Hide()
--      else
--         LD_ATRFrame:Show()
--      end
--   end)

   --
   -- Advertir/notar
   --
   LD_BasicHabilitiesFrame.Advertir = LD_ButtonFrame ( 160, 5, LD_BasicHabilitiesFrame, "Interface\\ICONS\\ability_hunter_eagleeye" )
   LD_BasicHabilitiesFrame.Advertir:SetScript("OnEnter", 
   function(self) 
      self:SetAlpha(1) 
      GameTooltip:SetOwner(self, "ANCHOR_LEFT");
      GameTooltip:AddLine("|cff00ffff Advertir/notar (Rango " .. tostring(LD_BasicHabilitiesFrame.Advertir.Level) .. ")");
      GameTooltip:Show();		 
   end)
   LD_BasicHabilitiesFrame.Advertir:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide();
   end)
  LD_BasicHabilitiesFrame.Advertir:SetScript("OnClick", 
   function(self) 
      LDSendMsg ( "HABIL#LADVERTIR#" .. GetUnitName("player") .. "#" .. 
         tostring(SLD_Player.Atributos.PERCEP - SLD_Player.Estorbos.PERCEP + SLD_Player.Bonificaciones.PERCEP) .. "#" ..
         tostring(SLD_Player.Atributos.INTELE - SLD_Player.Estorbos.INTELE + SLD_Player.Bonificaciones.INTELE) .. "#" .. 
         tostring(LD_BasicHabilitiesFrame.Advertir.Level))
   end)
   LD_BasicHabilitiesFrame.Advertir.Level = 1

   function ProcessHabMsg(player, msg)  -- Proceso de mensaje de habilidad (Cliente)
      local LD_Table = { strsplit ( "#", tostring(msg) )}
      LD_Head = LD_Table[1]
      LD_Body = LD_Table[2]
      if LD_Body == "DNADAR" then
         local Diff = tonumber (LD_Table[3])
         SysPrint ( "Se ha modificado la dificultad de Nado a " .. LD_Table[3] )
         LD_BasicHabilitiesFrame.Nadar.Diff = Diff
      elseif LD_Body == "CNADAR" then
         local CosteEner = tonumber (LD_Table[3])
         SysPrint ( "Se ha modificado el coste energético de Nado a " .. LD_Table[3] )
         LD_BasicHabilitiesFrame.Nadar.CosteEner = CosteEner
      elseif LD_Body == "DSALTAR" then
         local Diff = tonumber (LD_Table[3])
         SysPrint ( "Se ha modificado la dificultad de Saltar a " .. LD_Table[3] )
         LD_BasicHabilitiesFrame.Saltar.Diff = Diff
      elseif LD_Body == "CSALTAR" then
         local CosteEner = tonumber (LD_Table[3])
         SysPrint ( "Se ha modificado el coste energético de Saltar a " .. LD_Table[3] )
         LD_BasicHabilitiesFrame.Saltar.CosteEner = CosteEner
      elseif LD_Body == "CSIGILO" then
         local CosteEner = tonumber (LD_Table[3])
         SysPrint ( "Se ha modificado el coste energético de Sigilo a " .. LD_Table[3] )
         LD_BasicHabilitiesFrame.Sigilo.CosteEner = CosteEner
      elseif LD_Body == "DLANZAR" then
         local Diff = tonumber (LD_Table[3])
         SysPrint ( "Se ha modificado la dificultad de Lanzar objetos a " .. LD_Table[3] )
         LD_BasicHabilitiesFrame.Lanzar.Diff = Diff
      elseif LD_Body == "CLANZAR" then
         local CosteEner = tonumber (LD_Table[3])
         SysPrint ( "Se ha modificado el coste energético de Lanzar a " .. LD_Table[3] )
         LD_BasicHabilitiesFrame.Lanzar.CosteEner = CosteEner
      elseif LD_Body == "SCorrer" then
         local Level = tonumber (LD_Table[3])
         LD_BasicHabilitiesFrame.Correr.Level = Level
      elseif LD_Body == "SSaltar" then
         local Level = tonumber (LD_Table[3])
         LD_BasicHabilitiesFrame.Saltar.Level = Level
      elseif LD_Body == "SLanzar" then
         local Level = tonumber (LD_Table[3])
         LD_BasicHabilitiesFrame.Lanzar.Level = Level
      elseif LD_Body == "SNadar" then
         local Level = tonumber (LD_Table[3])
         LD_BasicHabilitiesFrame.Nadar.Level = Level
      elseif LD_Body == "SSigilo" then
         local Level = tonumber (LD_Table[3])
         LD_BasicHabilitiesFrame.Sigilo.Level = Level
      elseif LD_Body == "SBareFigth" then
         local Level = tonumber (LD_Table[3])
         LD_BasicHabilitiesFrame.BareFigth.Level = Level
      elseif LD_Body == "SAdvertir" then
         local Level = tonumber (LD_Table[3])
         LD_BasicHabilitiesFrame.Advertir.Level = Level
      end
   end

else
   --
   -- Carga de Habilidades Básicas
   --
   function LoadBasicHabLevel (player)
      local LD_Nombre = ""
      local LD_Level = 1
      local LD_Increment = 0
      local MySQLCommand= "SELECT  LD_Nombre, LD_Level, LD_Increment from LD_BasicHab where LD_PJ = '" .. player:GetName() .."';"
      local MyRes = CharDBQuery(MySQLCommand)
      local MyMsg = ""
      if ( MyRes ~= nil ) then
         local NumRows = MyRes:GetRowCount()
         for i = 1,NumRows do
            LD_Nombre     = MyRes:GetString( 0 )
            LD_Level      = MyRes:GetInt32( 1 )
            LD_Increment  = MyRes:GetInt32( 2 )
            if LD_Increment >= 1 then
               LD_Level = LD_Level + 1
               MySQLCommand = "UPDATE LD_BasicHab set LD_Level = " .. LD_Level .. ", LD_Increment = 0 WHERE LD_PJ = '" ..  
               player:GetName() .. "' AND LD_Nombre = '" .. LD_Nombre .. "';"
               CharDBExecute(MySQLCommand)
               MyMsg = "PRTXT#SYSTEM#|cff00ff00 Enhorabuena, has subido a rango " .. tostring(LD_Level) .. " [" .. LD_Nombre .. "]"
               AIO.Msg():Add("LDMsg", MyMsg):Send(player)
            end
			   AIO.Msg():Add("LDMsg","HABIL#S" .. LD_Nombre .. "#".. tostring(LD_Level) .."#".. LD_Increment .."#".. MyValue):Send(player)
            MyRes:NextRow()
         end
      end
      PrintInfo("Basic Level Habilities Loaded" )
   end
      
   function ProcessHabMsg(player, msg)  -- Proceso de mensaje de habilidad (Server)
      local LD_Table = mysplit ( msg , "#" )
      LD_Head = LD_Table[1]
      LD_Body = LD_Table[2]
      if LD_Body == "LNADAR" then
         
         local Dados = LD_Dice (1, 6)
         local Fuerza = tonumber (LD_Table[4])
         local Destre = tonumber (LD_Table[5])
         local Agilid = tonumber (LD_Table[6])
         local Level = tonumber (LD_Table[7])
         local Diff  = tonumber (LD_Table[8])
         local Vida  = tonumber (LD_Table[9])
         local Ener  = tonumber (LD_Table[10])
         local Coste  = tonumber (LD_Table[11])
         local MyStr = "|cff00ff00 Superado |cffffff00"
         if Ener < 0 then
            SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00[" .. LD_Table[3] .. "]|cffffff00 Usa [Correr]: No tiene energia suficiente" )
            return
         end

         local MyMsg = "PLAYER#MVVAR#" .. LD_Table[3] .. "#ENER#" .. LD_Table[10] .. "#-" .. LD_Table[11] .. "#Energia"
         AIO.Msg():Add("LDMsg", MyMsg):Send(player)
         Effort = Dados + (0.2 * Fuerza) + (0.4 * Agilid ) + (0.4 * Destre ) + Level
         Diff = Diff - Level
         
         Result = Effort - Diff
         if Result < 0 then
            MyStr = "|cffff0000 No superado |cffffff00"
            local MyMsg = "PLAYER#MVVAR#" .. LD_Table[3] .. "#VIDA#" .. LD_Table[9] .. "#" .. tostring(Result) .. "#HP"
            AIO.Msg():Add("LDMsg", MyMsg):Send(player)
         else
            local MySQLCommand= "INSERT INTO LD_BasicHab (LD_PJ, LD_Nombre, LD_Level, LD_Increment) VALUES('" ..
              LD_Table[3] .. "', 'Nadar'," ..
              LD_Table[7] .. ", 0.05) ON DUPLICATE KEY UPDATE LD_Increment = LD_Increment + 0.05;"
            CharDBExecute(MySQLCommand)
         end
           
         SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00[" .. LD_Table[3] .. "]|cffffff00 Usa [Nadar]: " .. 
            MyStr .. " (" .. tostring(Result) .. ")" )
      elseif LD_Body == "DNADAR" then
         SendMsgGroup(player,msg)
      elseif LD_Body == "CNADAR" then
         SendMsgGroup(player,msg)
      elseif LD_Body == "LCORRER" then
         local Dados = LD_Dice (1, 6)
         local Fuerza = tonumber (LD_Table[4])
         local Destre = tonumber (LD_Table[5])
         local Agilid = tonumber (LD_Table[6])
         local Level = tonumber (LD_Table[7])
         local Ener = tonumber (LD_Table[9])
         if Ener < 0 then
            SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00[" .. LD_Table[3] .. "]|cffffff00 Usa [Correr]: No tiene energia suficiente" )
            return
         end
         Result = Dados + (0.4 * Fuerza) + (0.1 * Destre ) + (0.5 * Agilid) + Level
         SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00[" .. LD_Table[3] .. "]|cffffff00 Usa [Correr]: (" .. tostring(Result) .. ")" )
         Dados = LD_Dice (1, 6)
         local CosteEner = Dados - Level
         if CosteEner > 0 then
            local MyMsg = "PLAYER#MVVAR#" .. LD_Table[3] .. "#ENER#" .. LD_Table[9] .. "#-" .. tostring(CosteEner) .. "#Energia"
            AIO.Msg():Add("LDMsg", MyMsg):Send(player)
         else
            local MySQLCommand= "INSERT INTO LD_BasicHab (LD_PJ, LD_Nombre, LD_Level, LD_Increment) VALUES('" ..
              LD_Table[3] .. "', 'Correr'," ..
              LD_Table[7] .. ", 0.01) ON DUPLICATE KEY UPDATE LD_Increment = LD_Increment + 0.01;"
            CharDBExecute(MySQLCommand)
         end

      elseif LD_Body == "LSALTAR" then
         
         local Dados = LD_Dice (1, 6)
         local Fuerza = tonumber (LD_Table[4])
         local Agilid = tonumber (LD_Table[5])
         local Level = tonumber (LD_Table[6])
         local Diff  = tonumber (LD_Table[7])
         local Ener  = tonumber (LD_Table[8])
         local Coste  = tonumber (LD_Table[9])
         local MyStr = "|cff00ff00 Superado |cffffff00"
         if Ener < 0 then
            SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00[" .. LD_Table[3] .. "]|cffffff00 Usa [Saltar]: No tiene energia suficiente" )
            return
         end

         local MyMsg = "PLAYER#MVVAR#" .. LD_Table[3] .. "#ENER#" .. LD_Table[8] .. "#-" .. LD_Table[9] .. "#Energia"
         AIO.Msg():Add("LDMsg", MyMsg):Send(player)
         Effort = Dados + (0.5 * Fuerza) + (0.5 * Agilid ) + Level
         Diff = Diff - Level
         
         Result = Effort - Diff
         if Result < 0 then
            MyStr = "|cffff0000 No superado |cffffff00"
         else
            local MySQLCommand= "INSERT INTO LD_BasicHab (LD_PJ, LD_Nombre, LD_Level, LD_Increment) VALUES('" ..
              LD_Table[3] .. "', 'Saltar'," ..
              LD_Table[6] .. ", 0.01) ON DUPLICATE KEY UPDATE LD_Increment = LD_Increment + 0.01;"
            CharDBExecute(MySQLCommand)
         end
           
         SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00[" .. LD_Table[3] .. "]|cffffff00 Usa [Saltar]: " .. 
            MyStr .. " (" .. tostring(Result) .. ")" )
      elseif LD_Body == "DLANZAR" then
         SendMsgGroup(player,msg)
      elseif LD_Body == "CLANZAR" then
         SendMsgGroup(player,msg)
      elseif LD_Body == "DSALTAR" then
         SendMsgGroup(player,msg)
      elseif LD_Body == "CSALTAR" then
         SendMsgGroup(player,msg)
      elseif LD_Body == "LSIGILO" then
         local Dados = LD_Dice (1, 6)
         local Destre = tonumber (LD_Table[4])
         local Agilid = tonumber (LD_Table[5])
         local Percep = tonumber (LD_Table[6])
         local Level = tonumber (LD_Table[7])
         local Ener = tonumber (LD_Table[8])
         local CostEner = tonumber (LD_Table[9])
         if Ener < 0 then
            SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00[" .. LD_Table[3] .. "]|cffffff00 Usa [Sigilo]: No tiene energia suficiente" )
            return
         end
         Result = Dados + (0.4 * Destre) + (0.1 * Agilid ) + (0.5 * Percep) + Level
         if Result > 10 then
            local MySQLCommand= "INSERT INTO LD_BasicHab (LD_PJ, LD_Nombre, LD_Level, LD_Increment) VALUES('" ..
              LD_Table[3] .. "', 'Sigilo'," ..
              LD_Table[7] .. ", 0.01) ON DUPLICATE KEY UPDATE LD_Increment = LD_Increment + 0.01;"
            CharDBExecute(MySQLCommand)         end
         SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00[" .. LD_Table[3] .. "]|cffffff00 Usa [Sigilo]: (" .. tostring(Result) .. ")" )
         local MyMsg = "PLAYER#MVVAR#" .. LD_Table[3] .. "#ENER#" .. LD_Table[8] .. "#-" .. LD_Table[9] .. "#Energia"
         AIO.Msg():Add("LDMsg", MyMsg):Send(player)
      elseif LD_Body == "CSIGILO" then
         SendMsgGroup(player,msg)
      elseif LD_Body == "LADVERTIR" then
         local Dados = LD_Dice (1, 6)
         local Percep = tonumber (LD_Table[4])
         local Intele = tonumber (LD_Table[5])
         local Level = tonumber (LD_Table[6])
         Result = Dados + (0.9 * Percep) + (0.1 * Intele ) + Level
         if Result > 12 then
            local MySQLCommand= "INSERT INTO LD_BasicHab (LD_PJ, LD_Nombre, LD_Level, LD_Increment) VALUES('" ..
              LD_Table[3] .. "', 'Advertir'," ..
              LD_Table[6] .. ", 0.01) ON DUPLICATE KEY UPDATE LD_Increment = LD_Increment + 0.01;"
            CharDBExecute(MySQLCommand)         
         end
         SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00[" .. LD_Table[3] .. "]|cffffff00 Usa [Advertir/notar]: (" .. tostring(Result) .. ")" )
      elseif LD_Body == "LLANZAR" then
         local Dados   = LD_Dice (1, 6)
         local Fuerza  = tonumber (LD_Table[4])
         local Destre  = tonumber (LD_Table[5])
         local Percep  = tonumber (LD_Table[6])
         local Level   = tonumber (LD_Table[7])
         local Diff    = tonumber (LD_Table[8])
         local Ener    = tonumber (LD_Table[9])
         local CosEner = tonumber (LD_Table[10])
         local MyStr   = "|cff00ff00 Superado |cffffff00" 
                  
         if Ener < 0 then
            SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00[" .. LD_Table[3] .. "]|cffffff00 Usa [Lanzar objetos]: No tiene energia suficiente" )
            return
         end 
         local MyMsg = "PLAYER#MVVAR#" .. LD_Table[3] .. "#ENER#" .. LD_Table[9] .. "#-" .. LD_Table[10] .. "#Energia"
         AIO.Msg():Add("LDMsg", MyMsg):Send(player)
         Result = Dados + (0.2 * Fuerza) + (0.5 * Destre ) + (0.3 * Percep ) + Level
         if Diff == 0 then
            SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00[" .. LD_Table[3] .. "]|cffffff00 Usa [Lanzar objetos]: (" .. tostring(Result) .. ")" )
         else
            if Result >= Diff then
               local MySQLCommand= "INSERT INTO LD_BasicHab (LD_PJ, LD_Nombre, LD_Level, LD_Increment) VALUES('" ..
                  LD_Table[3] .. "', 'Lanzar'," ..
                  LD_Table[7] .. ", 0.01) ON DUPLICATE KEY UPDATE LD_Increment = LD_Increment + 0.01;"
               CharDBExecute(MySQLCommand) 
            else
               MyStr = "|cffff0000 No superado |cffffff00"            
            end
            SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00[" .. LD_Table[3] .. "]|cffffff00 Usa [Lanzar objetos]: " .. 
            MyStr .. " (" .. tostring(Result-Diff) .. ")" )
         end
      else
         PrintInfo("ProcessHabMsg: UnHandled Mess:" .. msg)
      end
   end
   PrintInfo("LD_BasicHabilities Loaded ...")
end