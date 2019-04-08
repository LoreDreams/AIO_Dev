local AIO = AIO or require("AIO")
local SLD_LIB = SLD_LIB or require("SLD_LIB")
local SLD_Player = SLD_Player or require("LD_Player")
local SLD_AttrFrame = SLD_AttrFrame or require("LD_AttrFrame")
local SLD_RolFrame = SLD_RolFrame or require("LD_RolFrame")
assert(not SLD_MainFrame, "SLD_MainFrame is already loaded. Possibly different versions!")
SLD_MainFrame =
{
    unpack = unpack,
}

--
-- MARCO PRINCIPAL DE ROL
--

if not AIO.AddAddon() then
LD_MainFrame = CreateFrame ( "Frame", "LD_MainFrame", UIParent )
local LD_MainFrameBackground = LD_MainFrame:CreateTexture("LD_MainFrameBackground", "BACKGROUND")
LD_MainFrameBackground:SetTexture(1, 1, 1, 0.1)
LD_MainFrameBackground:SetAllPoints()
LD_MainFrame:SetSize(400, 50)
LD_MainFrame:SetPoint("BOTTOMRIGHT")

-- MOSTRAR/ESCONDER MARCO ATRIBUTOS
LD_MainFrame.Button1 = LD_ButtonFrame ( 10, 10, LD_MainFrame, "Interface\\ICONS\\INV_Inscription_ArmorScroll01" )
LD_MainFrame.Button1:SetScript("OnEnter", 
   function(self) 
   self:SetAlpha(1) 
   GameTooltip:SetOwner(self, "ANCHOR_LEFT");
   GameTooltip:AddLine("|cff00ffff ATRIBUTOS / DESCRIPCION");
   GameTooltip:AddLine("|cffffffff Características innatas");
   GameTooltip:AddLine("|cffffffff Tambien puedes poner el aspecto físico");
   GameTooltip:AddLine("|cffffffff del personaje.");
   GameTooltip:Show();		 
end)
LD_MainFrame.Button1:SetScript("OnLeave", 
   function(self) 
   self:SetAlpha(0.5) 
   GameTooltip:Hide();
end)
LD_MainFrame.Button1:SetScript("OnClick", 
   function(self) 
   if LD_ATRFrame:IsVisible() then
      LD_ATRFrame:Hide()
   else
      LD_ATRFrame:Show()
   end
end)

-- MOSTRAR/ESCONDER MARCO DIALOGOS/EMOTES/DADOS
LD_MainFrame.Button2 = LD_ButtonFrame ( 40, 10, LD_MainFrame, "Interface\\ICONS\\spell_holy_silence" )
LD_MainFrame.Button2:SetScript("OnEnter", 
   function(self) 
   self:SetAlpha(1) 
   GameTooltip:SetOwner(self, "ANCHOR_LEFT");
   GameTooltip:AddLine("|cff00ffff DIALOGOS/EMOTES/DADOS");
   GameTooltip:AddLine("|cffffffff Todo lo necesario para interactuar con el mundo.")
   GameTooltip:Show();		
end)
LD_MainFrame.Button2:SetScript("OnLeave", 
   function(self) 
      self:SetAlpha(0.5) 
      GameTooltip:Hide()
end)
LD_MainFrame.Button2:SetScript("OnClick", 
   function(self) 
   if LD_ROLFrame:IsVisible() then
      LD_ROLFrame:Hide()
   else
      LD_ROLFrame:Show()
   end
end)

-- MOSTRAR/ESCONDER MARCO EQUIPO
-- LD_MainFrame.Button3 = LD_ButtonFrame ( 70, 10, LD_MainFrame, "Interface\\ICONS\\Ability_Warrior_SwordandBoard" )
--    LD_MainFrame.Button3:SetScript("OnEnter", 
--    function(self) 
--    self:SetAlpha(1) 
--    GameTooltip:SetOwner(self, "ANCHOR_LEFT");
--    GameTooltip:AddLine("|cff00ffff EQUIPO");
--    GameTooltip:AddLine("|cffffffff No vas a ir en pelotas ¿verdad?");
--    GameTooltip:Show();		 
-- end)
-- LD_MainFrame.Button3:SetScript("OnLeave", 
--    function(self) 
--    self:SetAlpha(0.5) 
--    GameTooltip:Hide();
-- end)
-- LD_MainFrame.Button3:SetScript("OnClick", 
--    function(self) 
--    SysPrint("No implementado todavia")
-- end)

-- MOSTRAR/ESCONDER MARCO MONTURAS
-- LD_MainFrame.Button4 = LD_ButtonFrame ( 100, 10, LD_MainFrame, "Interface\\ICONS\\Ability_Mount_RidingHorse" )
-- LD_MainFrame.Button4:SetScript("OnEnter", 
--    function(self) 
--    self:SetAlpha(1) 
--    GameTooltip:SetOwner(self, "ANCHOR_LEFT");
--    GameTooltip:AddLine("|cff00ffff MONTURAS");
--    GameTooltip:AddLine("|cffffffff ¿Crees que vas a ir a pie siempre?\n Estos fieles compañeros\n te llevarán por todo Azeroth.");
--    GameTooltip:Show();		 
-- end)
-- LD_MainFrame.Button4:SetScript("OnLeave", 
--    function(self) 
--    self:SetAlpha(0.5) 
--    GameTooltip:Hide();
-- end)
-- LD_MainFrame.Button4:SetScript("OnClick", 
--    function(self) 
--    SysPrint("No implementado todavia")
-- end)
-- 
-- MOSTRAR/ESCONDER MARCO DE MACROS
LD_MainFrame.Button5 = LD_ButtonFrame ( 130, 10, LD_MainFrame, "Interface\\ICONS\\Trade_Engineering" )
LD_MainFrame.Button5:SetScript("OnEnter", 
   function(self) 
   self:SetAlpha(1) 
   GameTooltip:SetOwner(self, "ANCHOR_LEFT");
   GameTooltip:AddLine("|cff00ffff ACCIONES");
   GameTooltip:AddLine("|cffffffff Aqui tienes acceso a las posibles acciones")
   GameTooltip:AddLine("|cffffffff o macros que tengas configuradas en tus barras");
   GameTooltip:Show();		 
end)
LD_MainFrame.Button5:SetScript("OnLeave", 
   function(self) 
   self:SetAlpha(0.5) 
   GameTooltip:Hide();
end)
LD_MainFrame.Button5:SetScript("OnClick", 
   function(self) 
   if LD_MacroFrame:IsVisible() then
      LD_MacroFrame:Hide()
   else
      LD_MacroFrame:Show()
   end
end)


-- MOSTRAR/ESCONDER MARCO DE HABILIDADES
-- LD_MainFrame.Button5 = LD_ButtonFrame ( 160, 10, LD_MainFrame, "Interface\\ICONS\\INV_Inscription_ArmorScroll03" )
-- LD_MainFrame.Button5:SetScript("OnEnter", 
--     function(self) 
--        self:SetAlpha(1) 
--        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
--        GameTooltip:AddLine("|cff00ffff HABILIDADES / HECHIZOS");
--        GameTooltip:AddLine("|cffffffff Características que el personaje aprende con el tiempo")
-- 	   GameTooltip:Show() 
-- end)
-- LD_MainFrame.Button5:SetScript("OnLeave", 
--   function(self) 
--   self:SetAlpha(0.5) 
--   GameTooltip:Hide();
-- end)
-- LD_MainFrame.Button5:SetScript("OnClick", 
--     function(self) 
--    if SLD_HabilityFrame:IsVisible() then
--       SLD_HabilityFrame:Hide()
--    else
--       SLD_HabilityFrame:Show()
--    end
-- end)
--
-- MINIBOTONES
--
-- ESCONDER/MOSTRAR CASCO
LD_MainFrame.Button6 = LD_ButtonFrameSmall ( 190, 25, LD_MainFrame, "Interface\\ICONS\\Inv_crown_15" )
LD_MainFrame.Button6:SetScript("OnEnter", 
   function(self) 
   self:SetAlpha(1) 
   GameTooltip:SetOwner(self, "ANCHOR_LEFT");
   GameTooltip:AddLine("|cff00ffff Esconder/Mostrar Casco");
   GameTooltip:Show();		 
end)
LD_MainFrame.Button6:SetScript("OnLeave", 
   function(self) 
   self:SetAlpha(0.5) 
   GameTooltip:Hide();
end)
LD_MainFrame.Button6:SetScript("OnClick", 
   function(self) 
   ShowHelm(not ShowingHelm())
end)

-- ESCONDER/MOSTRAR CAPA
LD_MainFrame.Button7 = LD_ButtonFrameSmall ( 190, 10, LD_MainFrame, "Interface\\ICONS\\inv_fabric_felrag" )
LD_MainFrame.Button7:SetScript("OnEnter", 
   function(self) 
   self:SetAlpha(1) 
   GameTooltip:SetOwner(self, "ANCHOR_LEFT");
   GameTooltip:AddLine("|cff00ffff Esconder/Mostrar Capa");
   GameTooltip:Show();		 
end)
LD_MainFrame.Button7:SetScript("OnLeave", 
   function(self) 
   self:SetAlpha(0.5) 
   GameTooltip:Hide();
end)
   LD_MainFrame.Button7:SetScript("OnClick", 
   function(self) 
   ShowCloak(not ShowingCloak())
end)

-- ESCONDER/MOSTRAR RAID
LD_MainFrame.Button8 = LD_ButtonFrameSmall(205,25,LD_MainFrame, "Interface\\ICONS\\inv_misc_groupneedmore")
LD_MainFrame.Button8:SetScript("OnEnter", 
   function(self) 
   self:SetAlpha(1) 
         GameTooltip:SetOwner(self, "ANCHOR_LEFT");
         GameTooltip:AddLine("|cff00ffff Esconder/Mostrar RAID");
         GameTooltip:Show();		 
end)
LD_MainFrame.Button8:SetScript("OnLeave", 
   function(self) 
   self:SetAlpha(0.5) 
   GameTooltip:Hide();
end)
LD_MainFrame.Button8:SetScript("OnClick", 
   function(self) 
   if LD_RaidFrame:IsVisible() then
      LD_RaidFrame:Hide()
   else
      LD_RaidFrame:Show()
   end   
end)

--
-- BARRAS DE VARIABLES DE ROL (VIDA/MANA/ENERGIA)
--
LD_StatusBars=CreateFrame ( "Frame", "LD_StatusBars", UIParent )
LD_StatusBars:SetSize(400, 80)
LD_StatusBars:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 0)
LD_StatusBars.MyTitle = LD_StatusBars:CreateTitleRegion()
LD_StatusBars.MyTitle:SetSize(400, 100) 
LD_StatusBars.MyTitle:SetPoint("TOPLEFT", LD_StatusBars, "TOPLEFT", 0, 0)
-- LD_StatusBars:EnableMouse(true)
local LD_StatusBarsBack = LD_StatusBars:CreateTexture("LD_StatusBarsBack", "BACKGROUND")
LD_StatusBarsBack:SetTexture(1, 1, 1, 0)
LD_StatusBarsBack:SetAllPoints()


LD_StatusBars.HPBar = CreateFrame("StatusBar", nil, LD_StatusBars)
LD_StatusBars.HPBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
LD_StatusBars.HPBar:GetStatusBarTexture():SetHorizTile(true)
LD_StatusBars.HPBar:SetWidth(500)
LD_StatusBars.HPBar:SetHeight(10)
LD_StatusBars.HPBar:SetPoint("TOPLEFT", LD_StatusBars, "TOPLEFT", 10, -10)
LD_StatusBars.HPBar:SetStatusBarColor(0,1,0)
LD_StatusBars.HPBar:SetMinMaxValues(0, 500)
LD_StatusBars.HPBar:SetValue(300)
LD_StatusBars.HPBar:SetAlpha(0.6)
LD_StatusBars.HPBar:EnableMouse(true)

LD_StatusBars.EPBar = CreateFrame("StatusBar", nil, LD_StatusBars)
LD_StatusBars.EPBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
LD_StatusBars.EPBar:GetStatusBarTexture():SetHorizTile(true)
LD_StatusBars.EPBar:SetWidth(500)
LD_StatusBars.EPBar:SetHeight(10)
LD_StatusBars.EPBar:SetPoint("TOPLEFT", LD_StatusBars, "TOPLEFT", 10, -25)
LD_StatusBars.EPBar:SetStatusBarColor(1,1,0)
LD_StatusBars.EPBar:SetMinMaxValues(0, 500)
LD_StatusBars.EPBar:SetValue(300)
LD_StatusBars.EPBar:SetAlpha(0.6)
LD_StatusBars.EPBar:EnableMouse(true)

LD_StatusBars.MPBar = CreateFrame("StatusBar", nil, LD_StatusBars)
LD_StatusBars.MPBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
LD_StatusBars.MPBar:GetStatusBarTexture():SetHorizTile(true)
LD_StatusBars.MPBar:SetWidth(500)
LD_StatusBars.MPBar:SetHeight(10)
LD_StatusBars.MPBar:SetPoint("TOPLEFT", LD_StatusBars, "TOPLEFT", 10, -40)
LD_StatusBars.MPBar:SetStatusBarColor(0,0,1)
LD_StatusBars.MPBar:SetMinMaxValues(0, 500)
LD_StatusBars.MPBar:SetValue(300)
LD_StatusBars.MPBar:SetAlpha(0.6)
LD_StatusBars.MPBar:EnableMouse(true)

LD_StatusBars:Hide()
function LD_RefreshBars()
   if SLD_Player.VIDA == -1 then 
      SLD_Player.VIDA = (SLD_Player.Atributos.CONSTI * 1.7 ) + (SLD_Player.Atributos.SABIDU * 1.3 )
      SLD_Player.VIDA = SLD_Player.VIDA * AIO_LD_CONFIG["SYS"]["SYS"]["SYS"]["MVHP"]
	  SLD_Player.TopVIDA = SLD_Player.VIDA
   end
   if SLD_Player.ENER == -1 then
      SLD_Player.ENER = (SLD_Player.Atributos.CONSTI * 1.4) + 
                        (SLD_Player.Atributos.AGILID * 1.2 ) +
                        (SLD_Player.Atributos.SABIDU * 1.2 ) +
                        (SLD_Player.Atributos.FUERZA * 1.2 ) 
      SLD_Player.ENER = SLD_Player.ENER * AIO_LD_CONFIG["SYS"]["SYS"]["SYS"]["MVEP"]
	  SLD_Player.TopENER = SLD_Player.ENER
   end

   if SLD_Player.MANA == -1 then
      SLD_Player.MANA = (SLD_Player.Atributos.SABIDU * 1.7 ) + 
                        (SLD_Player.Atributos.INTELE * 1.3 ) 
      SLD_Player.MANA = SLD_Player.MANA * AIO_LD_CONFIG["SYS"]["SYS"]["SYS"]["MVMP"]
	  SLD_Player.TopMANA = SLD_Player.MANA
   end
   
   LD_StatusBars.EPBar:SetValue(SLD_Player.ENER * 3)   
   LD_StatusBars.HPBar:SetValue(SLD_Player.VIDA * 3 )   
   LD_StatusBars.MPBar:SetValue(SLD_Player.MANA * 3)
   SLD_Player:SetPjVar ( "ATRIBUTO", "ENER", SLD_Player.ENER, true)
   SLD_Player:SetPjVar ( "ATRIBUTO", "VIDA", SLD_Player.VIDA, true)
   SLD_Player:SetPjVar ( "ATRIBUTO", "MANA", SLD_Player.MANA, true)
end

LD_StatusBars.HPBar:SetScript("OnEnter", 
function(self) 
   self:SetAlpha(1) 
   GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
   GameTooltip:AddLine("Barra de puntos de Vida (HP = " .. tostring(SLD_Player.VIDA) ..")")
   GameTooltip:Show();		 
end)
LD_StatusBars.HPBar:SetScript("OnLeave", 
function(self) 
   self:SetAlpha(0.6) 
   GameTooltip:Hide();
end)
LD_StatusBars.EPBar:SetScript("OnEnter", 
function(self) 
   self:SetAlpha(1) 
   GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
   GameTooltip:AddLine("Barra de puntos de Energía (EP = " .. tostring(SLD_Player.ENER) ..")")
   GameTooltip:Show();		 
end)
LD_StatusBars.EPBar:SetScript("OnLeave", 
function(self) 
   self:SetAlpha(0.6) 
   GameTooltip:Hide();
end)
LD_StatusBars.MPBar:SetScript("OnEnter", 
function(self) 
   self:SetAlpha(1) 
   GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
   GameTooltip:AddLine("Barra de puntos de Maná (MP = " .. tostring(SLD_Player.MANA) ..")")
   GameTooltip:Show();		 
end)
LD_StatusBars.MPBar:SetScript("OnLeave", 
function(self) 
   self:SetAlpha(0.6) 
   GameTooltip:Hide();
end)
LD_StatusBars:SetScript("OnShow",
function (self)
   if AIO_LD_CONFIG["ROL"]["APP"] == nil then
      self:Hide()
	  return
   end
   if AIO_LD_CONFIG["ROL"]["APP"] ~= "A" then
      self:Hide()
	  return
   end
   LD_RefreshBars()
end)

else
   PrintInfo("LD_MainFrame Loaded ...")
end