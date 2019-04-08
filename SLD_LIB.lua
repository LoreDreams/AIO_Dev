local AIO = AIO or require("AIO")
assert(not SLD_LIB, "SLD_LIB is already loaded. Possibly different versions!")
-- SLD_LIB main table
SLD_LIB =
{
    -- SLD_LIB flavour functions
    unpack = unpack,
}

local SLD_LIB = SLD_LIB
if not AIO.AddAddon() then
   function LDSendMsg( Msg )
       senttime = time()
       AIO.Msg():Add("LDMsg", Msg):Send()
   end
   -- LDSendMsg( "SELECTATTR#Irma#" )
   -- LDSendMsg( "SELECTROL#Irma#" )
   --
   -- VARIABLES GLOBALES
   --
   LD_Saved_ChatFrameEvent = nil
   AIO_LD_CONFIG = {}
   --
   -- Funciones varias de utilidad
   --
   function LD_deciToHexa(number)
	number = math.floor(number*255);
	local num1 = math.fmod(number, 16);
	local num2 = math.floor(number/16);
	if num2 == 10 then
		num2 = "A";
	elseif num2 == 11 then
		num2 = "B";
	elseif num2 == 12 then
		num2 = "C";
	elseif num2 == 13 then
		num2 = "D";
	elseif num2 == 14 then
		num2 = "E";
	elseif num2 == 15 then
		num2 = "F";
	end
	if num1 == 10 then
		num1 = "A";
	elseif num1 == 11 then
		num1 = "B";
	elseif num1 == 12 then
		num1 = "C";
	elseif num1 == 13 then
		num1 = "D";
	elseif num1 == 14 then
		num1 = "E";
	elseif num1 == 15 then
		num1 = "F";
	end
	return ""..num2..num1;
   end
   
   function LD_ColorToHexa(r,g,b)
      return "|cff"..LD_deciToHexa(r)..LD_deciToHexa(g)..LD_deciToHexa(b);
   end
   
   function LD_Today()
      local ThisDate = date("%Y%m%d%H%M%S")
	  return ThisDate
   end

   function LD_ServerDebug (text)
      LDSendMsg ( "PRDEB"  .. "#" .. UnitName("player") .. "#" .. text )
   end
   
   function PG (text)
      LDSendMsg ( "PRTXT"  .. "#" .. UnitName("player") .. "#" .. text )
   end
   
   function LT ( Player, Attr, Value)
      LDSendMsg ( "CATTR" .. "#" .. tostring(Player) .. "." .. tostring(Attr) .. "." .. tostring(Value))
   end
   
   function RD (MyMin, MyMax)
      MyRnd = random (MyMin, MyMax)
      PG ( "|cff00ffff[" .. UnitName("Player") .. "]|cffffff00 tira los dados y obtiene " .. MyRnd .. " (" ..MyMin .. "-" .. MyMax .. ")")
      return MyRnd
   end
   
   function SysPrint(msg)
      print("|cffaaaaff[LD]: " .. msg )
   end

   function ErrPrint(msg)
      print("|cffff0000[LD]: " .. msg )
   end
   
   -- VARIABLES GUARDADAS
   function LD_SetPjVar ( MyName, MyType, MyValue )
      local ThisDate = date("%Y%m%d%H%M%S")
      LDSendMsg("LDSET#" .. UnitName("player") .. "#" .. MyName .. "#" .. 
	            MyType  .. "#" .. MyValue  .. "#" .. ThisDate)
      AIO_LD_CONFIG[MyType][MyName]	= MyValue
      -- print("DEBUG:AIO_LD_CONFIG[" .. MyType .. "][" .. MyName .. "]=" .. MyValue)
   end
   function LD_GetPjVar ( MyName, MyType, MyValue )
      LDSendMsg("LDGET#" .. UnitName("player") .. "#" .. MyName  .. "#" .. MyType .. "#" .. MyValue )
   end
   function LD_GetPjVarDef ( MyName, MyType, MyValue, MyDefault )
      LDSendMsg("LDGDF#" .. UnitName("player") .. "#" .. MyName  .. "#" .. MyType .. "#" .. MyValue .. "#" .. MyDefault)
   end
   function LD_GetAllPjVar ( MyType )
      LDSendMsg("GTALL#" .. UnitName("player") .. "#" .. MyType )
   end
   function LD_LoadPjData ()
      LDSendMsg("GTAPJ#" .. UnitName("player") )
      LDSendMsg("LDSYS#" .. UnitName("player") )
      if AIO_LD_CONFIG["ATRIBUTO"] == nil then
	     AIO_LD_CONFIG["ATRIBUTO"] = {}
      end		 
      if AIO_LD_CONFIG["ATRIBUTO"]["MFUERZA"] == nil then
	     AIO_LD_CONFIG["ATRIBUTO"]["MFUERZA"] = 0
		 LD_SetPjVar ( "MFUERZA", "ATRIBUTO", 0)
	  end	 
      if AIO_LD_CONFIG["ATRIBUTO"]["MCONSTI"] == nil then
	     AIO_LD_CONFIG["ATRIBUTO"]["MCONSTI"] = 0
		 LD_SetPjVar ( "MCONSTI", "ATRIBUTO", 0)
	  end	 
      if AIO_LD_CONFIG["ATRIBUTO"]["MDESTRE"] == nil then
	     AIO_LD_CONFIG["ATRIBUTO"]["MDESTRE"] = 0
		 LD_SetPjVar ( "MDESTRE", "ATRIBUTO", 0)
	  end	 
      if AIO_LD_CONFIG["ATRIBUTO"]["MAGILID"] == nil then
	     AIO_LD_CONFIG["ATRIBUTO"]["MAGILID"] = 0
		 LD_SetPjVar ( "MAGILID", "ATRIBUTO", 0)
	  end	 
      if AIO_LD_CONFIG["ATRIBUTO"]["MINTELE"] == nil then
	     AIO_LD_CONFIG["ATRIBUTO"]["MINTELE"] = 0
		 LD_SetPjVar ( "MINTELE", "ATRIBUTO", 0)
	  end	 
      if AIO_LD_CONFIG["ATRIBUTO"]["MSABIDU"] == nil then
	     AIO_LD_CONFIG["ATRIBUTO"]["MSABIDU"] = 0
		 LD_SetPjVar ( "MSABIDU", "ATRIBUTO", 0)
	  end	 
      if AIO_LD_CONFIG["ATRIBUTO"]["MPERCEP"] == nil then
	     AIO_LD_CONFIG["ATRIBUTO"]["MPERCEP"] = 0
		 LD_SetPjVar ( "MPERCEP", "ATRIBUTO", 0)
	  end	 
	  
	  
   end
   
   function LD_EditFrame ( MyParentFrame, LeftOff, TopOff, Xsize, Ysize, MyIndex, MyDefault, IsNumeric)
      local MyEditFrame=CreateFrame("EditBox", "MyEditFrame" .. tostring(MyIndex), MyParentFrame, "UIPanelButtonTemplate" )
      MyEditFrame:SetPoint("TOPLEFT",LeftOff,TopOff)
      MyEditFrame:SetWidth(Xsize)
      MyEditFrame:SetHeight(Ysize)
      local MyEditFrameTex = MyEditFrame:CreateTexture("MyEditFrameTex")
      MyEditFrameTex:SetAllPoints(MyEditFrame)
      MyEditFrameTex:SetTexture(0, 0, 0.6, 0.6)
      MyEditFrame.Texture = MyEditFrameTex
      MyEditFrame:SetBackdrop(nil)
      MyEditFrame:SetAutoFocus(false)
      MyEditFrame:SetFontObject(GameFontNormalSmall)   
      MyEditFrame:SetTextInsets(0, 0, 3, 3)
      if IsNumeric == true then
         MyEditFrame:SetText (tostring(MyDefault))
	     -- print ("Number: " .. tostring(MyDefault) .. "(" .. tostring(MyIndex) ..")" .. MyEditFrame:GetText())
      else										  
         MyEditFrame:SetText (MyDefault)
	     -- print ("String: " .. MyDefault .. "(" .. tostring(MyIndex) ..")" .. MyEditFrame:GetText())
      end
      return MyEditFrame
   end
   function LD_EditFrameTrans ( MyParentFrame, LeftOff, TopOff, Xsize, Ysize, MyIndex, MyDefault, IsNumeric, Transp)
      local MyEditFrame=CreateFrame("EditBox", "MyEditFrame" .. tostring(MyIndex), MyParentFrame, "UIPanelButtonTemplate" )
      MyEditFrame:SetPoint("TOPLEFT",LeftOff,TopOff)
      MyEditFrame:SetWidth(Xsize)
      MyEditFrame:SetHeight(Ysize)
      local MyEditFrameTex = MyEditFrame:CreateTexture("MyEditFrameTex")
      MyEditFrameTex:SetAllPoints(MyEditFrame)
      MyEditFrameTex:SetTexture(0, 0, 0.6, Transp)
      MyEditFrame.Texture = MyEditFrameTex
      MyEditFrame:SetBackdrop(nil)
      MyEditFrame:SetAutoFocus(false)
      MyEditFrame:SetFontObject(GameFontNormalSmall)   
      MyEditFrame:SetTextInsets(0, 0, 3, 3)
      if IsNumeric == true then
         MyEditFrame:SetText (tostring(MyDefault))
	     -- print ("Number: " .. tostring(MyDefault) .. "(" .. tostring(MyIndex) ..")" .. MyEditFrame:GetText())
      else										  
         MyEditFrame:SetText (MyDefault)
	     -- print ("String: " .. MyDefault .. "(" .. tostring(MyIndex) ..")" .. MyEditFrame:GetText())
      end
      return MyEditFrame
   end
   function LD_ButtonFrame (Xoff, Yoff, PFrame, Icon)
      local MyFrame = CreateFrame ( "Button", "LD_F" .. tostring(Xoff) .. tostring(Yoff), PFrame )
	  MyFrame:SetSize(20,20)
	  MyFrame:SetAlpha(0.5)
	  MyFrame.MyT = MyFrame:CreateTexture(nil,"BACKGROUND",nil,-6)
	  if Icon ~= nil then
         MyFrame.MyT:SetTexture(Icon)
	  end	 
      MyFrame.MyT:SetTexCoord(0.1,0.9,0.1,0.9) --cut out crappy icon border
      MyFrame.MyT:SetAllPoints(MyFrame) --make texture sa
	  MyFrame:SetPoint ( "BOTTOMLEFT", Xoff, Yoff )
	  return MyFrame
   end
   function LD_ButtonFrameSmall (Xoff, Yoff, PFrame, Icon)
      local MyFrame = CreateFrame ( "Button", "LD_F" .. tostring(Xoff) .. tostring(Yoff), PFrame )
	  MyFrame:SetSize(10,10)
	  MyFrame:SetAlpha(0.5)
	  local MyT = MyFrame:CreateTexture(nil,"BACKGROUND",nil,-6)
      MyT:SetTexture(Icon)
      MyT:SetTexCoord(0.1,0.9,0.1,0.9) --cut out crappy icon border
      MyT:SetAllPoints(MyFrame) --make texture sa
	  MyFrame:SetPoint ( "BOTTOMLEFT", Xoff, Yoff )
	  return MyFrame
   end
   
   function LD_ButtonFrameTop (Xoff, Yoff, PFrame, Icon)
      local MyFrame = CreateFrame ( "Button", "LD_BF" .. tostring(Xoff) .. tostring(Yoff), PFrame )
	  MyFrame:SetSize(20,20)
	  MyFrame:SetAlpha(1)
	  MyFrame.MyT = MyFrame:CreateTexture(nil,"BACKGROUND",nil,-6)
      MyFrame.MyT:SetTexture(Icon)
      MyFrame.MyT:SetTexCoord(0.1,0.9,0.1,0.9) --cut out crappy icon border
      MyFrame.MyT:SetAllPoints(MyFrame) --make texture sa
	  MyFrame:SetPoint ( "TOPLEFT", Xoff, Yoff )
	  return MyFrame
   end
   
   function LD_LabelTop (Xoff, Yoff, PFrame, Text)
      local MyFont = PFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
      MyFont:SetFontObject(GameFontNormal)   
      MyFont:SetTextColor(1, 1, 1, 1)
      MyFont:SetPoint("TOPLEFT", PFrame, "TOPLEFT", Xoff, Yoff)
	  MyFont:SetText ( Text )
	  return MyFont
   end
   
   function LD_LabelTopColors (Xoff, Yoff, PFrame, Text, MyR, MyG, MyB, MyT)
      local MyFont = PFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
      MyFont:SetFontObject(GameFontNormal)   
      MyFont:SetTextColor(MyR, MyG, MyB, MyT)
      MyFont:SetPoint("TOPLEFT", PFrame, "TOPLEFT", Xoff, Yoff)
	  MyFont:SetText ( Text )
	  return MyFont
   end
   
   function LD_LabelTopS (Xoff, Yoff, PFrame, Text)
      local MyFont = PFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
      MyFont:SetFontObject(GameFontNormalSmall)   
      MyFont:SetTextColor(1, 1, 1, 1)
      MyFont:SetPoint("TOPLEFT", PFrame, "TOPLEFT", Xoff, Yoff)
	  MyFont:SetText ( Text )
	  return MyFont
   end

else
   --
   -- FUNCIONES DE UTILIDAD DEL SERVER
   --
   function mysplit(inputstr, sep)
      if sep == nil then
         sep = "%s"
      end
      t={}
      local i=1
      for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
         t[i] = str
         i = i + 1
      end
      return t
   end
   function LD_GetPjNameByID ( MyID )
      local MySQLCommand= "SELECT name from characters where guid = " .. tostring(MyID) .. ";"
	  local MyRes = CharDBQuery(MySQLCommand)
	  local MyVal = nil
	  local MyList = {}
	  local MyIndex = 1
      if ( MyRes ~= nil ) then
         local NumRows = MyRes:GetRowCount()
         for i = 1,NumRows do
            MyVal = MyRes:GetString( 0 )
            MyRes:NextRow()
         end
      end
	  return MyVal
   end
   function LD_GetGroupMembersByLeader ( MyID )
      local MySQLCommand= "SELECT guid from group_member where memberGuid = " .. tostring(MyID) .. ";"
	  local MyRes = CharDBQuery(MySQLCommand)
	  local MyVal = nil
	  local MyList = {}
	  local MyIndex = 1
      if ( MyRes ~= nil ) then
         local NumRows = MyRes:GetRowCount()
         for i = 1,NumRows do
            MyVal = MyRes:GetString( 0 )
            MyRes:NextRow()
         end
      end
	  MySQLCommand= "SELECT memberGuid from group_member where guid = " .. tostring(MyVal) .. ";"
	  MyRes = CharDBQuery(MySQLCommand)
      if ( MyRes ~= nil ) then
         local NumRows = MyRes:GetRowCount()
         for i = 1,NumRows do
            MyList[MyIndex] = MyRes:GetString( 0 )
			MyIndex=MyIndex+1
            MyRes:NextRow()
         end
      end
	  return MyList
   end
   function LD_CheckPjGroup ( player )
      SLD_LoadData(player)
      local MyGrp = player:GetGroup()
      if MyGrp == nil then
         AIO.Msg():Add("LDMsg", "LDNOG#SYS" ):Send(player)
		 return
      end
	  local MyleaderGUID = MyGrp:GetLeaderGUID()
	  local MyGrpMembers = LD_GetGroupMembersByLeader(MyleaderGUID)
      local NumGrPj = MyGrp:GetMembersCount()
	  local MyPlayer = nil
	  local MyPlayerName = ""
	  
	  for k in pairs(MyGrpMembers) do
	     MyPlayerName = LD_GetPjNameByID(MyGrpMembers[k])
		 MyPlayer = GetPlayerByName(MyPlayerName)
	     -- PrintInfo("[DEBUG]LD_CheckPjGroup[" .. MyPlayerName .. "][" .. tostring(MyGrpMembers[k]) .. "] Lead:" .. tostring(MyleaderGUID))
		 if MyPlayer == nil then 
		    if MyGrp:IsLeader(MyGrpMembers[k]) then
               AIO.Msg():Add("LDMsg", "LDGRM#" .. MyPlayerName .. "#" .. tostring(k) .. "#false#L#" ):Send(player)
			elseif MyGrp:IsAssistant( MyGrpMembers[k] ) then
               AIO.Msg():Add("LDMsg", "LDGRM#" .. MyPlayerName .. "#" .. tostring(k) .. "#false#A#" ):Send(player)
			else
               AIO.Msg():Add("LDMsg", "LDGRM#" .. MyPlayerName .. "#" .. tostring(k) .. "#false#N#" ):Send(player)
			end
		 else	
		    if MyGrp:IsLeader(MyGrpMembers[k]) then
               AIO.Msg():Add("LDMsg", "LDGRM#" .. MyPlayerName .. "#" .. tostring(k) .. "#true#L#" ):Send(player)
			elseif MyGrp:IsAssistant( MyGrpMembers[k] ) then
               AIO.Msg():Add("LDMsg", "LDGRM#" .. MyPlayerName .. "#" .. tostring(k) .. "#true#A#" ):Send(player)
			else
               AIO.Msg():Add("LDMsg", "LDGRM#" .. MyPlayerName .. "#" .. tostring(k) .. "#true#N#" ):Send(player)
			end
		 end
	  end
	  
      for LoopVar=NumGrPj+1,19 do
         AIO.Msg():Add("LDMsg", "LDGRM#VOID#" .. 
		    tostring(LoopVar) .. "#VOID#VOID" ):Send(player)
	  end
   end	  
   function SendMsgGroup ( player, msg )
      
      local MyGrp = player:GetGroup()
      if MyGrp == nil then
         AIO.Msg():Add("LDMsg", msg ):Send(player)
         return
      end
      local GrPj = MyGrp:GetMembers()
      local NumGrPj = MyGrp:GetMembersCount()
      for LoopVar=1,NumGrPj do
	     if GrPj[LoopVar] ~= nil then
            AIO.Msg():Add("LDMsg", msg ):Send(GrPj[LoopVar])
		 end	
      end
   end
   
   function LD_SetPjVar ( LD_Pj, LD_Index, LD_Value, LD_Type, LD_UpTime )
      local MySQLCommand= "INSERT INTO LD_SessionVars" .. 
	  " (LD_PJ, LD_INDEX, LD_VALUE, LD_TYPE, LD_DATEUP) VALUES('" .. LD_Pj .. 
	  "','" .. LD_Index .. "','" .. LD_Value .. "','" .. LD_Type .. "', " ..
	  LD_UpTime .. ") ON DUPLICATE KEY UPDATE LD_VALUE = '" .. LD_Value .. 
	  "', LD_DATEUP = " .. LD_UpTime .. ";"
	  -- PrintInfo("[INFO]LD_SetPjVar:[" .. MySQLCommand .. "]")
	  CharDBExecute(MySQLCommand)
   end
   
   function LD_GetPjVar ( LD_Pj, LD_Index, LD_Value, LD_Type )
      local MyVal = nil
      local MySQLCommand= "SELECT LD_VALUE FROM LD_SessionVars WHERE LD_PJ='" .. LD_Pj .. 
	  "' AND LD_INDEX='" .. LD_Index .. "' AND LD_TYPE='" .. LD_Type .. "';"
	  -- PrintInfo("[INFO]LD_GetPjVar:[" .. MySQLCommand .. "]")
	  local MyRes = CharDBQuery(MySQLCommand)
      if ( MyRes ~= nil ) then
         local NumRows = MyRes:GetRowCount()
         for i = 1,NumRows do
            MyVal = MyRes:GetString( 0 )
            MyRes:NextRow()
         end
      end
      return MyVal	  
   end
   
   function LD_SavePjPlayer ( LD_Pj, LD_Player )
      local MySQLCommand= "INSERT INTO LD_PlayerPJ (LD_PJ, LD_Player) VALUES('" .. LD_Pj .. "','" .. LD_Player .. "') ON DUPLICATE KEY UPDATE LD_PJ = '" .. LD_Pj .. "';"
	  CharDBExecute(MySQLCommand)
   end
   function LD_GetPjPlayer ( LD_Pj )
      local MySQLCommand= "SELECT LD_Player FROM LD_PlayerPJ WHERE LD_PJ='" .. LD_Pj .. "';"
	  local MyRes = CharDBQuery(MySQLCommand)
	  local MyVal = nil
      if ( MyRes ~= nil ) then
         local NumRows = MyRes:GetRowCount()
         for i = 1,NumRows do
            MyVal = MyRes:GetString( 0 )
            MyRes:NextRow()
         end
      end
	  return MyVal
   end
   
   function LD_GetPjVarDef ( LD_Pj, LD_Index, LD_Value, LD_Type, LD_Default )
      local MyVal = nil
      local MySQLCommand= "SELECT LD_VALUE FROM LD_SessionVars WHERE LD_PJ='" .. LD_Pj .. 
	  "' AND LD_INDEX='" .. LD_Index .. "' AND LD_TYPE='" .. LD_Type .. "';"
	  -- PrintInfo("[INFO]LD_GetPjVarDef:[" .. MySQLCommand .. "]")
	  local MyRes = CharDBQuery(MySQLCommand)
      if ( MyRes ~= nil ) then
         local NumRows = MyRes:GetRowCount()
         for i = 1,NumRows do
            MyVal = MyRes:GetString( 0 )
            MyRes:NextRow()
         end
      end
	  if MyVal == nil then
	     MyVal = LD_Default	
         MySQLCommand= "INSERT INTO LD_SessionVars (LD_PJ, LD_INDEX, LD_VALUE, LD_TYPE, LD_DATEUP) VALUES('" .. LD_Pj .. "','" .. LD_Index .. "','" .. MyVal .. "','" .. LD_Type .. 
		 "', 0) ON DUPLICATE KEY UPDATE LD_VALUE = '" .. MyVal .. "';"
		 -- PrintInfo("[INFO]LD_GetPjVarDef:[" .. MySQLCommand .. "]")
 	     CharDBExecute(MySQLCommand)		 
	  end
      return MyVal	  
   end

   function LD_GetAllType ( LD_Pj, LD_Type, MyPlayer )
      local MyRow   = nil
      local MyIndex = nil
      local MyValue = nil
      local MySQLCommand= "SELECT LD_INDEX, LD_VALUE FROM LD_SessionVars WHERE LD_PJ='" .. LD_Pj .. 
	  "' AND LD_TYPE='" .. LD_Type .. "';"

	  local MyRes = CharDBQuery(MySQLCommand)
      if ( MyRes ~= nil ) then
         local NumRows = MyRes:GetRowCount()
         for i = 1,NumRows do
            MyIndex = MyRes:GetString( 0 )
            MyValue = MyRes:GetString( 1 )
			MyRow[MyIndex] = MyValue
            MyRes:NextRow()
			AIO.Msg():Add("LDMsg","LDGET#".. MyIndex .. "#" .. MyValue .. "#" .. LD_Type):Send(MyPlayer)		
         end
      end
   end
   
   function LD_GetHistory ( LD_Pj )
      local MyRow   = nil
      local MyIndex = nil
      local MyValue = nil
      local MySQLCommand= "SELECT LD_INDEX, LD_VALUE FROM LD_SessionVars WHERE LD_PJ='" .. LD_Pj .. 
	  "' AND LD_TYPE='ROL';"

	  local MyRes = CharDBQuery(MySQLCommand)
      if ( MyRes ~= nil ) then
	     MyRow = {}
         local NumRows = MyRes:GetRowCount()
         for i = 1,NumRows do
            MyIndex = MyRes:GetString( 0 )
            MyValue = MyRes:GetString( 1 )
			MyRow[MyIndex] = MyValue
			-- PrintInfo("[INFO]LD_GetHistory:MYRow[" .. MyIndex .. "]=" .. MyRow[MyIndex] )
            MyRes:NextRow()
         end
      end
      return MyRow
   end

   function LD_GetAllPj ( LD_Pj , MyPlayer )
      local MyIndex = nil
      local MyValue = nil
	  local MyType  = nil
      local MySQLCommand= "SELECT LD_INDEX, LD_VALUE, LD_TYPE FROM LD_SessionVars WHERE LD_PJ='" .. LD_Pj .. "';"

	  local MyRes = CharDBQuery(MySQLCommand)
      if ( MyRes ~= nil ) then
         local NumRows = MyRes:GetRowCount()
         for i = 1,NumRows do
            MyIndex = MyRes:GetString( 0 )
            MyValue = MyRes:GetString( 1 )
            MyType  = MyRes:GetString( 2 )
			AIO.Msg():Add("LDMsg","LDGET#".. MyIndex .. "#" .. MyValue .. "#" .. MyType):Send(MyPlayer)
            MyRes:NextRow()
         end
      end
      return MyRow
   end
   
   function LD_GetSysVars ( MyPlayer)
	  local MyType  = nil
      local MyStype = nil
      local MyName = nil
      local MyValue = nil
      local MySQLCommand= "SELECT LD_TYPE, LD_SUBTYPE, LD_NAME, LD_VALUE FROM LD_SystemVars ORDER BY LD_TYPE, LD_SUBTYPE;"

	  local MyRes = CharDBQuery(MySQLCommand)
      if ( MyRes ~= nil ) then
         local NumRows = MyRes:GetRowCount()
         for i = 1,NumRows do
            MyType   = MyRes:GetString( 0 )
            MyStype  = MyRes:GetString( 1 )
            MyName   = MyRes:GetString( 2 )
            MyValue  = MyRes:GetString( 3 )
			AIO.Msg():Add("LDMsg","LDSYS#".. MyType .. "#" .. MyStype .. "#" .. MyName .. "#" .. MyValue):Send(MyPlayer)
			-- PrintInfo("LDSYS#".. MyType .. "#" .. MyStype .. "#" .. MyName .. "#" .. MyValue)
			MyRes:NextRow()
         end
      end
   end
   
   function LD_Dice (Min, Max)
      local r = math.random(Min,Max)
	  return r
   end
   
   function LD_Now()
      return (os.date("%Y") .. os.date("%m") .. os.date("%d") .. os.date("%H") .. os.date("%M") .. os.date("%S"))
   end
   
   function LD_SendSave ( Message, Sender, Recv )
      local TimeNow = LD_Now()
	  local MessID = 0
      local MySQLCommand1= "INSERT INTO LD_SysMessages (ID, LD_Message, LD_Sender, LD_Recv, LD_TimeStamp) VALUES (NULL, '" .. 
	     Message .. "', '" .. Sender:GetName() .. "', '" .. Recv:GetName() .. "', " .. TimeNow .. ");"
	  local MyRes = CharDBQuery(MySQLCommand1)
      if ( MyRes ~= nil ) then
         local NumRows = MyRes:GetRowCount()
	     PrintInfo("LD_SendSave: MessID = " .. tostring(MessID) .. "Rows:" .. NumRows)
         for i = 1,NumRows do
            MessID   = MyRes:GetString( 0 )
			MyRes:NextRow()
         end
      end
      AIO.Msg():Add("LDMsg",Message .. "#" .. Sender:GetName() .. "#" .. Recv:GetName() .. "#" .. tostring(TimeNow)):Send(Recv)
   end
   
   function LD_SendDel ( Message, MyIndex, Recv )
      if MyIndex == nil then
	     return
	  end
      local MySQLCommand= "DELETE FROM LD_SysMessages WHERE ID  = " .. tostring(MyIndex) .. ";"
	  CharDBExecute(MySQLCommand)	 
      AIO.Msg():Add("LDMsg",Message):Send(Recv)
   end
   
   PrintInfo("LD Libraries loaded") 
end
   