local AIO = AIO or require("AIO")
local SLD_LIB = SLD_LIB or require("SLD_LIB")

assert(not SLD_RaidFrame, "LD_RaidFrame is already loaded. Possibly different versions!")
-- SLD_Frames main table
SLD_RaidFrame =
{
    -- SLD_Frames flavour functions
    unpack = unpack,
}
local SLD_RaidFrame = SLD_RaidFrame
--
-- MARCO DE GRUPO/BANDA
--
if not AIO.AddAddon() then
LD_RaidFrame = CreateFrame ( "Frame", "LD_RaidFrame", UIParent )
local LD_RaidFrameBackground = LD_RaidFrame:CreateTexture("LD_RaidFrameBackground", "BACKGROUND")
LD_RaidFrameBackground:SetTexture(0.5, 0.5, 1, 0)
LD_RaidFrameBackground:SetAllPoints()
LD_RaidFrame:SetSize(150, 400)
LD_RaidFrame:SetPoint("TOPLEFT", 10, -100)
LD_RaidFrame.MyTitle = LD_RaidFrame:CreateTitleRegion()
LD_RaidFrame.MyTitle:SetSize(150, 400) 
LD_RaidFrame.MyTitle:SetPoint("TOPLEFT", LD_RaidFrame, "TOPLEFT", 0, 0)
LD_RaidFrame:SetMovable(true)
LD_RaidFrame:EnableMouse(true)

LD_RaidFrame.Titol = LD_LabelTopColors (10,-10,LD_RaidFrame,"- RAID -",1,1,1,1)
LD_RaidFrame.Slots = {}
local IndexY = -30
LD_RaidFrame.menu = {
   { text = "Select an Option", isTitle = true},
   { text = "Opcion 1", func = function() print("Opcion 1"); end },
   { text = "Opcion 2", func = function() print("Opcion 2"); end },
   { text = "Mas Opciones", hasArrow = true,
     menuList = {
         { text = "Opcion 3", func = function() print("Opcion 3"); end }
     } 
   }
 }
 
--
-- Creacion de los slots para alojar a los miembros de la RAID (limite:20)
--
for LoopVar=1,20 do
   LD_RaidFrame.Slots[LoopVar] = CreateFrame ( "Button", "LD_RaidFrame" .. tostring(LoopVar), UIParent )
   LD_RaidFrame.Slots[LoopVar]:SetPoint("TOPLEFT", LD_RaidFrame , "TOPLEFT", 30, IndexY )
   LD_RaidFrame.Slots[LoopVar]:SetSize(50, 20)
   LD_RaidFrame.Slots[LoopVar]:EnableMouse(true)
   LD_RaidFrame.Slots[LoopVar].Background=LD_RaidFrame.Slots[LoopVar]:CreateTexture("LD_SlotsBackground"..tostring(LoopVar), "BACKGROUND")
   LD_RaidFrame.Slots[LoopVar].Background:SetTexture(0.5, 0.5, 1, 0)
   LD_RaidFrame.Slots[LoopVar].Background:SetAllPoints()
   LD_RaidFrame.Slots[LoopVar].Txt = LD_LabelTopColors (30,IndexY,LD_RaidFrame,"",0,1,0,1)  -- Nombre de PJ
   LD_RaidFrame.Slots[LoopVar].Txt:SetJustifyH("LEFT")
   LD_RaidFrame.Slots[LoopVar].Fun = LD_LabelTopColors (0 ,IndexY,LD_RaidFrame,"",1,1,0,1)   -- Indica Leader/Ayudante etc..
   LD_RaidFrame.Slots[LoopVar].Ata = LD_LabelTopColors (80,IndexY,LD_RaidFrame,"",1,1,0,1)   -- Indica ataque
   LD_RaidFrame.Slots[LoopVar].Trn = LD_LabelTopColors (90,IndexY,LD_RaidFrame,"",1,1,0,1)   -- Indica turno
   
   -- LD_RaidFrame.Slots[LoopVar].MenuFrame = CreateFrame("Frame", "MF"..tostring(LoopVar), LD_RaidFrame.Slots[LoopVar], "UIDropDownMenuTemplate")

    -- Or make the menu appear at the frame:
    -- LD_RaidFrame.Slots[LoopVar].MenuFrame:SetPoint("LEFT", LD_RaidFrame.Slots[LoopVar], "LEFT")
    IndexY=IndexY-20
end


--
-- ToolTip de banda, donde se muestra información de descripcion física de los personajes
--
LD_ToolTip=CreateFrame( "Frame", "LD_ToolTip", UIParent )
LD_ToolTip:SetPoint("TOPRIGHT", 0,0)
LD_ToolTip:SetSize(200,300)
LD_ToolTip.TxtNameMarc = CreateFrame( "Frame", "LD_ToolTip_TxtNameMarc", LD_ToolTip )
LD_ToolTip.TxtNameMarc:SetSize(200,30)
LD_ToolTip.TxtNameMarc:SetPoint("TOPRIGHT", LD_ToolTip, "TOPRIGHT", 0,0)
LD_ToolTip.TxtNameMarc:SetBackdrop({
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	edgeSize = 14,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
})
LD_ToolTip.TxtName=LD_ToolTip:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_ToolTip.TxtName:SetTextColor(1, 0.5, 0, 1)
LD_ToolTip.TxtName:SetPoint("TOPLEFT", 5 , 0)
LD_ToolTip.TxtName:SetSize(190, 30)
LD_ToolTip.TxtName:SetJustifyH("LEFT")
LD_ToolTip.TxtName:SetText("")
LD_ToolTip.TxtDesc=LD_ToolTip:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_ToolTip.TxtDesc:SetTextColor(0.7, 0.7, 0.7, 1)
LD_ToolTip.TxtDesc:SetPoint("TOPLEFT", LD_ToolTip, "TOPLEFT", 5 , -50)
LD_ToolTip.TxtDesc:SetSize(190, 200)
LD_ToolTip.TxtDesc:SetJustifyH("LEFT")
LD_ToolTip.TxtDesc:SetJustifyV("TOP")
LD_ToolTip.TxtDesc:SetWordWrap(true)
LD_ToolTip.TxtDesc:SetText("")
LD_ToolTip:Hide()

--
-- Frame de enemigos
--
LD_FoeFrame = CreateFrame ( "Frame", "LD_FoeFrame", UIParent )
local LD_FoeFrameBackground = LD_FoeFrame:CreateTexture("LD_FoeFrameBackground", "BACKGROUND")
LD_FoeFrameBackground:SetTexture(1, 0.5, 0.5, 0.1)
LD_FoeFrameBackground:SetAllPoints()
LD_FoeFrame:SetSize(150, 400)
LD_FoeFrame:SetPoint("TOPLEFT", 170, -100)
LD_FoeFrame.MyTitle = LD_FoeFrame:CreateTitleRegion()
LD_FoeFrame.MyTitle:SetSize(150, 400) 
LD_FoeFrame.MyTitle:SetPoint("TOPLEFT", LD_FoeFrame, "TOPLEFT", 0, 0)
LD_FoeFrame:SetMovable(true)
LD_FoeFrame:EnableMouse(true)

LD_FoeFrame.Titol = LD_LabelTopColors (10,-10,LD_FoeFrame,"- ENEMIGOS -",1,1,1,1)
LD_FoeFrame.Slots = {}
local IndexY = -30
for LoopVar=1,20 do
   LD_FoeFrame.Slots[LoopVar] = CreateFrame ( "Button", "LD_FoeFrame" .. tostring(LoopVar), UIParent )
   LD_FoeFrame.Slots[LoopVar]:SetPoint("TOPLEFT", LD_FoeFrame , "TOPLEFT", 30, IndexY )
   LD_FoeFrame.Slots[LoopVar]:SetSize(100, 20)
   LD_FoeFrame.Slots[LoopVar]:EnableMouse(true)
   LD_FoeFrame.Slots[LoopVar].Background=LD_FoeFrame.Slots[LoopVar]:CreateTexture("LD_SlotsBackground"..tostring(LoopVar), "BACKGROUND")
   LD_FoeFrame.Slots[LoopVar].Background:SetTexture(0.5, 0.5, 1, 0)
   LD_FoeFrame.Slots[LoopVar].Background:SetAllPoints()
   LD_FoeFrame.Slots[LoopVar].Txt = LD_LabelTopColors (30,IndexY,LD_FoeFrame,"",0,1,0,1)
   LD_FoeFrame.Slots[LoopVar].Fun = LD_LabelTopColors (0,IndexY,LD_FoeFrame,"",1,1,0,1)
   IndexY=IndexY-20
end
LD_FoeFrame:Hide()

--
-- ABRIR COMBATE
--
function OpenCombat()
   LDSendMsg("ROLMD#" .. UnitName("player") .. "#WORLD")
   LD_ROLFrame.AlertZone.TxtAlert:SetText("EN ENTRENAMIENTO")
   LD_ROLFrame:Show()
   -- LD_FoeFrame:Show()
   SLD_HabilityFrame:Show()
   SLD_Player.InCombat = true
end

--
-- CERRAR COMBATE
--
function CloseCombat()
   LD_ROLFrame.AlertZone.TxtAlert:SetText("")
   LD_ROLFrame:Hide()
   -- LD_FoeFrame:Hide()
   SLD_HabilityFrame:Hide()
   SLD_Player.InCombat = false
end

--
-- Borra los slots de la RAID
--
function LD_ClearRAID ()
   for i=1,20 do
      LD_RaidFrame.Slots[i]:SetText("")
   end	
end   

--
-- Actualiza los datos de un PJ en el marco de RAID
--
function LD_FillRAIDSlot ( MyPj, MyIndex, MyConn, MyFun )
  
   if MyPj == "VOID" then
      LD_RaidFrame.Slots[MyIndex].Txt:SetText("")
	  LD_RaidFrame.Slots[MyIndex].Fun:SetText("")
   else
      if MyFun == "L" then 
         LD_RaidFrame.Slots[MyIndex].Fun:SetText("(L)")
      elseif MyFun == "A" then   
         LD_RaidFrame.Slots[MyIndex].Fun:SetText("(A)")
      else
         LD_RaidFrame.Slots[MyIndex].Fun:SetText("")
      end  
      local menu = {
                  { text = AIO_LD_CONFIG["DATA"][MyPj]["ROL"]["NOMBRE"], isTitle = true},
                  { text = "Variables vitales", hasArrow = true, 
				     func = function() LDSendMsg( "SHOWVITALVARS#" .. MyPj .. "#" .. UnitName("player") .. "#SYS" ); end,
                     menuList = {
					    { text = "Valor Máximo", hasArrow = true, menuList = {
                              { text = "Valor Máximo", isTitle = true},
                              { text = "Energia", func = function() 
                                 LDSendMsg("SETFULLENER#" .. MyPj .. "#SYS#")
						      end},
                              { text = "Maná", func = function() 
                                 LDSendMsg("SETFULLMANA#" .. MyPj .. "#SYS#")
						      end},
                              { text = "Vida", func = function()
                                 LDSendMsg("SETFULLVIDA#" .. MyPj .. "#SYS#")
						      end},
						   },
						},
					    { text = "Otros Valores", hasArrow = true, menuList = {
                              { text = "Otros valores", isTitle = true},
                              { text = "Energia", func = function() 
                                 LD_DataEntryFrame.Prompt:SetText("Energia, introducir valor absoluto:")
								 LD_DataEntryFrame.Data:SetText("")
								 LD_DataEntryFrame.OkButton:SetScript("OnClick" , 
								    function(self)
									   LDSendMsg("MODLDPLAYER#" .. MyPj .. "#SLD_Player.ENER = " .. LD_DataEntryFrame.Data:GetText() .. ";\n LD_RefreshBars();\nprint(\"Tu nivel de energia se ha establecido en " .. LD_DataEntryFrame.Data:GetText() .." EP\");#")
									   LD_DataEntryFrame:Hide()
									   end)
								 LD_DataEntryFrame:Show()
						      end},
                              { text = "Maná", func = function() 
                                 LD_DataEntryFrame.Prompt:SetText("Maná, introducir valor absoluto:")
								 LD_DataEntryFrame.Data:SetText("")
								 LD_DataEntryFrame.OkButton:SetScript("OnClick" , 
								    function(self)
									   LDSendMsg("MODLDPLAYER#" .. MyPj .. "#SLD_Player.MANA = " .. LD_DataEntryFrame.Data:GetText() .. ";\n LD_RefreshBars();\nprint(\"Tu nivel de maná se ha establecido en " .. LD_DataEntryFrame.Data:GetText() .." MP\");#")
									   LD_DataEntryFrame:Hide()
									   end)
								 LD_DataEntryFrame:Show()
						      end},
                              { text = "Vida", func = function()
                                 LD_DataEntryFrame.Prompt:SetText("Vida, introducir valor absoluto:")
								 LD_DataEntryFrame.Data:SetText("")
								 LD_DataEntryFrame.OkButton:SetScript("OnClick" , 
								    function(self)
									   LDSendMsg("MODLDPLAYER#" .. MyPj .. "#SLD_Player.VIDA = " .. LD_DataEntryFrame.Data:GetText() .. ";\n LD_RefreshBars();\nprint(\"Tu nivel de salud se ha establecido en " .. LD_DataEntryFrame.Data:GetText() .." HP\");#")
									   LD_DataEntryFrame:Hide()
									   end)
								 LD_DataEntryFrame:Show()
						      end},
						   },
						},
                     } 
                  },
                  { text = "Bloquear/Activar Habilidades", func = function() 
				     -- LDSendMsg("SETPJAURA#" .. MyPj .. "#468#")
				     LDSendMsg("SETBLOCKHABILITY#" .. MyPj .. "#468#")
				  end },
                  { text = "Estados", hasArrow = true, menuList = 
				      {
                        { text = "Añadir", func = function()
						      end},				     
                        { text = "Eliminar", func = function()
						      end},				     
                     },			
				  }
               }
      local menuFrame = CreateFrame("Frame","RFM" .. tostring(MyIndex),LD_RaidFrame.Slots[MyIndex],"UIDropDownMenuTemplate")
            menuFrame:SetPoint("Center", LD_RaidFrame.Slots[MyIndex], "Center")
 		menuFrame:Hide()
			
      LD_RaidFrame.Slots[MyIndex].Txt:SetText(MyPj)
      LD_RaidFrame.Slots[MyIndex]:SetScript("OnEnter" , 
         function (self)
            if AIO_LD_CONFIG["DATA"][MyPj]["ROL"] == nil then
               return
            end	 
            self.Background:SetTexture(0.5, 0.5, 1, 0.7)
            LD_ToolTip.TxtName:SetText(AIO_LD_CONFIG["DATA"][MyPj]["ROL"]["NOMBRE"] .. 
               " " .. AIO_LD_CONFIG["DATA"][MyPj]["ROL"]["APELLIDO"])
            if AIO_LD_CONFIG["DATA"][MyPj]["ROL"]["APP"] == "A" then
               LD_ToolTip.TxtDesc:SetText(AIO_LD_CONFIG["DATA"][MyPj]["ROL"]["HIST2"])
            else		 
               LD_ToolTip.TxtDesc:SetText("(Historia por aprobar)")
            end	 
            LD_ToolTip:Show()		 
         end)		 
      LD_RaidFrame.Slots[MyIndex]:SetScript("OnLeave" , 
         function (self)
            self:SetAlpha(1)
            self.Background:SetTexture(0.5, 0.5, 1, 0)
            LD_ToolTip:Hide()		 
         end)	
      if (IsRaidLeader() and MyConn ~= "false" ) then
      LD_RaidFrame.Slots[MyIndex]:SetScript("OnMouseDown", 
	     function(self, button)
            if button == "RightButton" then
               EasyMenu(menu, menuFrame, menuFrame, 0 , 0, "MENU")
            end
         end)
      end

   end
   if MyConn == "false" then
      LD_RaidFrame.Slots[MyIndex].Txt:SetTextColor(0.5,0.5,0.5,0.5)
   else	
      LD_RaidFrame.Slots[MyIndex].Txt:SetTextColor(0,1,0,1)
   end
   if not LD_RaidFrame:IsVisible() then
      LD_RaidFrame:Show()
   end   
end

LD_RaidFrame:Hide()

else
   PrintInfo("LD_RaidFrame Loaded ...")
end