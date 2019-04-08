local AIO = AIO or require("AIO")
local SLD_LIB = SLD_LIB or require("SLD_LIB")
local SLD_MasterBar = SLD_MasterBar or require("SLD_MasterBar")

assert(not SLD_Events, "SLD_Events is already loaded. Possibly different versions!")
-- SLD_Events main table
SLD_Events =
{
    -- SLD_Events flavour functions
    unpack = unpack,
}

local SLD_Events = SLD_Events
if not AIO.AddAddon() then


function LD_OnEvent ( self, events, ...)
   local texte, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16 = ...;
   local Affiche=1;
   local coloredName = GetColoredName(event, texte, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
   local couleur = LD_ColorToHexa(ChatTypeInfo["EMOTE"].r,ChatTypeInfo["EMOTE"].g,ChatTypeInfo["EMOTE"].b);
   local MyNombre = "";
   texte = string.gsub(texte,"%<.-%>",couleur.."%1|r");
   texte = string.gsub(texte,"%*.-%*",couleur.."%1|r");
   DEFAULT_CHAT_FRAME:AddMessage("[" .. coloredName .. "] dice: " .. texte)
   return true
end

function LDDummy_OnEvent(self, event, ...)
   if event == "TARGET_UNIT" or 
   event == "PLAYER_TARGET_CHANGED"
   then
      if LD_AttrVendFrame:IsVisible() then 
         LD_AttrVendFrame:Hide()
      end
      if LD_AttrTutor:IsVisible() then 
         LD_AttrTutor:Hide()
      end
      if UnitName("target") == nil then
         return
      end	
      LDSendMsg("LDEVT#" .. UnitName("player") .. "#" .. UnitName("target") )
   elseif event == "PARTY_MEMBERS_CHANGED" then	 
      LDSendMsg("LDPMF#" .. UnitName("player"))
   elseif event == "PLAYER_ENTERING_WORLD" then	 
      LDSendMsg("LDPMF#" .. UnitName("player"))
   elseif event == "PLAYER_LEAVING_WORLD" then	 
      LDSendMsg("LDPMF#" .. UnitName("player"))
   elseif event == "CHANNEL_VOICE_UPDATE" or 
      event == "SPELL_UPDATE_USABLE" then
      if not SLD_Player.IsOnrol then
         return
      end
      if SLD_Player.InCombat then
         return
      end
      if SLD_Player.TopENER > SLD_Player.ENER then
         SLD_Player.ENER = SLD_Player.ENER + 0.5
         LD_RefreshBars()
         SLD_Player:SetPjVar ( "ATRIBUTO", "ENER", SLD_Player.ENER, true )
      end
      if SLD_Player.TopVIDA > SLD_Player.VIDA then
         SLD_Player.VIDA = SLD_Player.VIDA + 0.5
         SLD_Player:SetPjVar ( "ATRIBUTO", "VIDA", SLD_Player.VIDA, true )
         LD_RefreshBars()
      end
      if SLD_Player.TopMANA > SLD_Player.MANA then
         SLD_Player.MANA = SLD_Player.MANA + 0.5
         SLD_Player:SetPjVar ( "ATRIBUTO", "MANA", SLD_Player.MANA, true )
         LD_RefreshBars()
      end
   end
end
	  
--
-- COMANDOS DE CONSOLA
--
SLASH_MYHELP1 = "/loredreams"
SLASH_MYHELP2 = "/ldhelp"
SlashCmdList["MYHELP"] = function(msg)
   print ("\nLoreDreams, un server de rol Prêt-à-porter")
   print ("Ayuda de comandos")
   print ("/ldhelp /loredreams -> Muestra este mensaje")
   print ("/rolmode /modorol -> Cambia la Interface para facilitar el rol")
   print ("/pvemode /modopve -> Desactiva el modo rol y tienes la aburrida y clásica Interface de Wow")
   print ("/naked /desnudo -> Si no eres un pervertido y no te gusta ver a la gente desnuda usa este comando (varias veces hasta que se arregle)")
   print ("/talk /habla -> Este comando hará que el NPC que tengas seleccionado diga lo que pongas a continuación")
   print ("/nem /nmm -> Este comando hará que el NPC que tengas seleccionado diga lo que escribas a continuación como emoción")
   print ("/history /historia -> Permite modificar la historia de tu personaje, si la modificas no podras usar las facilidades de rol hasta que se vuelva a aprobar")
end 

SLASH_ROLMD1 = "/rolmode"
SLASH_ROLMD2 = "/modorol"
SlashCmdList["ROLMD"] = function(msg)
   LDSendMsg("ROLMD#" .. UnitName("player") .. "#WORLD")
end 

SLASH_PVEMD1 = "/pvemode"
SLASH_PVEMD2 = "/modopve"
SlashCmdList["PVEMD"] = function(msg)
   LDSendMsg("PVEMD#" .. UnitName("player") .. "#WORLD")
end 

SLASH_NAKED1 = "/naked"
SLASH_NAKED2 = "/desnudo"
SlashCmdList["NAKED"] = function(msg)
   LDSendMsg("SEENK#" .. UnitName("player") .. "#WORLD")
end 
SLASH_NPSAY1 = "/talk"
SLASH_NPSAY2 = "/habla"
SlashCmdList["NPSAY"] = function(msg)
   if UnitGUID("target") == nil or UnitIsPlayer("target") then
      print ("Debes seleccionar un NPC primero")
      return
   end
   MyUnitGUID = UnitGUID("target")
   LDSendMsg("NPSAY#" .. 
      string.sub(MyUnitGUID,3) .. 
      "#" .. string.sub(MyUnitGUID, -6, -1) .. 
      "#" .. string.sub(MyUnitGUID, -12, -7) .. 
      "#" .. msg) 
end 

SLASH_NPEMT1 = "/nem"
SLASH_NPEMT2 = "/nmm"
SlashCmdList["NPEMT"] = function(msg)
   if UnitGUID("target") == nil or UnitIsPlayer("target") then
      print ("Debes seleccionar un NPC primero")
      return
   end
   MyUnitGUID = UnitGUID("target")
   LDSendMsg("NPEMT#" .. 
      string.sub(MyUnitGUID,3) .. 
      "#" .. string.sub(MyUnitGUID, -6, -1) .. 
      "#" .. string.sub(MyUnitGUID, -12, -7) .. 
      "#" .. msg) 
end 

SLASH_HIST1 = "/history"
SLASH_HIST2 = "/historia"
SlashCmdList["HIST"] = function(msg)
   if LD_HistFrame:IsVisible() then
      LD_HistFrame:Hide()
   else
      LD_HistFrameLoad()
      LD_HistFrame:Show()
   end
end 
	
SLASH_APP1 = "/appro"
SLASH_APP2 = "/aprovacion"
SlashCmdList["APP"] = function(msg)
   if msg == "" then
      print ("Uso: /appro | /aprovacion [Personaje]")
      return
   end
   LDSendMsg("HISPJ#" .. msg )	   
end 

SLASH_HID1 = "/myaura"
SLASH_HID2 = "/myspell"
SlashCmdList["HID"] = function(msg)
   if msg == "" then
      print ("Uso: /myaura | /myspell [SpellID]")
      return
   end
   LDSendMsg("HIDPJ#" .. msg )	   
end 

SLASH_MFR1 = "/mfr"
SLASH_MFR2 = "/mmc"
SlashCmdList["MFR"] = function(msg)
   if not IsRaidLeader() then
      print ("Debes ser leader de banda para usar este comando")
      return
   end
   if LD_MasterFrame:IsVisible() then
      LD_MasterFrame:Hide()
   else
      LD_MasterFrame:Show()
   end
end 

else   
   PrintInfo("SLD Events Loaded ...")
end

