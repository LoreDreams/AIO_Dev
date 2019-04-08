local AIO = AIO or require("AIO")
local SLD_LIB = SLD_LIB or require("SLD_LIB")

assert(not SLD_Player, "SLD_Player is already loaded. Possibly different versions!")
-- SLD_Frames main table
SLD_Player =
{
    -- SLD_Player flavour functions
    unpack = unpack,
}

--
-- Clase de manejo de PJ
--

local SLD_Player = SLD_Player 
if not AIO.AddAddon() then
   --
   -- Propiedades
   --
   SLD_Player.WName = GetUnitName("player")  -- Nombre Wow del pj
   SLD_Player.Account = ""                   -- Cuenta
   SLD_Player.IsOnrol = false                -- Indica si el jugador está en modo rol
   SLD_Player.InCombat = false               -- Indica si el jugador está combatiendo o entrenando
   SLD_Player.InEvent = false                -- Indica si el jugador está siendo masterizado
   SLD_Player.PendingMsg = 0                 -- Indica si el jugador tiene algun mensaje pendiente de respuesta
   SLD_Player.LastAttack = 0                 -- Valor del resultado del último ataque
   
   SLD_Player.Atributos = {}                 -- ATRIBUTOS
   SLD_Player.Atributos.FUERZA = 0           -- Fuerza física
   SLD_Player.Atributos.CONSTI = 0           -- Constitucion, aguante natural
   SLD_Player.Atributos.DESTRE = 0           -- Destreza
   SLD_Player.Atributos.AGILID = 0           -- Agilidad
   SLD_Player.Atributos.INTELE = 0           -- Entendimiento
   SLD_Player.Atributos.SABIDU = 0           -- Voluntad
   SLD_Player.Atributos.PERCEP = 0           -- Percepción
   
   SLD_Player.Estorbos = {}                 -- ESTORBOS
   SLD_Player.Estorbos.FUERZA = 0           
   SLD_Player.Estorbos.CONSTI = 0           
   SLD_Player.Estorbos.DESTRE = 0           
   SLD_Player.Estorbos.AGILID = 0           
   SLD_Player.Estorbos.INTELE = 0           
   SLD_Player.Estorbos.SABIDU = 0           
   SLD_Player.Estorbos.PERCEP = 0           
   
   SLD_Player.Bonificaciones = {}           -- BONIFICACIONES
   SLD_Player.Bonificaciones.FUERZA = 0     
   SLD_Player.Bonificaciones.CONSTI = 0     
   SLD_Player.Bonificaciones.DESTRE = 0     
   SLD_Player.Bonificaciones.AGILID = 0     
   SLD_Player.Bonificaciones.INTELE = 0     
   SLD_Player.Bonificaciones.SABIDU = 0     
   SLD_Player.Bonificaciones.PERCEP = 0     
   
   --
   -- VARIABLES DE ROL (Marco LD_AttrFrame)
   --
   SLD_Player.Nombre = ""                    -- Nombre onrol
   SLD_Player.Apelli = ""                    -- Apellidos
   SLD_Player.App = "P"                      -- Estado de aprobacion de la ficha
   SLD_Player.Hist1 = ""                     -- Historia
   SLD_Player.Hist2 = ""                     -- Aspecto fisico
   SLD_Player.Edad = 0                       -- Edad
   
   --
   -- CUADRO DE DADOS/EMOTES (Marco LD_ROLFrame)
   --
   SLD_Player.Dice1Min = 1                   -- Valor minimo de dados guardado (1)
   SLD_Player.Dice1Max = 10                  -- Valor maximo de dados guardado (1)
   SLD_Player.Dice2Min = 1                   -- Valor minimo de dados guardado (2)
   SLD_Player.Dice2Max = 6                   -- Valor maximo de dados guardado (2)
   SLD_Player.Say1 = ""                      -- Texto guardado(1)                       
   SLD_Player.Say2 = ""                      -- Texto guardado(2)                       
   SLD_Player.Say3 = ""                      -- Texto guardado(3)                       

   --
   -- Niveles de variables vitales (LD_StatusBars)
   --
   SLD_Player.MANA = -1                       -- Nivel de Mana (energia intelectual)
   SLD_Player.ENER = -1                       -- Nivel de energia fisica
   SLD_Player.VIDA = -1                       -- Nivel de salud
   SLD_Player.TopMANA = -1                    -- Nivel máximo de Mana
   SLD_Player.TopENER = -1                    -- Nivel máximo de energia fisica
   SLD_Player.TopVIDA = -1                    -- Nivel máximo de salud
   
   
   --
   -- HABILIDADES
   --
   SLD_BlockTurn = false
   SLD_Player.Habilidades = {}
   
   --
   -- Metodos
   --
   function SLD_Player:GetAccount(Data)
      SLD_Player.Account = Data 
   end
   
   function SLD_Player:GetAttributes(Data)   -- Distribucion de atributos desde mensaje del server
      local sHEAD, sPLAYER, sFUERZA, sCONSTI, sDESTRE, sAGILID, sINTELE, sSABIDU, sPERCEP, sVIDA, sMANA, sENER = strsplit ( "#", Data )
      SLD_Player.Atributos.FUERZA = tonumber(sFUERZA)
      SLD_Player.Atributos.CONSTI = tonumber(sCONSTI)
      SLD_Player.Atributos.DESTRE = tonumber(sDESTRE)
      SLD_Player.Atributos.AGILID = tonumber(sAGILID)
      SLD_Player.Atributos.INTELE = tonumber(sINTELE)
      SLD_Player.Atributos.SABIDU = tonumber(sSABIDU)
      SLD_Player.Atributos.PERCEP = tonumber(sPERCEP)
      SLD_Player.VIDA = tonumber(sVIDA)
      SLD_Player.MANA = tonumber(sMANA)
      SLD_Player.ENER = tonumber(sENER)
	   SLD_Player.TopVIDA = (SLD_Player.Atributos.CONSTI * 1.7 ) + (SLD_Player.Atributos.SABIDU * 1.3 )
      SLD_Player.TopVIDA = SLD_Player.TopVIDA * AIO_LD_CONFIG["SYS"]["SYS"]["SYS"]["MVHP"]
	   SLD_Player.TopENER = (SLD_Player.Atributos.CONSTI * 1.4) + 
                        (SLD_Player.Atributos.AGILID * 1.2 ) +
                        (SLD_Player.Atributos.SABIDU * 1.2 ) +
                        (SLD_Player.Atributos.FUERZA * 1.2 ) 
      SLD_Player.TopENER = SLD_Player.TopENER * AIO_LD_CONFIG["SYS"]["SYS"]["SYS"]["MVEP"]
	   SLD_Player.TopMANA = (SLD_Player.Atributos.SABIDU * 1.7 ) + 
                        (SLD_Player.Atributos.INTELE * 1.3 ) 
      SLD_Player.TopMANA = SLD_Player.TopMANA * AIO_LD_CONFIG["SYS"]["SYS"]["SYS"]["MVMP"]
	  LD_ServerDebug ("SLD_Player:GetAttributes Done ...")
   end	  

   function SLD_Player:GetRolVars(Data)   -- Distribucion de variables de rol desde mensaje del server
      local sHEAD, sPLAYER, sNombre, sApelli, sApp, sHist1, sHist2, sEdad, sApp = strsplit ( "#", Data )
      SLD_Player.Nombre = sNombre
      SLD_Player.Apelli = sApelli
      SLD_Player.App = sApp
      SLD_Player.Hist1 = sHist1
      SLD_Player.Hist2 = sHist2
      SLD_Player.Edad = tonumber(sEdad)
	  SLD_Player.App = sApp
	  LD_ServerDebug ("SLD_Player:GetRolVars Done ...")
   end
   
   function SLD_Player:GetDiceVars(Data)   -- Distribucion de variables guardadas dados/emotes mensaje del server
      local sHEAD, sPLAYER, sDice1Min, sDice1Max, sDice2Min, sDice2Max, Say1, Say2, Say3 = strsplit ( "#", Data )
	  -- LD_ServerDebug ("SLD_Player:GetDiceVars [" .. Data .. "]")
      SLD_Player.Dice1Min = tonumber(sDice1Min)
      SLD_Player.Dice1Max = tonumber(sDice1Max)
      SLD_Player.Dice2Min = tonumber(sDice2Min)
      SLD_Player.Dice2Max = tonumber(sDice2Max)
      SLD_Player.Say1 = Say1
      SLD_Player.Say2 = Say2
      SLD_Player.Say3 = Say3
	  LD_ServerDebug ("SLD_Player:GetDiceVars Done ...")
   end

   function SLD_Player:SetPjVar(MyType, MyIndex, MyValue, IsNumeric) -- Guarda Variable en base de datos
      LDSendMsg("SAVEPJVAR#" .. SLD_Player.WName .. "#" .. MyType .. "#" .. MyIndex .. 
	            "#" .. MyValue .. "#" .. tostring(IsNumeric) .. "#")
   end
   function SLD_Player:ProcessMsg(player,msg) -- Proceso de mensajes de jugador (Cliente)
      local LD_Table = { strsplit ( "#", tostring(msg) )}
      LD_Head = LD_Table[1]
      LD_Body = LD_Table[2]
      if LD_Body == "MVVAR" then   -- Modificar Variable vital al personaje
         local NameVar   = LD_Table[4]
         local TotalVar  = tonumber(LD_Table[5])
         local Increment = tonumber(LD_Table[6])
         if NameVar == "VIDA" then
            SLD_Player.VIDA = TotalVar + Increment
         elseif NameVar == "MANA" then
            SLD_Player.MANA = TotalVar + Increment
         elseif NameVar == "ENER" then
            SLD_Player.ENER = TotalVar + Increment
         end
         LDSendMsg(msg)
         LD_RefreshBars()
      else
         LD_ServerDebug ("SLD_Player:ProcessMsg (Client)Unhand Mess:" .. msg)
      end
   end
   LD_ServerDebug ("SLD Player (Client) Loaded ...")

else

   function SLD_Player:SelectAttributes(PlayerName)
      local RetStr = "SETALLATTR#" .. PlayerName
      local WhereClause = ""
      local MySQLQuery = "SELECT LD_VALUE from LD_SessionVars where LD_PJ = '" .. PlayerName .."'"
      local MyAttributes = { "FUERZA", "CONSTI", "DESTRE", "AGILID", "INTELE", "SABIDU", "PERCEP", "VIDA", "MANA", "ENER" }
      local MyVal = nil
	  for MyIndex in pairs(MyAttributes)
	  do
         local WhereClause = " AND LD_TYPE='ATRIBUTO' AND LD_INDEX='" .. MyAttributes[MyIndex] .. "';"
  	     local MyRes = CharDBQuery(MySQLQuery .. WhereClause)
         if ( MyRes ~= nil ) then
            local NumRows = MyRes:GetRowCount()
            for i = 1,NumRows do
               MyVal = MyRes:GetString( 0 )
               MyRes:NextRow()
            end
		 else
		    MyVal = "-1"
         end
	     RetStr = RetStr .. "#" .. MyVal
	  end
      return RetStr	  
   end
   
   function SLD_Player:SelectRolVars(PlayerName)
      local RetStr = "SETALLROL#" .. PlayerName
      local WhereClause = ""
      local MySQLQuery = "SELECT LD_VALUE from LD_SessionVars where LD_PJ = '" .. PlayerName .."'"
      local MyRolVars = { "NOMBRE", "APELLIDO", "APP", "HIST1", "HIST2", "EDAD", "APP" }
      local MyVal = nil
	  for MyIndex in pairs(MyRolVars)
	  do
         local WhereClause = " AND LD_TYPE='ROL' AND LD_INDEX='" .. MyRolVars[MyIndex] .. "';"
  	     local MyRes = CharDBQuery(MySQLQuery .. WhereClause)
         if ( MyRes ~= nil ) then
            local NumRows = MyRes:GetRowCount()
            for i = 1,NumRows do
               MyVal = MyRes:GetString( 0 )
               MyRes:NextRow()
            end
		 else
		    MyVal = ""
         end
	     RetStr = RetStr .. "#" .. MyVal
	  end
      return RetStr	  
   end
   
   function SLD_Player:SelectDiceVars(PlayerName)
      local RetStr = "SETDICEVARS#" .. PlayerName
      local WhereClause = ""
      local MySQLQuery = "SELECT LD_VALUE from LD_SessionVars where LD_PJ = '" .. PlayerName .."'"
      local MyDiceVars = { "DICE1MIN", "DICE1MAX", "DICE2MIN", "DICE2MAX"}
	  local MySayVars = {"SAY1", "SAY2", "SAY3" }
      local MyVal = nil
	  for MyIndex in pairs(MyDiceVars)
	  do
         local WhereClause = " AND LD_TYPE LIKE 'DICE%' AND LD_INDEX='" .. MyDiceVars[MyIndex] .. "';"
  	     local MyRes = CharDBQuery(MySQLQuery .. WhereClause)
         if ( MyRes ~= nil ) then
            local NumRows = MyRes:GetRowCount()
            for i = 1,NumRows do
               MyVal = MyRes:GetString( 0 )
               MyRes:NextRow()
            end
		 else
		    MyVal = ""
         end
	     RetStr = RetStr .. "#" .. MyVal
	  end
	  for MyIndex in pairs(MySayVars)
	  do
         local WhereClause = " AND LD_TYPE='SAY' AND LD_INDEX='" .. MySayVars[MyIndex] .. "';"
  	     local MyRes = CharDBQuery(MySQLQuery .. WhereClause)
         if ( MyRes ~= nil ) then
            local NumRows = MyRes:GetRowCount()
            for i = 1,NumRows do
               MyVal = MyRes:GetString( 0 )
               MyRes:NextRow()
            end
		 else
		    MyVal = ""
         end
	     RetStr = RetStr .. "#" .. MyVal
	  end
      return RetStr	  
   end

   function SLD_Player:SetPjVar(PlayerName, MyType, MyIndex, MyValue, IsNumeric)
      if MyValue == nil then
	     MyValue = ""
	  end
	  local MyDate = LD_Now()
	  if IsNumeric == "true" then
         MySQLCommand= "INSERT INTO LD_SessionVars (LD_PJ, LD_INDEX, LD_VALUE, LD_TYPE, LD_DATEUP) VALUES('" .. PlayerName .. "','" .. MyIndex .. "', " .. MyValue .. ",'" .. MyType .. 
		 "', " .. MyDate .. ") ON DUPLICATE KEY UPDATE LD_VALUE = " .. MyValue .. ";"
	  else
         MySQLCommand= "INSERT INTO LD_SessionVars (LD_PJ, LD_INDEX, LD_VALUE, LD_TYPE, LD_DATEUP) VALUES('" .. PlayerName .. "','" .. MyIndex .. "','" .. MyValue .. "','" .. MyType .. 
		 "', " .. MyDate .. ") ON DUPLICATE KEY UPDATE LD_VALUE = '" .. MyValue .. "';"
	  end
	  -- PrintInfo(MySQLCommand)
      CharDBExecute(MySQLCommand)		 
   end
   
   function SLD_Player:ProcessMsg(player,msg) -- Proceso de mensajes de jugador (Server)
      local LD_Table = mysplit ( msg , "#" )
      LD_Head = LD_Table[1]
      LD_Body = LD_Table[2]
      if LD_Body == "MVVAR" then   -- Modificar Variable vital al personaje
         local MyPlayer = GetPlayerByName(LD_Table[3])
         local VitalVar = LD_Table[4]
         local PlayerVal = tonumber(LD_Table[5])
         local Increment = tonumber(LD_Table[6])
         local TotalVarVal = PlayerVal+Increment
         SLD_Player:SetPjVar(LD_Table[3],"ATRIBUTO",VitalVar,TotalVarVal,"true")
         if Increment > 0 then
            SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00[" .. LD_Table[3] .. "]|cffffff00 Ha ganado " .. LD_Table[6] .. " puntos de " .. LD_Table[7] )
         else
            SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00[" .. LD_Table[3] .. "]|cffffff00 Ha perdido " .. LD_Table[6] .. " puntos de " .. LD_Table[7] )
         end
      else
         PrintInfo("SLD_Player:ProcessMsg Unhand Mess:[" .. msg .. "]")
      end
   end
   
   PrintInfo("SLD Player (Server) Loaded ...")
end
