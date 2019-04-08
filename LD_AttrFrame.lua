local AIO = AIO or require("AIO")
local SLD_LIB = SLD_LIB or require("SLD_LIB")

assert(not SLD_AttrFrame, "SLD_AttrFrame is already loaded. Possibly different versions!")
-- SLD_Frames main table
SLD_AttrFrame =
{
    -- SLD_Frames flavour functions
    unpack = unpack,
}

--
-- MARCO DONDE SE MUESTRAN ATRIBUTOS, HISTORIA Y CARACTERISTICAS DEL PERSONAJE
--

local SLD_AttrFrame = SLD_AttrFrame
if not AIO.AddAddon() then
LD_ATRFrame = CreateFrame ( "Frame", "LD_ATRFrame", UIParent )
local LD_ATRFrameBackground = LD_ATRFrame:CreateTexture("LD_ATRFrameBackground", "BACKGROUND")
LD_ATRFrameBackground:SetTexture(0, 0, 1, 0.1)
LD_ATRFrameBackground:SetAllPoints()
LD_ATRFrame:SetSize(400, 250)
LD_ATRFrame:SetPoint("BOTTOMRIGHT", 0, 220)
LD_ATRFrame:SetMovable(true)
LD_ATRFrame:EnableMouse(true)
LD_ATRFrame.MyTitle = LD_ATRFrame:CreateTitleRegion()
LD_ATRFrame.MyTitle:SetSize(400, 200) 
LD_ATRFrame.MyTitle:SetPoint("TOPLEFT", LD_ATRFrame, "TOPLEFT", 0, 0)   
LD_ATRFrame.MyHead = LD_ATRFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_ATRFrame.MyHead:SetTextColor(1, 1, 1, 1)
LD_ATRFrame.MyHead:SetPoint("TOPLEFT", LD_ATRFrame, "TOPLEFT", 0, 0)
LD_ATRFrame.MyHead:SetJustifyH("LEFT")
LD_ATRFrame.MyHead:SetText( UnitName("Player") .. ": Ficha de personaje")
LD_ATRFrame.MyDesc1 = LD_ATRFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_ATRFrame.MyDesc1:SetTextColor(0, 1, 0, 1)
LD_ATRFrame.MyDesc1:SetPoint("TOPLEFT", LD_ATRFrame, "TOPLEFT", 0, -15)
LD_ATRFrame.MyDesc1:SetJustifyH("RIGHT")
LD_ATRFrame.MyDesc1:SetText("Nombre:\nApellidos:\nEdad:\n")
LD_ATRFrame.MyDesc2 = LD_ATRFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_ATRFrame.MyDesc2:SetTextColor(1, 1, 0, 1)
LD_ATRFrame.MyDesc2:SetPoint("TOPLEFT", LD_ATRFrame, "TOPLEFT", 0, -55)
LD_ATRFrame.MyDesc2:SetJustifyH("RIGHT")
LD_ATRFrame.MyHist1 = LD_ATRFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_ATRFrame.MyHist1:SetTextColor(1, 1, 0, 1)
LD_ATRFrame.MyHist1:SetPoint("TOPLEFT", LD_ATRFrame, "TOPLEFT", 140, -35)
LD_ATRFrame.MyHist1:SetJustifyH("LEFT")
LD_ATRFrame.MyHist1:SetText("Reseña histórica:\n")
LD_ATRFrame.MyHist1B = LD_LabelTopS ( 140, -55, LD_ATRFrame, "")
LD_ATRFrame.MyHist1B:SetSize ( 250, 100)
LD_ATRFrame.MyHist1B:SetJustifyH("LEFT")
LD_ATRFrame.MyHist1B:SetJustifyV("TOP")
LD_ATRFrame.MyHist1B:SetWordWrap(true)
LD_ATRFrame.MyHist2 = LD_ATRFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_ATRFrame.MyHist2:SetTextColor(1, 1, 0, 1)
LD_ATRFrame.MyHist2:SetPoint("TOPLEFT", LD_ATRFrame, "TOPLEFT", 140, -150)
LD_ATRFrame.MyHist2:SetJustifyH("LEFT")
LD_ATRFrame.MyHist2:SetText("Aspecto físico:\n")
LD_ATRFrame.MyHist2B = LD_LabelTopS ( 140, -170, LD_ATRFrame, "")
LD_ATRFrame.MyHist2B:SetSize ( 250, 100)
LD_ATRFrame.MyHist2B:SetJustifyH("LEFT")
LD_ATRFrame.MyHist2B:SetJustifyV("TOP")
LD_ATRFrame.MyHist2B:SetWordWrap(true)
LD_ATRFrame:Hide()

LD_ATRFrame:SetScript ("OnShow", function(self)
   local MyName = "Nombre: "
   local MySName = "Apellidos: "
   local MyAge = "Edad: "

   

   self.MyDesc2:SetText("- ATRIBUTOS - \nFuerza: " .. tostring(SLD_Player.Atributos.FUERZA) ..
                                "\nConstitución: " .. tostring(SLD_Player.Atributos.CONSTI) ..
							        "\nDestreza: " .. tostring(SLD_Player.Atributos.DESTRE) ..
							        "\nAgilidad: " .. tostring(SLD_Player.Atributos.AGILID) ..
							   "\nEntendimiento: " .. tostring(SLD_Player.Atributos.INTELE) ..
							        "\nVoluntad: " .. tostring(SLD_Player.Atributos.SABIDU) ..
							       "\nPercepción:" .. tostring(SLD_Player.Atributos.PERCEP) ..
							 "\n\n\nP. atributo: " .. tostring(AIO_LD_CONFIG["ROL"]["PATTR"])) 
							
   LD_ATRFrame.MyDesc1:SetText( "Nombre: " .. SLD_Player.Nombre .. "\n" .. 
                                "Apellidos: " ..SLD_Player.Apelli .. "\n" .. 
								"Edad: " .. tostring(SLD_Player.Edad) )
   LD_ATRFrame.MyHist1B:SetText(SLD_Player.Hist1)
   LD_ATRFrame.MyHist2B:SetText(SLD_Player.Hist2)
   end)	
else
   PrintInfo("LD_AttrFrame Loaded ...")
end
