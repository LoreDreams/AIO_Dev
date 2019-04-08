local AIO = AIO or require("AIO")
local SLD_LIB = SLD_LIB or require("SLD_LIB")
local SLD_Events = SLD_Events or require("SLD_Events")
local SLD_Frames = SLD_Frames or require("SLD_Frames")
local SLD_Frames2 = SLD_Frames2 or require("SLD_Frames2")
local SLD_Macros = SLD_Macros or require("SLD_Macros")
local SLD_Data = SLD_Data or require("SLD_Data")

local SLD_Player = SLD_Player or require("LD_Player")
local SLD_AttrFrame = SLD_AttrFrame or require("LD_AttrFrame")
local SLD_RolFrame = SLD_RolFrame or require("LD_RolFrame")
local SLD_MainFrame = SLD_MainFrame or require("LD_MainFrame")
local SLD_Hability = SLD_Hability or require("LD_Hability")
local SLD_RaidFrame = SLD_RaidFrame or require("LD_RaidFrame")
local SLD_System = SLD_System or require("LD_System")
local SLD_BasicHabilities = SLD_BasicHabilities or require("LD_BasicHabilities")

local HandleLDMsg

if AIO.AddAddon() then
   
   --
   -- FUNCION PRINCIPAL DE MANEJO DE MENSAJES
   --
   function HandleLDMsg(player, msg)
      local LD_Table = mysplit ( msg , "#" )
      LD_Head = LD_Table[1]
      LD_Body = LD_Table[2]
	  
      if LD_Head == "PRTXT" then     -- IMPRIME UN TEXTO POR EL CHAT GENERAL A LOS MIEMBROS DEL GRUPO
         SendMsgGroup(player, msg)

	   elseif LD_Head == "HABIL" then  -- MENSAJE DE HABILIDAD
         ProcessHabMsg(player, msg)
      
      elseif LD_Head == "PLAYER" then -- MENSAJE DE JUGADOR
         SLD_Player:ProcessMsg(player,msg)        
	   
      elseif LD_Head == "OPCMT" then -- ABRIR COMBATE
		   SendMsgGroup(player, "OPCMT#OPCMT#")

      elseif LD_Head == "CLCMT" then -- CERRAR COMBATE
		   SendMsgGroup(player, "CLCMT#CLCMT#")
		 
      elseif LD_Head == "DICAT" then  -- DADOS DE ATRIBUTO
	      local Atributo = LD_Table[3]
		   local Suma     = LD_Table[4]
		   local Resta    = LD_Table[5]
		   local Dados    = LD_Dice (1, 6)
		   local Result   = Dados + tonumber(Suma) + tonumber(Resta)
		   SendMsgGroup(player, "PRTXT#SYSTEM#|cff00ff00[" .. LD_Body .. "]|cffffff00 Dados de " .. Atributo .. ": " .. tostring(Result))
		 
      elseif LD_Head == "PRDEB" then  -- IMPRIME UN TEXTO EN EL LOG DEL SERVER
         PrintInfo("[DEBUG]:" .. msg )
		 
      elseif LD_Head == "LDPMF" then  -- RECARGA DE MIEMBROS DE LA RAID
		   LD_CheckPjGroup(player)
		 
      elseif LD_Head == "LDDAT" then -- CARGA MASIVA DE DATOS
	      SLD_LoadData(player)

      elseif LD_Head == "HELLO" then -- PERSONAJE ENTRA AL MUNDO
	      SLD_LoadData(player)
		   LD_SavePjPlayer ( LD_Table[2], player:GetAccountName() )
		   AIO.Msg():Add("LDMsg",SLD_Player:SelectAttributes(LD_Table[2])):Send(player)
		   AIO.Msg():Add("LDMsg",SLD_Player:SelectRolVars(LD_Table[2])):Send(player)
		   AIO.Msg():Add("LDMsg",SLD_Player:SelectDiceVars(LD_Table[2])):Send(player)
		   AIO.Msg():Add("LDMsg","SETACCOUNT#" .. LD_Table[2] .. "#" .. player:GetAccountName()):Send(player)
		   LD_GetHabilities(player)
         LoadBasicHabLevel(player)
		 
		 
      elseif LD_Head == "ROLMD" then -- PERSONAJE EN MODO ROL
         AIO.Msg():Add("LDMsg", "ROLMD#A#A"):Send(player) 
         PrintInfo("[INFO]HandleLDMsg: :[" .. player:GetAccountName() .."(" .. LD_Body .. ")] - Enters rol mode")
		 
      elseif LD_Head == "PVEMD" then -- PERSONAJE EN MODO PVE
         AIO.Msg():Add("LDMsg", "PVEMD#A#A"):Send(player) 
         PrintInfo("[INFO]HandleLDMsg: :[" .. player:GetAccountName() .."(" .. LD_Body .. ")] - Exits rol mode")
		 
      elseif LD_Head == "LDSET" then -- SET VARIABLE DE SESSION DE PJ
		   local MyLD_Pj     = LD_Table[2]
		   local MyLD_Index  = LD_Table[3]
		   local MyLD_Type   = LD_Table[4]
		   local MyLD_Value  = LD_Table[5] 
		   local MyLD_UpTime = LD_Table[6] 
		   LD_SetPjVar ( MyLD_Pj, MyLD_Index, MyLD_Value, MyLD_Type, MyLD_UpTime )

      elseif LD_Head == "LDGET" then -- GET VARIABLE DE SESSION DE PJ
	      PrintInfo ("[INFO]HandleLDMsg: " .. msg)
		   local MyLD_Pj     = LD_Table[2]
		   local MyLD_Index  = LD_Table[3]
		   local MyLD_Type   = LD_Table[4]
		   local MyLD_Value  = LD_Table[5] 
		   local MyVal = LD_GetPjVar ( MyLD_Pj, MyLD_Index, MyLD_Value, MyLD_Type  )
		   if MyVal ~= nil then
			   AIO.Msg():Add("LDMsg", "LDGET#" .. MyLD_Value .. "#" .. MyVal .. "#" .. MyLD_Type):Send(player)
		   end

	   elseif LD_Head == "LDSYS" then -- GET VARIABLES DE SISTEMA
		   LD_GetSysVars(player)
		 
      elseif LD_Head == "GTALL" then -- GET CONJUNTO DE VARIABLES DE UN TIPO
		   local MyLD_Pj     = LD_Table[2]
		   local MyLD_Type   = LD_Table[3]
            LD_GetAllType ( MyLD_Pj, MyLD_Type, player )
		 
      elseif LD_Head == "GTAPJ" then -- TODAS LAS VARIABLES DE UN PJ
		   local MyLD_Pj = LD_Table[2]
		   local MyVal   = LD_GetAllPj ( MyLD_Pj , player)
		 
      elseif LD_Head == "LDGDF" then -- VARIABLE DE SESSION DE PJ CON VALOR POR DEFECTO
		   local MyLD_Pj     = LD_Table[2]
		   local MyLD_Index  = LD_Table[3]
		   local MyLD_Type   = LD_Table[4]
		   local MyLD_Value  = LD_Table[5] 
		   local MyLD_Default = LD_Table[6] 
		   local MyVal = LD_GetPjVarDef ( MyLD_Pj, MyLD_Index, MyLD_Value, MyLD_Type, MyLD_Default  )
         AIO.Msg():Add("LDMsg", "LDGET#" .. MyLD_Value .. "#" .. MyVal .. "#" .. MyLD_Type):Send(player)
		 
      elseif LD_Head == "NPSAY" then -- HACER HABLAR A UN NPC
		   local MyNPCId  = tonumber(LD_Table[4],16)
		   local MyNPCLow = tonumber(LD_Table[3],16)
		   local MyCreature = player:GetMap():GetWorldObject((GetUnitGUID( MyNPCLow, MyNPCId )))
	      MyCreature:SendUnitSay(LD_Table[5], 0)
		 
      elseif LD_Head == "NPEMT" then -- EMOTE DE UN NPC
		   local MyNPCId  = tonumber(LD_Table[4],16)
		   local MyNPCLow = tonumber(LD_Table[3],16)
		   local MyCreature = player:GetMap():GetWorldObject((GetUnitGUID( MyNPCLow, MyNPCId )))
	      MyCreature:SendUnitEmote(LD_Table[5], 0)
		 
	   elseif LD_Head == "SEENK" then -- VEO DESNUDO
		   if (player:HasAura(54844)) then
		      player:RemoveAura(54844)
		   else	
		      player:AddAura(54844,player)
		   end
		 
	   elseif LD_Head == "LDEVT" then -- CLICK SOBRE NPC
		   AIO.Msg():Add("LDMsg", msg ):Send(player)
		 
	   elseif LD_Head == "HISPJ" then -- HISTORIA DE PJS
		   PrintInfo("[INFO]HandleLDMsg: :[HISPJ]" .. msg )
	      if player:IsGM() == false then
	         AIO.Msg():Add("LDMsg", "PRTXT#System#\nFunción solo para MJ\n" ):Send(player)
			   PrintInfo("[INFO]HandleLDMsg: :[HISPJ] Player is not GM" )
		      return
         end			
	      local MyLD_Pj = LD_Table[2]
	      local PjHistory = LD_GetHistory(MyLD_Pj)
		   if PjHistory ~= nil then
		      for J,K in pairs(PjHistory) do
               AIO.Msg():Add("LDMsg", "HISPJ#" .. MyLD_Pj.. "#" .. J .. "#" .. K):Send(player)
               PrintInfo("[INFO]HandleLDMsg: HISPJ#" .. MyLD_Pj.. "#" .. J .. "#" .. K)
			   end   
		   end		 
         AIO.Msg():Add("LDMsg", "HISPJ#" .. MyLD_Pj.. "#SHOW#SHOW"):Send(player)
		 
	   elseif LD_Head == "HIDPJ" then -- CAST SPELL
	      local MySpellID = LD_Table[2]
		   player:CastSpell(nil,tonumber(MySpellID),true)
		 
	   elseif LD_Head == "APPHI" then -- APROBAR HISTORIA
		   PrintInfo("[INFO]HandleLDMsg: :[APPHI]" .. msg )
	      if player:IsGM() == false then
	         AIO.Msg():Add("LDMsg", "PRTXT#System#\nFunción solo para MJ\n" ):Send(player)
			   PrintInfo("[INFO]HandleLDMsg: :[APPHI] Player is not GM" )
		      return
         end			
	      local MyLD_Pj = LD_Table[2]
	      local MyPlayerName = LD_GetPjPlayer(MyLD_Pj)
		   if MyPlayerName == nil then
		      AIO.Msg():Add("LDMsg", "PRTXT#S#" .. MyLD_Pj .. ": No registrado en Base de Datos\n" ):Send(player)
			   return
		   end
         LD_SetPjVar ( MyLD_Pj, "APP", "A", "ROL", 0 )
		   local MyPlayer = GetPlayerByName( MyLD_Pj )
		   if MyPlayer ~= nil then
            AIO.Msg():Add("LDMsg", "LDGET#APP#A#ROL"):Send(MyPlayer)
            AIO.Msg():Add("LDMsg", "PRTXT#SYS#Tu ficha ha sido aprobada"):Send(MyPlayer)
		   end
         AIO.Msg():Add("LDMsg", "PRTXT#SYS#Ficha de " .. MyLD_Pj .. " aprobada"):Send(player)
		 
      --
      -- NEW MSG HANDLING
      --	  
      elseif LD_Head == "SELECTATTR" then -- OBTENER ATRIBUTOS DE UN PJ
	      local MyStr = SLD_Player:SelectAttributes(LD_Table[2])
		   AIO.Msg():Add("LDMsg", MyStr ):Send(player)

      elseif LD_Head == "SELECTROL" then -- OBTENER VARIABLES DE ROL DE UN PJ
	      local MyStr = SLD_Player:SelectRolVars(LD_Table[2])
		   AIO.Msg():Add("LDMsg", MyStr ):Send(player)

      elseif LD_Head == "SAVEPJVAR" then -- OBTENER VARIABLES DE ROL DE UN PJ
	      local MyStr = SLD_Player:SetPjVar(LD_Table[2],LD_Table[3],LD_Table[4],LD_Table[5])
		 
      elseif LD_Head == "SYSTXTTOPJ" then -- ENVIAR UN TEXTO DE SISTEMA A UN PJ
		   local DesPlayer = GetPlayerByName( LD_Table[2] )
		   AIO.Msg():Add("LDMsg", "SYSTXTTOPJ#" .. LD_Table[2] .. "#" .. LD_Table[3] ):Send(DesPlayer)

	   elseif LD_Head == "LAUNCHHAB" then  -- DADOS DE HABILIDAD
		   SLD_Hability.FunctionTypes[LD_Head .. LD_Body]( player, msg)
		 
	   elseif LD_Head == "SETPJAURA" then  -- APLICAR UN AURA A UN PJ
         LD_Pj = LD_Table[2]
         local MyPlayer = GetPlayerByName( LD_Pj )
         if MyPlayer ~= nil then
            MyPlayer:AddAura(tonumber(LD_Table[3]),MyPlayer)
         end

	   elseif LD_Head == "SETFULLENER" or 
	      LD_Head == "SETFULLMANA" or
			LD_Head == "SETFULLVIDA" then  -- RESTAURAR VARIABLES VITALES
		   LD_Pj = LD_Table[2]
         local MyPlayer = GetPlayerByName( LD_Pj )
		   if MyPlayer ~= nil then
		      AIO.Msg():Add("LDMsg", msg ):Send(MyPlayer)
		   end
         
 	   elseif LD_Head == "SHOWVITALVARS" then  -- CONSULTA DE VARIABLES VITALES
	      local MyPj   = LD_Table[2]
		   local SendTo = LD_Table[3]
         local MyPlayer = GetPlayerByName( MyPj )
		   if MyPlayer ~= nil then
		      AIO.Msg():Add("LDMsg", msg ):Send(MyPlayer)
		   end

      elseif LD_Head == "GETVITALVARS" then  -- CONSULTA DE VARIABLES VITALES
	      local MyPj   = LD_Table[2]
		   local SendTo = LD_Table[3]
		   local MyInfo = LD_Table[4]
         local MyPlayer = GetPlayerByName( SendTo )
		   if MyPlayer ~= nil then
		      AIO.Msg():Add("LDMsg", msg ):Send(MyPlayer)
		   end
		 
	   elseif LD_Head == "MODLDPLAYER" then -- ENVIA CODIGO LUA PARA QUE UN PJ LO EJECUTE
	      local MyPj   = LD_Table[2]
         local MyPlayer = GetPlayerByName( MyPj )
		   if MyPlayer ~= nil then
		      AIO.Msg():Add("LDMsg", msg ):Send(MyPlayer)
		   end
		 
      --
	   -- LD Special Protocol
	   -- Type#Subtype#SEQID#Data
	   --
	   elseif LD_Head == "PROTO_LD" then
	      ProcessSysMsg(player, msg)
      else
         PrintInfo("[INFO]HandleLDMsg:114 Unhandled Message:[" .. msg .."]")
      end
   end
   PrintInfo("LD GUI Loaded ...")
else
   LD_RolFrame = nil
   Saved_point, Saved_relativeTo, Saved_relativePoint, Saved_xOfs, Saved_yOfs = MainMenuBar:GetPoint()
   Saved_p1, Saved_f1, Saved_r1, Saved_x1, Saved_y1 = MainMenuBarBackpackButton:GetPoint()
   Saved_p2, Saved_f2, Saved_r2, Saved_x2, Saved_y2 = CharacterBag0Slot:GetPoint()
   BL_p, BL_f, BL_r, BL_x, BL_y = MultiBarBottomLeft:GetPoint()
   BR_p, BR_f, BR_r, BR_x, BR_y = MultiBarBottomRight:GetPoint()
   ML_p, ML_f, ML_r, ML_x, ML_y = MultiBarLeft:GetPoint()
   MR_p, MR_f, MR_r, MR_x, MR_y = MultiBarRight:GetPoint()
   PM1_p, PM1_f, PM1_r, PM1_x, PM1_y = PartyMemberFrame1:GetPoint()
   PM2_p, PM2_f, PM2_r, PM2_x, PM2_y = PartyMemberFrame2:GetPoint()
   PM3_p, PM3_f, PM3_r, PM3_x, PM3_y = PartyMemberFrame3:GetPoint()
   PM4_p, PM4_f, PM4_r, PM4_x, PM4_y = PartyMemberFrame4:GetPoint()
   CLK_p, CLK_f, CLK_r, CLK_x, CLK_y = TimeManagerClockButton:GetPoint()
   
   BL_Visible = MultiBarBottomLeft:IsVisible()
   BR_Visible = MultiBarBottomRight:IsVisible()
   ML_Visible = MultiBarLeft:IsVisible()
   MR_Visible = MultiBarRight:IsVisible()

   PartyMemberFrame1:SetParent(LD_DummyFrame)
   PartyMemberFrame1:SetPoint(PM1_p, 
		                      LD_DummyFrame,
							  PM1_r,
							  3000, 
							  3000)
   PartyMemberFrame2:SetParent(LD_DummyFrame)
   PartyMemberFrame2:SetPoint(PM1_p, 
		                      LD_DummyFrame,
							  PM1_r,
							  3000, 
							  3000)
   PartyMemberFrame3:SetParent(LD_DummyFrame)
   PartyMemberFrame3:SetPoint(PM1_p, 
		                      LD_DummyFrame,
							  PM1_r,
							  3000, 
							  3000)
   PartyMemberFrame4:SetParent(LD_DummyFrame)
   PartyMemberFrame4:SetPoint(PM1_p, 
		                      LD_DummyFrame,
							  PM1_r,
							  3000, 
							  3000)
   PartyMemberFrame1:Hide()
   PartyMemberFrame2:Hide()
   PartyMemberFrame3:Hide()
   PartyMemberFrame4:Hide()
   
   if AIO_LD_CONFIG == nil then
      AIO_LD_CONFIG = {}
   end	  
   AIO_LD_CONFIG["ROLMODE"] = false
   local senttime
   --
   -- Funcion de manejo de mensajes
   --
   function HandleLDMsg(player, msg)
      if (IsAddOnLoaded("TotalRP2")) then
           print("|cff00ffff [LoreDreams]:|c00ffff00 Este juego es incompatible con TotalRP2, desactiva este Addon por favor")
		   message("Este juego es incompatible con TotalRP2, desactiva este Addon por favor");
		   MainMenuBar:SetPoint("TOP", 3000, 3000)
           Minimap:Hide()
           PlayerFrame:Hide()
           MainMenuBar:Hide()
           return
      end
	  local LD_Head, LD_Pj, LD_Body = strsplit ( "#", tostring(msg) )
      local LD_AllFlds = { strsplit ( "#", tostring(msg) )}
	  
	  
      if (LD_Head == "PRTXT") then -- Imprime texto
	     -- print(msg)
         print (LD_Body)
      elseif LD_Head == "HABIL" then -- MENSAJE DE HABILIDAD
         ProcessHabMsg(player, msg)        
      elseif LD_Head == "PLAYER" then -- MENSAJE DE JUGADOR
         SLD_Player:ProcessMsg(player,msg)        
      elseif (LD_Head == "LDNOG") then -- CLEAR RAID
	     LD_ClearRAID()
		 LD_RaidFrame:Hide()
      elseif (LD_Head == "LDGRM") then -- FILL RAID Slot
	     LD_FillRAIDSlot ( LD_AllFlds[2], tonumber(LD_AllFlds[3]), LD_AllFlds[4], LD_AllFlds[5] )
	     -- LD_ServerDebug ( msg )
      elseif (LD_Head == "PVEMD") then -- MODO PVE
         SLD_Player.IsOnrol = false

		 TimeManagerClockButton:SetParent(CLK_f)
		 TimeManagerClockButton:SetPoint(CLK_p, CLK_f, CLK_r, CLK_x, CLK_y)
		 LD_MainFrame:Hide()
       LD_BasicHabilitiesFrame:Hide()
		 LD_ATRFrame:Hide()
		 LD_ROLFrame:Hide()
		 LD_MacroFrame:Hide()
		 LD_StatusBars:Hide()
		 MainMenuBar:SetParent(Saved_relativeTo)
      	 MainMenuBar:SetPoint(Saved_point, 
		                      Saved_relativeTo, 
							  Saved_relativePoint, 
							  Saved_xOfs, 
							  Saved_yOfs)
		 MainMenuBarBackpackButton:SetParent(Saved_f1)
		 MainMenuBarBackpackButton:SetPoint (Saved_p1, Saved_f1, Saved_r1, Saved_x1, Saved_y1)
		 CharacterBag0Slot:SetParent(Saved_f2)
		 CharacterBag1Slot:SetParent(Saved_f2)
		 CharacterBag2Slot:SetParent(Saved_f2)
		 CharacterBag3Slot:SetParent(Saved_f2)
		 if BL_Visible then
		    MultiBarBottomLeft:SetParent(BL_f)
		    MultiBarBottomLeft:Show()
		 end
		 if BR_Visible then
		    MultiBarBottomRight:SetParent(BR_f)
		    MultiBarBottomRight:Show()
		 end
		 if ML_Visible then
		    MultiBarLeft:SetParent(ML_f)
		    MultiBarLeft:Show()
		 end
		 if MR_Visible then
		    MultiBarRight:SetParent(MR_f)
		    MultiBarRight:Show()
		 end
		 MainMenuBar:Show()
		 Minimap:Show()
		 MinimapCluster:Show()
		 PlayerFrame:Show()
		 SysPrint ("Modo PVE activado")
		 
      elseif (LD_Head == "ROLMD") then -- MODO ROL
	     if SLD_Player.App ~= "A" then
		    print ("Tu ficha no ha sido aprobada todavia\n Habla con un GM para que sea aprobada y puedas entrar al modo ROL")
			return
		 end
   	     if AIO_LD_CONFIG["ATRIBUTO"] == nil then
            local MyRaceLoc, MyRace = UnitRace("player")
            AIO_LD_CONFIG["ATRIBUTO"] = {}
            AIO_LD_CONFIG["ATRIBUTO"]["FUERZA"] = AIO_LD_CONFIG["SYS"]["ATTRSETS"][MyRace]["FUERZA_MIN"]
            LD_SetPjVar ( "FUERZA", "ATRIBUTO", 5, 0 )
            AIO_LD_CONFIG["ATRIBUTO"]["CONSTI"] = AIO_LD_CONFIG["SYS"]["ATTRSETS"][MyRace]["CONSTI_MIN"]
            LD_SetPjVar ( "CONSTI", "ATRIBUTO", 5, 0 )
            AIO_LD_CONFIG["ATRIBUTO"]["DESTRE"] = AIO_LD_CONFIG["SYS"]["ATTRSETS"][MyRace]["DESTRE_MIN"]
            LD_SetPjVar ( "DESTRE", "ATRIBUTO", 5, 0 )
            AIO_LD_CONFIG["ATRIBUTO"]["AGILID"] = AIO_LD_CONFIG["SYS"]["ATTRSETS"][MyRace]["AGILID_MIN"]
            LD_SetPjVar ( "AGILID", "ATRIBUTO", 5, 0 )
            AIO_LD_CONFIG["ATRIBUTO"]["INTELE"] = AIO_LD_CONFIG["SYS"]["ATTRSETS"][MyRace]["INTELE_MIN"]
            LD_SetPjVar ( "INTELE", "ATRIBUTO", 5, 0 )
            AIO_LD_CONFIG["ATRIBUTO"]["SABIDU"] = AIO_LD_CONFIG["SYS"]["ATTRSETS"][MyRace]["SABIDU_MIN"]
            LD_SetPjVar ( "SABIDU", "ATRIBUTO", 5, 0 )
            AIO_LD_CONFIG["ATRIBUTO"]["PERCEP"] = AIO_LD_CONFIG["SYS"]["ATTRSETS"][MyRace]["PERCEP_MIN"]
            LD_SetPjVar ( "PERCEP", "ATRIBUTO", 5, 0 )
         end

         SLD_Player.IsOnrol = true
		 LD_MainFrame:Show()
       LD_BasicHabilitiesFrame:Show()
		 TimeManagerClockButton:SetParent(LD_MainFrame)
		 TimeManagerClockButton:SetPoint("TOPLEFT", LD_MainFrame, "TOPLEFT", 0, 10)
         LD_StatusBars:Show()
		 MainMenuBar:SetParent(LD_DummyFrame)
	     MainMenuBar:SetPoint(Saved_point, 
		                      LD_DummyFrame,
							  Saved_relativePoint,
							  3000, 
							  3000)
         MainMenuBar:Hide()
         BL_Visible = MultiBarBottomLeft:IsVisible()
         BR_Visible = MultiBarBottomRight:IsVisible()
         ML_Visible = MultiBarLeft:IsVisible()
         MR_Visible = MultiBarRight:IsVisible()
         
		 if BL_Visible then
		    MultiBarBottomLeft:SetParent(LD_DummyFrame)
		    MultiBarBottomLeft:Hide()
		 end
		 if BR_Visible then
		    MultiBarBottomRight:SetParent(LD_DummyFrame)
		    MultiBarBottomRight:Hide()
		 end
		 if ML_Visible then
		    MultiBarLeft:SetParent(LD_DummyFrame)
		    MultiBarLeft:Hide()
		 end
		 if MR_Visible then
		    MultiBarRight:SetParent(LD_DummyFrame)
		    MultiBarRight:Hide()
		 end
         LD_DummyFrame:Hide()
		 
		 MainMenuBarBackpackButton:SetParent (UIParent)
		 CharacterBag0Slot:SetParent(UIParent)
		 CharacterBag1Slot:SetParent(UIParent)
		 CharacterBag2Slot:SetParent(UIParent)
		 CharacterBag3Slot:SetParent(UIParent)
		 MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT")
		 MinimapCluster:Hide()
		 Minimap:Hide()
         PlayerFrame:Hide()
		 
		 MyBt1 = ActionButton1
		 MyBt1:Show()
		 
		 -- A ver si estamos en grupo
	     LDSendMsg("LDPMF#" .. UnitName("player") )   

		 SysPrint ("Modo rol activado")
		 -- print ("Como la cosa no está terminada vas a tener que usar barras secundarias y esas mandangas")
		 -- print ("¿Te molesta verdad? .... Vaaaale perdona")
		 
      elseif LD_Head == "LDSYS" then -- VARIABLE DE SISTEMA
	     -- print ("DEBUG: " .. msg )
	     local LD_Type  = LD_AllFlds[2]
	     local LD_SType = LD_AllFlds[3]
		 local LD_Name  = LD_AllFlds[4]
		 local LD_Value = LD_AllFlds[5]
		 if AIO_LD_CONFIG["SYS"] == nil then
		    AIO_LD_CONFIG["SYS"] = {}
		 end
		 if AIO_LD_CONFIG["SYS"][LD_Type] == nil then
		    AIO_LD_CONFIG["SYS"][LD_Type] = {}
		end
		if AIO_LD_CONFIG["SYS"][LD_Type][LD_SType] == nil then
	       AIO_LD_CONFIG["SYS"][LD_Type][LD_SType] = {}
        end			   
		AIO_LD_CONFIG["SYS"][LD_Type][LD_SType][LD_Name] = LD_Value
		-- print("DEBUG: AIO_LD_CONFIG[SYS][" .. LD_Type .. "][" .. LD_SType .. "][" .. LD_Name .. "]=" .. AIO_LD_CONFIG["SYS"][LD_Type][LD_SType][LD_Name])

	 elseif LD_Head == "LDGET" then -- VARIABLE DE SESION
	     -- print ("DEBUG: " .. msg )
	     local LD_Index = LD_AllFlds[2]
	     local LD_Value = LD_AllFlds[3]
		 local LD_Type  = LD_AllFlds[4]
		 if AIO_LD_CONFIG[LD_Type] == nil then
		    AIO_LD_CONFIG[LD_Type] = {}
		 end
		 AIO_LD_CONFIG[LD_Type][LD_Index] = LD_Value
		 -- print ("DEBUG: AIO_LD_CONFIG[" .. LD_Type .. "][" .. LD_Index .. "] = " .. LD_Value )

	 elseif LD_Head == "LDGEN" then -- DATOS GENERALES DEL SERVER
	     -- print ("DEBUG: " .. msg )
	     local LD_Pj    = LD_AllFlds[2]
	     local LD_Index = LD_AllFlds[3]
	     local LD_Type  = LD_AllFlds[4]
		 local LD_Value = LD_AllFlds[5]
		 if AIO_LD_CONFIG["DATA"] == nil then
		    AIO_LD_CONFIG["DATA"] = {}
		 end
		 if AIO_LD_CONFIG["DATA"][LD_Pj] == nil then
		    AIO_LD_CONFIG["DATA"][LD_Pj] = {}
		 end
		 if AIO_LD_CONFIG["DATA"][LD_Pj][LD_Type] == nil then
		    AIO_LD_CONFIG["DATA"][LD_Pj][LD_Type] = {}
		 end
		 AIO_LD_CONFIG["DATA"][LD_Pj][LD_Type][LD_Index] = LD_Value
         -- LD_ServerDebug("AIO_LD_CONFIG[DATA]["..LD_Pj.."]["..LD_Type.."]["..LD_Index.."] = " ..LD_Value)

	 elseif LD_Head == "LDDAT" then -- DATOS GENERALES
	     local LD_Index    = LD_AllFlds[2]
	     local LD_Value    = LD_AllFlds[3]
		 local LD_Type     = LD_AllFlds[4]
		 local LD_Section  = LD_AllFlds[5]
		 if AIO_LD_CONFIG["DATA"] == nil then
		    AIO_LD_CONFIG["DATA"] = {}
		 end
		 if AIO_LD_CONFIG["DATA"][LD_Type] == nil then
		    AIO_LD_CONFIG["DATA"][LD_Type] = {}
		 end
		 if AIO_LD_CONFIG["DATA"][LD_Type][LD_Section] == nil then
		    AIO_LD_CONFIG["DATA"][LD_Type][LD_Section] = {}
		 end
		 AIO_LD_CONFIG["DATA"][LD_Type][LD_Section][LD_Index] = LD_Value
		 
      elseif LD_Head == "LDEVT" then -- MAESTROS DE ATRIBUTO
	     -- print ("DEBUG: " .. LD_AllFlds[3] )
	     if LD_AllFlds[3] == "Zipeau Magicfingers" or
		    LD_AllFlds[3] == "Oraculus Coscotodo" or
			LD_AllFlds[3] == "Muelleflojo Parcour" or
			LD_AllFlds[3] == "Seneca Kerabiadas" or
			LD_AllFlds[3] == "Martinez Gordobiceps" or
			LD_AllFlds[3] == "Poveda Cuatroojos" or
			LD_AllFlds[3] == "Poveda Empollonum" or
			LD_AllFlds[3] == "Noremasti Todoinmune" then
            if SLD_Player.IsOnrol ~= true then
               message("Debes estar en modo rol para comerciar aqui")
            return
            end	
            if AIO_LD_CONFIG["ROL"]["APP"] == nil then
               message("No tienes el personaje activo para Rol, manda tu historia primero.")
               return
            end	
			LD_AttrVendFrame.MyVend:SetText(LD_AllFlds[3])
			LD_AttrVendFrame.MyVendTx:SetText("Maestro de " .. LD_ATRVendors[LD_AllFlds[3]][2] .. 
			"\n________________________")
			LD_AttrVendFrame.MyVendTxl:SetText (LD_ATRVendors[LD_AllFlds[3]][3])
			LD_AttrVendFrame.AttrDesc  = LD_ATRVendors[LD_AllFlds[3]][2]
			LD_AttrVendFrame.AttrBBDD  = LD_ATRVendors[LD_AllFlds[3]][1]
		    LD_AttrVendFrame:Show()
		 elseif LD_AllFlds[3] == "Tutorius Atributum" then
			LD_AttrTutor:SetSize(520, 500)
		    LD_AttrTutor.MyVendTxl:SetText(EXPLICACION_ATRIBUTOS)
			LD_AttrTutor.MyVend:SetText("Explicacion de los atributos")
			LD_AttrTutor.MyVendTxl:SetSize (500, 420)
		    LD_AttrTutor:Show()
		 elseif LD_AllFlds[3] == "Abecesio Porterele" then
            LD_AttrTutor:SetSize(320, 500)
		    LD_AttrTutor.MyVendTxl:SetText(HISTORIA_TIRISFAL)
            LD_AttrTutor.MyVend:SetText("Monasterio de Tirisfal")
            LD_AttrTutor.MyVendTxl:SetSize (300, 420)
		    LD_AttrTutor:Show()
		 elseif LD_AllFlds[3] == "Pretibolio Cuchicherez" then
            LD_AttrTutor:SetSize(320, 400)
		    LD_AttrTutor.MyVendTxl:SetText(ESTADO_GENERAL)
            LD_AttrTutor.MyVend:SetText("Estado General")
            LD_AttrTutor.MyVendTxl:SetSize (300, 380)
		    LD_AttrTutor:Show()
         else
		    LD_AttrVendFrame:Hide()
			LD_AttrTutor:Hide()
         end
		 
      elseif LD_Head == "HISPJ" then -- HISTORA PARA APROBAR
	     LD_ApproFrame.PjName = LD_AllFlds[2]
	     if LD_AllFlds[3] == "NOMBRE" then
		    LD_ApproFrame.Nombre:SetText(LD_AllFlds[4])
		 elseif LD_AllFlds[3] == "APELLIDO" then
		    LD_ApproFrame.Apellidos:SetText(LD_AllFlds[4])
		 elseif LD_AllFlds[3] == "EDAD" then
		    LD_ApproFrame.Edad:SetText(LD_AllFlds[4])
		 elseif LD_AllFlds[3] == "HIST1" then
		    LD_ApproFrame.Hist1:SetText(LD_AllFlds[4])
		 elseif LD_AllFlds[3] == "HIST2" then
		    LD_ApproFrame.Hist2:SetText(LD_AllFlds[4])
		 elseif LD_AllFlds[3] == "APP" then
		    if LD_AllFlds[4] == "A" then
			   LD_ApproFrame.Cabecera:SetText( LD_AllFlds[2] .. " FICHA YA APROVADA!!!")
			else
			   LD_ApproFrame.Cabecera:SetText( LD_AllFlds[2] .. ": Ficha pendiente de aprobacion")
			end   
		 elseif LD_AllFlds[3] == "SHOW" then
			LD_ApproFrame:Show()
         end
      elseif LD_Head == "OPCMT" then -- ABRIR COMBATE
		 OpenCombat()
      elseif LD_Head == "CLCMT" then -- CERRAR COMBATE
		 CloseCombat()
      --
      -- NEW MSG HANDLING
      --	  
	  
	  -- LD_Player
      elseif LD_Head == "SETALLATTR" then  -- OBTENER ATRIBUTOS DE UN PJ
	     SLD_Player:GetAttributes(msg)

	  elseif LD_Head == "SETALLROL" then   -- OBTENER VARIABLES DE ROL DE UN PJ
	     SLD_Player:GetRolVars(msg)

      elseif LD_Head == "SETDICEVARS" then -- OBTENER VARIABLES DE DADOS/SAY DE UN PJ
		 SLD_Player:GetDiceVars(msg)
		 
      elseif LD_Head == "SETACCOUNT" then  -- CUENTA ASOCIADA AL PJ
		 SLD_Player:GetAccount(LD_AllFlds[3])

      elseif LD_Head == "SYSTXTTOPJ" then -- ENVIAR UN TEXTO DE SISTEMA A UN PJ
		 SysPrint(LD_AllFlds[3])

      elseif LD_Head == "PJHABILITY" then -- AÑADIR HABILIDAD A PJ
		 SLD_Player.Habilidades[LD_AllFlds[2]] = SLD_Hability:New(msg)
		 for i = 0,19 do
		    if SLD_HabilityFrame.HabID[i+1] == 0 then
			   SLD_HabilityFrame.HabID[i+1] = SLD_Player.Habilidades[LD_AllFlds[2]].ID
			   SLD_HabilityFrame.HabName[i+1] = LD_AllFlds[2]
			   SLD_HabilityFrame.Buttons[i+1] = LD_ButtonFrame ( 10+(i*30), 10, SLD_HabilityFrame,"Interface\\ICONS\\" .. SLD_Player.Habilidades[LD_AllFlds[2]].Icono)
			   SLD_HabilityFrame.Buttons[i+1]:SetScript( "OnEnter" , 
			      function(self) 
                     self:SetAlpha(1) 
                     GameTooltip:SetOwner(self, "ANCHOR_LEFT")
                     GameTooltip:AddLine("|cff00ffff" .. SLD_Player.Habilidades[LD_AllFlds[2]].Nom .. 
				     " (Rango " .. tostring (SLD_Player.Habilidades[LD_AllFlds[2]].Leveau) .. ")");
	                 GameTooltip:Show()
                  end)
               SLD_HabilityFrame.Buttons[i+1]:SetScript("OnLeave", 
                  function(self) 
                     self:SetAlpha(0.5) 
                     GameTooltip:Hide()
                  end)
               SLD_HabilityFrame.Buttons[i+1]:SetScript("OnClick", 
                  function(self) 
				     local MyIndex = SLD_Player.Habilidades[LD_AllFlds[2]].FunctionType
					 local MyHability = SLD_Player.Habilidades[LD_AllFlds[2]]
				     SLD_Hability.FunctionTypes[MyIndex](MyHability)
					 SLD_Hability:ShowAllHabilities ()
				  end)
			   return
			end
         end
      
	  elseif LD_Head == "SETFULLENER" then
	     SLD_Player.ENER = SLD_Player.TopENER
		 LD_RefreshBars()
		 
	  elseif LD_Head == "SETFULLMANA" then
	     SLD_Player.MANA = SLD_Player.TopMANA
		 LD_RefreshBars()
		 
	  elseif LD_Head == "SETFULLVIDA" then  -- RESTAURAR VARIABLES VITALES
	     SLD_Player.VIDA = SLD_Player.TopVIDA
		 LD_RefreshBars()

	  elseif LD_Head == "SHOWVITALVARS" then  -- CONSULTA DE VARIABLES VITALES
	     local MyPj   = LD_AllFlds[2]
		 local SendTo = LD_AllFlds[3]
	     local MyMSG  = MyPj .. " variables vitales:\n" ..
		                "Vida:" .. tostring (SLD_Player.VIDA) .. "(Max:" .. tostring (SLD_Player.TopVIDA) .. ")\n" ..
	                    "Maná:" .. tostring (SLD_Player.MANA) .. "(Max:" .. tostring (SLD_Player.TopMANA) .. ")\n" ..
	                    "Ene.:" .. tostring (SLD_Player.ENER) .. "(Max:" .. tostring (SLD_Player.TopENER) .. ")\n"
		 LDSendMsg ( "GETVITALVARS#" .. MyPj .. "#" .. SendTo .. "#" .. MyMSG )
	  
	  elseif LD_Head == "GETVITALVARS" then  -- CONSULTA DE VARIABLES VITALES
	     print (LD_AllFlds[4])
		 
	  elseif LD_Head == "MODLDPLAYER" then -- EJECUTA CODIGO LUA DEFINIDO EN 'Item'
	     local MyPj   = LD_AllFlds[2]
		 local Item   = LD_AllFlds[3]
         local MyEval = loadstring(	Item )
         MyEval()		

	  elseif LD_Head == "TEATACAN" then -- PJ ES ATACADO
	     LD_ServerDebug(msg)
	     local LD_Habilidad = LD_AllFlds[2]
	     local LD_Result = LD_AllFlds[3]
		 local LD_Foe = LD_AllFlds[4]
		 local LD_TimeStamp = LD_AllFlds[7]
		 LDSendMsg("ROLMD#" .. UnitName("player") .. "#WORLD")
		 LD_ROLFrame:Show()
         SLD_HabilityFrame:Show()
         
		 SLD_Player.PendingMsg = tonumber(LD_AllFlds[5])
		 SLD_Player.LastAttack = tonumber(LD_Result)
		 SLD_Hability:ShowDefenseHabilities ()
	     -- PRTXT#SYSTEM#|cff00ff00[" .. LD_Body .. "]
         StaticPopup_Show("MEATACAN")

	 else
	     LD_ServerDebug ("Client, unhandled message: " .. msg )
      end
   end     	  
   
   -- assert(not LDSendMsg, "SLD_GUI.lua: LDSendMsg is already defined")
   --
   -- CARGA DE DATOS Y FRAME OCULTA
   --
   LD_LoadPjData()
   
   
   LD_DummyFrame=CreateFrame ( "Frame", "LD_DummyFrame", UIParent )
   LD_DummyFrame:SetSize(20,20)
   LD_DummyFrame:RegisterEvent("TARGET_UNIT")
   LD_DummyFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
   LD_DummyFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
   LD_DummyFrame:RegisterEvent("CHANNEL_VOICE_UPDATE")
   LD_DummyFrame:RegisterEvent("SPELL_UPDATE_USABLE")
   LD_DummyFrame:SetScript("OnEvent", LDDummy_OnEvent)
  

    -- Funcion de envio de mensaje
    -- function LDSendMsg( Msg )
    --    senttime = time()
    --    AIO.Msg():Add("LDMsg", Msg):Send()
    -- end
	
	
	LDSendMsg("HELLO#" .. UnitName("player") )   
    -- ChatFrame_OnEvent = LD_OnEvent
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", LD_OnEvent)
	-- ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", LD_OnEvent)
	-- ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", LD_OnEvent)
	-- ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", LD_OnEvent)
	-- ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", LD_OnEvent)
	-- ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", LD_OnEvent)
	-- ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", LD_OnEvent)
	-- ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", LD_OnEvent)
	-- ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", LD_OnEvent)
	

end

AIO.RegisterEvent("LDMsg", HandleLDMsg)

