local AIO = AIO or require("AIO")
local SLD_LIB = SLD_LIB or require("SLD_LIB")

assert(not SLD_System, "SLD_System is already loaded. Possibly different versions!")
-- SLD_System main table
SLD_System =
{
    -- SLD_System flavour functions
    unpack = unpack,
}

--
-- Funciones de sistema
--

local SLD_System = SLD_System
if not AIO.AddAddon() then
   SLD_System.MultEner = 1
   SLD_System.MultMana = 1
   SLD_System.MultVida = 1
   function ProcessSysMsg(player, msg)
     local LD_Table = { strsplit ( "#", tostring(msg) )}
	  LD_Type    = LD_Table[1]
	  LD_SubType = LD_Table[2]
	  LD_SeqID   = LD_Table[3]
	  
   end
else
   function LD_GetAttack( player, msg ) -- AQUI ES DONDE METEMOS LAS FORMULAS DE ATAQUE
   end
   PrintInfo("LD_System Loaded ...")
end