-- module(..., package.seeall)
local AIO = AIO or require("AIO")
local SLD_LIB = SLD_LIB or require("SLD_LIB")

local SLD_Player = SLD_Player or require("LD_Player")

assert(not SLD_Hability, "SLD_Hability is already loaded. Possibly different versions!")
-- SLD_Hability main table
SLD_Hability =
{
    -- SLD_Hability flavour functions
    unpack = unpack,
}


local SLD_Hability = SLD_Hability

if not AIO.AddAddon() then

function SLD_Hability:New ( msg )
   local MyHability = {}
   MyHability.Head,
   MyHability.Nom,             -- 1
   MyHability.Descrip,         -- 2
   MyHability.ID,              -- 3
   MyHability.Leveau,          -- 4
   MyHability.FunctionType,    -- 5
   MyHability.Ata_FUERZA,      -- 6
   MyHability.Def_FUERZA,      -- 7
   MyHability.Ata_DESTRE,      -- 8
   MyHability.Def_DESTRE,      -- 9
   MyHability.Ata_AGILID,      -- 10
   MyHability.Def_AGILID,      -- 11
   MyHability.Ata_INTELE,      -- 12
   MyHability.Def_INTELE,      -- 13
   MyHability.Ata_CONSTI,      -- 14
   MyHability.Def_CONSTI,      -- 15
   MyHability.Ata_SABIDU,      -- 16
   MyHability.Def_SABIDU,      -- 17
   MyHability.Ata_PERCEP,      -- 18
   MyHability.Def_PERCEP,      -- 19
   MyHability.Cos_MANA,        -- 20
   MyHability.Cos_ENER,        -- 21
   MyHability.Dif_TIPI,        -- 22
   MyHability.OnlyAta,         -- 23
   MyHability.OnlyDef,         -- 24/25
   MyHability.Icono = strsplit ( "#", tostring(msg) )
   return MyHability
end	

function SLD_Hability:ShowAllHabilities ()
   for i = 0,19
   do
      if SLD_HabilityFrame.HabID[i+1] ~= 0 then
	     SLD_HabilityFrame.Buttons[i+1]:Show()
	  end
   end
end	

function SLD_Hability:ShowAttackHabilities ()
   for i = 0,19
   do
      if SLD_HabilityFrame.HabID[i+1] ~= 0 then
	     local MyHabName = SLD_HabilityFrame.HabName[i+1]
		 local TotalMatch = SLD_Player.Habilidades[MyHabName].Ata_FUERZA +
		                    SLD_Player.Habilidades[MyHabName].Ata_DESTRE +
		                    SLD_Player.Habilidades[MyHabName].Ata_AGILID +
		                    SLD_Player.Habilidades[MyHabName].Ata_INTELE +
		                    SLD_Player.Habilidades[MyHabName].Ata_CONSTI +
		                    SLD_Player.Habilidades[MyHabName].Ata_SABIDU +
		                    SLD_Player.Habilidades[MyHabName].Ata_PERCEP 
		 LD_ServerDebug ("SLD_Hability:ShowAttackHabilities#" .. MyHabName .. "#" ..
		    tostring(SLD_Player.Habilidades[MyHabName].Ata_FUERZA) .. "#" ..
		    tostring(SLD_Player.Habilidades[MyHabName].Ata_DESTRE) .. "#" ..
		    tostring(SLD_Player.Habilidades[MyHabName].Ata_AGILID) .. "#" ..
		    tostring(SLD_Player.Habilidades[MyHabName].Ata_INTELE) .. "#" ..
		    tostring(SLD_Player.Habilidades[MyHabName].Ata_CONSTI) .. "#" ..
		    tostring(SLD_Player.Habilidades[MyHabName].Ata_SABIDU) .. "#" ..
		    tostring(SLD_Player.Habilidades[MyHabName].Ata_PERCEP) .. "#" )
		 
		 
		 if (TotalMatch == 0 )then
	        SLD_HabilityFrame.Buttons[i+1]:Hide()
			LD_ServerDebug ("SLD_Hability:ShowAttackHabilities#" .. MyHabName .. "# Hidding?")
         end
	  end
   end
end	

function SLD_Hability:ShowDefenseHabilities ()
   for i = 0,19
   do
      if SLD_HabilityFrame.HabID[i+1] ~= 0 then
	     local MyHabName = SLD_HabilityFrame.HabName[i+1]
		 local TotalMatch = SLD_Player.Habilidades[MyHabName].Def_FUERZA +
		                    SLD_Player.Habilidades[MyHabName].Def_DESTRE +
		                    SLD_Player.Habilidades[MyHabName].Def_AGILID +
		                    SLD_Player.Habilidades[MyHabName].Def_INTELE +
		                    SLD_Player.Habilidades[MyHabName].Def_CONSTI +
		                    SLD_Player.Habilidades[MyHabName].Def_SABIDU +
		                    SLD_Player.Habilidades[MyHabName].Def_PERCEP 
		 
		 if (TotalMatch == 0 )then
	        SLD_HabilityFrame.Buttons[i+1]:Hide()
         end
	  end
   end
end	

SLD_Hability.FunctionTypes = { ["Basic"] = 
function (Hability)
   local MyTarget = UnitName("target")
   if MyTarget == nil then
      ErrPrint("Debes seleccionar objetivo para usar esta habilidad")
	   return
   end
   if tonumber(Hability.Cos_MANA) > SLD_Player.MANA then
     LDSendMsg ( "PRTXT#SYSTEM#|cffff0000[LD]" .. UnitName("player") .. " no dispone de suficiente maná para la habilidad seleccionada" )
	 return
   end
   if tonumber(Hability.Cos_ENER) > SLD_Player.ENER then
     LDSendMsg ( "PRTXT#SYSTEM#|cffff0000[LD]" .. UnitName("player") .. " no dispone de suficiente energia para la habilidad seleccionada" )
	 return
   end
   local Result = 0
   if SLD_Player.PendingMsg == 0 then -- Es un ataque
      Result = Hability.Leveau + 
      Hability.Ata_FUERZA * ( SLD_Player.Atributos.FUERZA - SLD_Player.Estorbos.FUERZA + SLD_Player.Bonificaciones.FUERZA ) +
      Hability.Ata_DESTRE * ( SLD_Player.Atributos.DESTRE - SLD_Player.Estorbos.DESTRE + SLD_Player.Bonificaciones.DESTRE ) +
      Hability.Ata_AGILID * ( SLD_Player.Atributos.AGILID - SLD_Player.Estorbos.AGILID + SLD_Player.Bonificaciones.AGILID ) +
      Hability.Ata_INTELE * ( SLD_Player.Atributos.INTELE - SLD_Player.Estorbos.INTELE + SLD_Player.Bonificaciones.INTELE ) +
      Hability.Ata_CONSTI * ( SLD_Player.Atributos.CONSTI - SLD_Player.Estorbos.CONSTI + SLD_Player.Bonificaciones.CONSTI ) +
      Hability.Ata_SABIDU * ( SLD_Player.Atributos.SABIDU - SLD_Player.Estorbos.SABIDU + SLD_Player.Bonificaciones.SABIDU ) +
      Hability.Ata_PERCEP * ( SLD_Player.Atributos.PERCEP - SLD_Player.Estorbos.PERCEP + SLD_Player.Bonificaciones.PERCEP ) 
      SLD_Player.MANA = SLD_Player.MANA - Hability.Cos_MANA
      SLD_Player:SetPjVar ( "ATRIBUTO", "MANA", SLD_Player.MANA, true )
      SLD_Player.ENER = SLD_Player.ENER - Hability.Cos_ENER
      SLD_Player:SetPjVar ( "ATRIBUTO", "ENER", SLD_Player.ENER, true )
	  LD_ServerDebug( UnitName("player") .. "#Attack" )
   else -- es una defensa
      Result = Hability.Leveau + 
      Hability.Def_FUERZA * ( SLD_Player.Atributos.FUERZA - SLD_Player.Estorbos.FUERZA + SLD_Player.Bonificaciones.FUERZA ) +
      Hability.Def_DESTRE * ( SLD_Player.Atributos.DESTRE - SLD_Player.Estorbos.DESTRE + SLD_Player.Bonificaciones.DESTRE ) +
      Hability.Def_AGILID * ( SLD_Player.Atributos.AGILID - SLD_Player.Estorbos.AGILID + SLD_Player.Bonificaciones.AGILID ) +
      Hability.Def_INTELE * ( SLD_Player.Atributos.INTELE - SLD_Player.Estorbos.INTELE + SLD_Player.Bonificaciones.INTELE ) +
      Hability.Def_CONSTI * ( SLD_Player.Atributos.CONSTI - SLD_Player.Estorbos.CONSTI + SLD_Player.Bonificaciones.CONSTI ) +
      Hability.Def_SABIDU * ( SLD_Player.Atributos.SABIDU - SLD_Player.Estorbos.SABIDU + SLD_Player.Bonificaciones.SABIDU ) +
      Hability.Def_PERCEP * ( SLD_Player.Atributos.PERCEP - SLD_Player.Estorbos.PERCEP + SLD_Player.Bonificaciones.PERCEP ) 
      SLD_Player.MANA = SLD_Player.MANA - Hability.Cos_MANA
      SLD_Player:SetPjVar ( "ATRIBUTO", "MANA", SLD_Player.MANA, true )
      SLD_Player.ENER = SLD_Player.ENER - Hability.Cos_ENER
      SLD_Player:SetPjVar ( "ATRIBUTO", "ENER", SLD_Player.ENER, true )
	  LD_ServerDebug( UnitName("player") .. "#Deffend" )
   end        
   LD_RefreshBars()
   
   
   LDSendMsg ( "LAUNCHHAB#_Basic#"  .. "#" .. UnitName("player") .. "#" .. 
               Hability.Nom .. "#" .. 
			   tostring(Result) .. "#" ..
			   MyTarget .. "#" .. tostring(SLD_Player.InCombat) .. "#" .. 
			   tostring(SLD_Player.PendingMsg) .. "#" .. tostring(SLD_Player.LastAttack))
   SLD_Player.PendingMsg = 0
   SLD_Player.LastAttack = 0
end,
["Dificultad"] = 
function (Hability)
   local MyTarget = "diana de entrenamiento"
   if tonumber(Hability.Cos_MANA) > SLD_Player.MANA then
     LDSendMsg ( "PRTXT#SYSTEM#|cffff0000[LD]" .. UnitName("player") .. " no dispone de suficiente maná para la habilidad seleccionada" )
	 return
   end
   if tonumber(Hability.Cos_ENER) > SLD_Player.ENER then
     LDSendMsg ( "PRTXT#SYSTEM#|cffff0000[LD]" .. UnitName("player") .. " no dispone de suficiente energia para la habilidad seleccionada" )
	 return
   end
   local Result = Hability.Leveau + 
   Hability.Ata_FUERZA * ( SLD_Player.Atributos.FUERZA - SLD_Player.Estorbos.FUERZA + SLD_Player.Bonificaciones.FUERZA ) +
   Hability.Ata_DESTRE * ( SLD_Player.Atributos.DESTRE - SLD_Player.Estorbos.DESTRE + SLD_Player.Bonificaciones.DESTRE ) +
   Hability.Ata_AGILID * ( SLD_Player.Atributos.AGILID - SLD_Player.Estorbos.AGILID + SLD_Player.Bonificaciones.AGILID ) +
   Hability.Ata_INTELE * ( SLD_Player.Atributos.INTELE - SLD_Player.Estorbos.INTELE + SLD_Player.Bonificaciones.INTELE ) +
   Hability.Ata_CONSTI * ( SLD_Player.Atributos.CONSTI - SLD_Player.Estorbos.CONSTI + SLD_Player.Bonificaciones.CONSTI ) +
   Hability.Ata_SABIDU * ( SLD_Player.Atributos.SABIDU - SLD_Player.Estorbos.SABIDU + SLD_Player.Bonificaciones.SABIDU ) +
   Hability.Ata_PERCEP * ( SLD_Player.Atributos.PERCEP - SLD_Player.Estorbos.PERCEP + SLD_Player.Bonificaciones.PERCEP ) 
   SLD_Player.MANA = SLD_Player.MANA - Hability.Cos_MANA
   SLD_Player:SetPjVar ( "ATRIBUTO", "MANA", SLD_Player.MANA, true )
   SLD_Player.ENER = SLD_Player.ENER - Hability.Cos_ENER
   
   SLD_Player:SetPjVar ( "ATRIBUTO", "ENER", SLD_Player.ENER, true )
   LD_RefreshBars()
   LDSendMsg ( "LAUNCHHAB#_Dificultad#"  .. "#" .. UnitName("player") .. "#" .. 
               Hability.Nom .. "#" .. 
			   tostring(Result) .. "#" ..
			   MyTarget .. "#" .. tostring(SLD_Player.InCombat) .. "#" .. tostring(Hability.Dif_TIPI))
end,
}


--
-- MARCO CONTENEDOR DE HABILIDADES
--
SLD_HabilityFrame = CreateFrame ( "Frame", "SLD_Hability", UIParent )
local SLD_HabilityFrameBackground = SLD_HabilityFrame:CreateTexture("SLD_HabilityFrameBackground", "BACKGROUND")
SLD_HabilityFrameBackground:SetTexture(0.5, 1, 0.5, 0.1)
SLD_HabilityFrameBackground:SetAllPoints()
SLD_HabilityFrame:SetBackdrop({
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	edgeSize = 14,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
})

SLD_HabilityFrame:SetSize(600, 40)
SLD_HabilityFrame:SetPoint("BOTTOMLEFT", 10, 10)
SLD_HabilityFrame.Buttons = {}
SLD_HabilityFrame.HabID = {}
SLD_HabilityFrame.HabName = {}
for i = 0,19 do
   SLD_HabilityFrame.HabID[i+1]   = 0
   SLD_HabilityFrame.HabName[i+1] = ""
end
SLD_HabilityFrame:Hide()
		
else

--
-- Funciones de servidor
--
SLD_Hability.FunctionTypes = { 
["LAUNCHHAB_Basic"] =
function ( player, msg )
   local LD_Table = mysplit ( msg , "#" )
   PrintInfo("[INFO]LAUNCHHAB_Basic:" .. msg )
   local LD_Head = LD_Table[1]
   local LD_Body = LD_Table[2]
   local LD_Pj = LD_Table[3]
   local Habilidad  = LD_Table[4]
   local Parcial    = LD_Table[5]
   local MyTarget   = LD_Table[6]
   local InCombat   = LD_Table[7]
   local IsDefense   = tonumber(LD_Table[8])
   local LastAttack  = tonumber(LD_Table[9])
   local Result = tonumber(Parcial) + LD_Dice (1, 6)
   local ResultMin = tonumber(Parcial) + 1
   local ResultMax = tonumber(Parcial) + 6
   local ScannedNPC = nil
   local IsPlayer = GetPlayerByName(MyTarget)
   local MyPain = 0
   if IsPlayer ~= nil then
      if IsDefense == 0 then
         SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00[" .. LD_Pj .. "]|cffffff00 Usa [" .. Habilidad .. "] contra " .. MyTarget)
	     LD_SendSave ( "TEATACAN#" .. Habilidad .. "#" .. tostring(Result) .. "#" .. LD_Pj, player, IsPlayer)
	  else
         SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00[" .. LD_Pj .. "]|cffffff00 Usa [" .. Habilidad .. "] en defensa de " .. MyTarget)
		 if LastAttack < Result then
		    SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00[" .. LD_Pj .. "]|cffffff00 Defiende el ataque")
         else
		    MyPain = Result - LastAttack + LD_Dice (1, 3)
		    SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00[" .. LD_Pj .. "]|cffffff00 Recibe un daño de " .. tostring(MyPain) .. " HP")
		 end
	     LD_SendDel ( "DOPAIN#" .. tostring(MyPain) .. "#" ,IsDefense, IsPlayer)
      end	  
   else
      SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00[" .. LD_Pj .. "]|cffffff00 Usa [" .. Habilidad .. "] contra " .. MyTarget)
      TDefense = LD_Dice (1, 15)
      if (Result > TDefense) then
         local MyPain = Result - TDefense + LD_Dice (1, 3)
         SendMsgGroup(player, "PRTXT#SYSTEM#|cffffaa00" .. MyTarget .. " recibe un daño de " .. tostring(MyPain) .. " HP")
   	  if InCombat == "true" then
            MySQLCommand= "INSERT INTO LD_SessionVars (LD_PJ, LD_INDEX, LD_VALUE, LD_TYPE, LD_DATEUP) VALUES('" .. LD_Pj .. "','" .. Habilidad .. "', " .. tostring(MyPain) .. ",'HABILIDAD', 0) ON DUPLICATE KEY UPDATE LD_VALUE = LD_VALUE + " .. 
   		 tostring(MyPain) .. ";"	
            CharDBExecute(MySQLCommand)		 
   		 -- SLD_Player:SetPjVar(LD_Pj, "HABILIDAD", Habilidad, MyPain, "true")
   		 AIO.Msg():Add("LDMsg","PRTXT#SYSTEM#|cffaaaaff[LD]Has ganado " .. tostring(MyPain) .. 
   		   " puntos de habilidad [" .. Habilidad .. "]"):Send(player)
   	  end
      else
         SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00" .. MyTarget .. " se defiende del ataque")
      end
   end
   PrintInfo("[INFO]LAUNCHHAB_Basic:" .. LD_Pj .. "#Min:" .. tostring(ResultMin) .. "#Max" .. 
      tostring(ResultMax) .. "#Res:" .. tostring(Result))
end,
["LAUNCHHAB_Dificultad"] =
function ( player, msg )
   local LD_Table = mysplit ( msg , "#" )
   local LD_Head = LD_Table[1]
   local LD_Body = LD_Table[2]
   local LD_Pj = LD_Table[3]
   local Habilidad  = LD_Table[4]
   local Parcial    = LD_Table[5]
   local MyTarget   = LD_Table[6]
   local InCombat   = LD_Table[7]
   local Dificultad = LD_Table[8]
   local MyDados = LD_Dice (1, 6)
   local ResultMin = tonumber(Parcial) + 1
   local ResultMax = tonumber(Parcial) + 6
   local Result = tonumber(Parcial) + MyDados
   local ScannedNPC = nil
   SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00[" .. LD_Pj .. "]|cffffff00 Usa [" .. Habilidad .. "] contra " .. MyTarget)
   TDefense = tonumber(Dificultad)
   if (Result > TDefense) then
      local MyPain = Result - TDefense + LD_Dice (1, 3)
	  
      SendMsgGroup(player, "PRTXT#SYSTEM#|cffffaa00 " .. LD_Pj .. " obtiene una puntuacion de " .. tostring(MyPain))
	  if InCombat == "true" then
         MySQLCommand= "INSERT INTO LD_SessionVars (LD_PJ, LD_INDEX, LD_VALUE, LD_TYPE, LD_DATEUP) VALUES('" .. LD_Pj .. "','" .. Habilidad .. "', " .. tostring(MyPain) .. ",'HABILIDAD', 0) ON DUPLICATE KEY UPDATE LD_VALUE = LD_VALUE + " .. 
		 tostring(MyPain) .. ";"	
         CharDBExecute(MySQLCommand)		 
		 -- SLD_Player:SetPjVar(LD_Pj, "HABILIDAD", Habilidad, MyPain, "true")
		 AIO.Msg():Add("LDMsg","PRTXT#SYSTEM#|cffaaaaff[LD]Has ganado " .. tostring(MyPain) .. 
		   " puntos de habilidad [" .. Habilidad .. "]"):Send(player)
	  end
   else
      SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00" .. LD_Pj .. " no da en el blanco")
   end
   PrintInfo("[INFO]LAUNCHHAB_Dificultad:" .. LD_Pj .. "#Min:" .. tostring(ResultMin) .. "#Max" .. 
      tostring(ResultMax) .. "#Res:" .. tostring(Result))
end,
}
   function LD_GetHabilities (player)
      local MySQLCommand = "SELECT ID, Nivel FROM LD_HabPJ where LD_PJ = '" .. player:GetName() .. "';"
	  local ListaHabilidades = {}
	  local ListaNiveles = {}
	  local MyIndex = 1
	  local MyRes = CharDBQuery(MySQLCommand)
      if ( MyRes ~= nil ) then
         local NumRows = MyRes:GetRowCount()
         for i = 1,NumRows do
            ListaHabilidades[MyIndex] = MyRes:GetString( 0 )
			ListaNiveles[MyIndex] = MyRes:GetString( 1 )
			MyIndex = MyIndex + 1
            MyRes:NextRow()
         end
      end
	  for i in pairs(ListaHabilidades)
	  do
         MySQLCommand = "SELECT Nom, Descrip, ID, FunctionType, Ata_FUERZA, Def_FUERZA, Ata_DESTRE, Def_DESTRE, Ata_AGILID, Def_AGILID, Ata_INTELE, Def_INTELE, Ata_CONSTI, Def_CONSTI, Ata_SABIDU, Def_SABIDU, Ata_PERCEP, Def_PERCEP, Cos_MANA, Cos_ENER, Dif_TIPI, OnlyAta, OnlyDef, Icono from LD_Habilidades where ID = " .. ListaHabilidades[i] .. ";"  
      	 MyRes = CharDBQuery(MySQLCommand)
         if ( MyRes ~= nil ) then
            local NumRows = MyRes:GetRowCount()
            for j = 1,NumRows do
			   AIO.Msg():Add("LDMsg","PJHABILITY#" ..
			      MyRes:GetString( 0 ) .. "#" ..
			      MyRes:GetString( 1 ) .. "#" ..
			      MyRes:GetString( 2 ) .. "#" ..
                  ListaNiveles[i]      .. "#" ..
			      MyRes:GetString( 3 ) .. "#" ..
			      MyRes:GetString( 4 ) .. "#" ..
			      MyRes:GetString( 5 ) .. "#" ..
			      MyRes:GetString( 6 ) .. "#" ..
			      MyRes:GetString( 7 ) .. "#" ..
			      MyRes:GetString( 8 ) .. "#" ..
			      MyRes:GetString( 9 ) .. "#" ..
			      MyRes:GetString( 10 ) .. "#" ..
			      MyRes:GetString( 11 ) .. "#" ..
			      MyRes:GetString( 12 ) .. "#" ..
			      MyRes:GetString( 13 ) .. "#" ..
			      MyRes:GetString( 14 ) .. "#" ..
			      MyRes:GetString( 15 ) .. "#" ..
			      MyRes:GetString( 16 ) .. "#" ..
			      MyRes:GetString( 17 ) .. "#" ..
			      MyRes:GetString( 18 ) .. "#" ..
			      MyRes:GetString( 19 ) .. "#" ..
			      MyRes:GetString( 20 ) .. "#" ..
			      MyRes:GetString( 21 ) .. "#" ..
			      MyRes:GetString( 22 ) .. "#" ..
				  MyRes:GetString( 23 ) .. "#"):Send(player)
              MyRes:NextRow()
           end
        end
      end		 
   end
   PrintInfo("SLD Hability Loaded ...")
end