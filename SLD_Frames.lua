local AIO = AIO or require("AIO")
local SLD_LIB = SLD_LIB or require("SLD_LIB")
local SLD_Frames2 = SLD_LIB or require("SLD_Frames2")

assert(not SLD_Frames, "SLD_Frames is already loaded. Possibly different versions!")
-- SLD_Frames main table
SLD_Frames =
{
    -- SLD_Frames flavour functions
    unpack = unpack,
}

--
-- FRAMES DIVERSAS
--

local SLD_Frames = SLD_Frames

if not AIO.AddAddon() then

--
-- FRAME DE ENTRADA DE DATOS GENERICO
--
LD_DataEntryFrame = CreateFrame ( "Frame", "LD_DataEntryFrame", UIParent )
local LD_DataEntryFrameBackground = LD_DataEntryFrame:CreateTexture("LD_DataEntryFrame", "BACKGROUND")
LD_DataEntryFrameBackground:SetTexture(0, 1, 1, 0.2)
LD_DataEntryFrameBackground:SetAllPoints()
LD_DataEntryFrame:SetSize(300, 100)
LD_DataEntryFrame:SetPoint("CENTER")
LD_DataEntryFrame:SetMovable(true)
LD_DataEntryFrame:EnableMouse(true)
LD_DataEntryFrame:SetBackdrop({
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	edgeSize = 14,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
})
LD_DataEntryFrame.Prompt = LD_LabelTop( 15, -5, LD_DataEntryFrame, "Entrada de datos, texto explicativo, aclaratorio de lo que se quiere y como se quiere")
LD_DataEntryFrame.Prompt:SetSize (270, 30)
LD_DataEntryFrame.Prompt:SetWordWrap(true) 
LD_DataEntryFrame.Prompt:SetJustifyH("LEFT")	
LD_DataEntryFrame.Data = LD_EditFrame ( LD_DataEntryFrame, 15, -40, 270, 20, 35, "Sitio para editar datos", false)
LD_DataEntryFrame.OkButton = CreateFrame ( "Button", "LD_DataEntryFrame.OkButton", LD_DataEntryFrame, "UIPanelButtonTemplate" )
LD_DataEntryFrame.OkButton:SetPoint("BOTTOMLEFT", 15, 5, LD_DataEntryFrame)
LD_DataEntryFrame.OkButton:SetSize (50, 20)
LD_DataEntryFrame.OkButton:SetText ("Ok")
LD_DataEntryFrame.CancelButton = CreateFrame ( "Button", "LD_DataEntryFrame.Cancel", LD_DataEntryFrame, "UIPanelButtonTemplate" )
LD_DataEntryFrame.CancelButton:SetPoint("BOTTOMRIGHT", -15, 5, LD_DataEntryFrame)
LD_DataEntryFrame.CancelButton:SetSize (50, 20)
LD_DataEntryFrame.CancelButton:SetText ("Cancel")
LD_DataEntryFrame.CancelButton:SetScript ("Onclick", function(self)
   LD_DataEntryFrame:Hide()
   end)
LD_DataEntryFrame:SetScript ("OnShow", function(self)
   self.Data:SetFocus()
   end)
LD_DataEntryFrame:Hide()

--
-- FRAME DE VENDEDORES DE ATRIBUTO
--   
LD_ATRVendors = { 
    ["Zipeau Magicfingers"] = { "DESTRE", "Destreza", "Como mi nombre indica soy el rey de las carteras flojas, el maestro en construir con palillos, el fiera que deja tuerta a una mosca. Lo has adivinado, la Destreza es lo mio, y estoy dispuesto a enseñarte, por un módico precio, claro." },
   ["Oraculus Coscotodo"] = { "PERCEP", "Percepción", "No te equivoques y no me intentes timar. A mi no se me escapa nada. Por mucho que te quieras esconder, o me quieras colar gato por liebre, te voy a pillar. Si Percepcion es lo que quieres y tienes pasta, habla conmigo"},
   ["Muelleflojo Parcour"] = { "AGILID", "Agilidad", "¿Subir a un arbol con los brazos cruzados? ¿Saltar de la alcoba de una doncella a la calle?. No hay reto que se me resista. Agilidad es lo que me sobra y es tuya siempre que pagues"},
   ["Seneca Kerabiadas"] = { "SABIDU", "Voluntad/Espíritu", "Todo el mundo sabe que lo que importa es el espíritu y no la carne mortal. Aquellos que eligen sábiamente cultivarán el arte del espíritu y la sabiduria. Claro que no vivo del aire, asi que pagame y tendras mis lecciones"},
   ["Martinez Gordobiceps"] = { "FUERZA", "Fuerza", "¿Sabes que el animal mas fuerte en relacion a su tamaño es la hormiga? Asi que no te dejes engañar por mi tamaño, puedo arrancarte la cabeza con solo dos dedos. ¿Te gustaria ser tan fuerte? Mis clases valen lo que cuestan"},
   ["Poveda Cuatroojos"] = { "INTELE", "Entendimiento", "Los niños en el cole se burlaban de mi y me llamaban empollon. Pero mírame ahora, soy rico gracias a mis inventos. Hay que tener Intelecto en esta vida. Asi que si quieres triunfar muestrame el color de tu dinero"},
   ["Poveda Empollonum"] = { "INTELE", "Entendimiento", "Los niños en el cole se burlaban de mi y me llamaban empollon. Pero mírame ahora, soy rico gracias a mis inventos. Hay que tener Entendimiento en esta vida. Asi que si quieres triunfar muestrame el color de tu dinero"},
   ["Noremasti Todoinmune"] = { "CONSTI", "Constitucion", "Cada dia me entreno tirándome rocas a la cabeza. No, no estoy loco, sencillamente nada me afecta, resisto todo tipo de ataques. Si quieres tener buena Constitucion, pagame al contado y serás casi como yo" }
}

				
				
LD_AttrVendFrame = CreateFrame ( "Frame", "LD_AttrVendFrame", UIParent )
-- local LD_AttrVendFrameBackground = LD_AttrVendFrame:CreateTexture("LD_AttrVendFrameBackground", "BACKGROUND")
-- LD_AttrVendFrameBackground:SetTexture(1, 1, 0.5, 1)
-- LD_AttrVendFrameBackground:SetAllPoints()
LD_AttrVendFrame:SetSize(250, 200)
LD_AttrVendFrame:SetPoint("TOPLEFT", 10, -130)
LD_AttrVendFrame:SetBackdrop({
	-- bgFile = [[Interface\Buttons\WHITE8x8]],
	bgFile = [[Interface\PaperDollInfoFrame\UI-GearManager-Title-Background]],
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	edgeSize = 14,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
})
LD_AttrVendFrame.AttrDesc = ""
LD_AttrVendFrame.AttrBBDD = ""

LD_AttrVendFrame.MyVend = LD_AttrVendFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_AttrVendFrame.MyVend:SetFont("Fonts\\MORPHEUS.TTF", 15)
LD_AttrVendFrame.MyVend:SetTextColor(1, 1, 0, 1)
LD_AttrVendFrame.MyVend:SetPoint("TOP", LD_AttrVendFrame, "TOP", 0, -10)
LD_AttrVendFrame.MyVend:SetText("Goblin")

LD_AttrVendFrame.MyVendTx = LD_AttrVendFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_AttrVendFrame.MyVendTx:SetTextColor(0, 1, 0, 1)
LD_AttrVendFrame.MyVendTx:SetPoint("TOP", LD_AttrVendFrame, "TOP", 0, -30)
LD_AttrVendFrame.MyVendTx:SetJustifyH("LEFT")	
LD_AttrVendFrame.MyVendTx:SetText("Maestro de atributo\n________________________")

LD_AttrVendFrame.MyVendTxl = LD_AttrVendFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_AttrVendFrame.MyVendTxl:SetFont("Fonts\\ARIALN.TTF", 14)
LD_AttrVendFrame.MyVendTxl:SetTextColor(0.8, 0.8, 0, 1)
LD_AttrVendFrame.MyVendTxl:SetPoint("TOP", LD_AttrVendFrame, "TOP", 0, -50)
LD_AttrVendFrame.MyVendTxl:SetSize (230, 120)
LD_AttrVendFrame.MyVendTxl:SetWordWrap(true) 
LD_AttrVendFrame.MyVendTxl:SetJustifyH("LEFT")	
LD_AttrVendFrame.MyVendTxl:SetText("...")

LD_AttrVendFrame.Button = CreateFrame ( "Button","TIRAMILLAS",LD_AttrVendFrame,"UIPanelButtonTemplate") 
LD_AttrVendFrame.Button:SetSize(120,25)
LD_AttrVendFrame.Button:SetPoint("BOTTOMLEFT", LD_AttrVendFrame, "BOTTOMLEFT", 50, 10)
LD_AttrVendFrame.Button:SetText("Comprar")
LD_AttrVendFrame.Button:SetScript ("OnClick", function (self)
   StaticPopupDialogs["CONFIRM_ATTR"].text = "Aumentar 1 punto de " .. LD_AttrVendFrame.AttrDesc .. "\n¿Estas seguro?"
   StaticPopup_Show("CONFIRM_ATTR")
end)
LD_AttrVendFrame:Hide()	

else
   PrintInfo("SLD Frames Loaded ...")
end
