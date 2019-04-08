local AIO = AIO or require("AIO")
local SLD_LIB = SLD_LIB or require("SLD_LIB")
local SLD_Frames = SLD_Frames or require("SLD_Frames")

assert(not SLD_Frames2, "SLD_Frames2 is already loaded. Possibly different versions!")
-- SLD_Frames main table
SLD_Frames2 =
{
    -- SLD_Frames flavour functions
    unpack = unpack,
}



local SLD_Frames2 = SLD_Frames2
if not AIO.AddAddon() then
ESTADO_GENERAL = "El Reino oficialmente ya no existe, solo quedan los restos de los restos. Varios grupos de supervivientes sobreviven día a día alejándose y huyendo de los focos de no-muertos, la mayoría de estos grupos desconoce el estado de los demás y su localización.\n\nEl mayor de los grupos, es el compuesto por lo que queda del ejército de Lordaeron, que tras la muerte de Garithos se refugiaron en el monasterio de Tirisfal. Sin un sucesor claro de Garithos, pues todos los oficiales de alto rango murieron junto a él en Ciudad Capital.\n\nCuando Alexandros Mograine llego al monasterio la tensión entre los varios cabecillas, que habían surgido con intención de tomar las riendas, estaba en el punto más alto. No tardó en ser él el que tomaría, las riendas de ese grupo de supervivientes.\n\nAlexandros consiguió varias pequeñas victorias sobre una plaga en apariencia dividida, llegando a atraer a más grupos a su causa, y consiguió tiempo para reorganizar las filas, incluso mantener una zona relativamente segura en las inmediaciones del Monasterio de Tirisfal." 
HISTORIA_TIRISFAL = "El monasterio de Tirisfal se ha convertido en un lugar de refugio a lo largo de la tercera guerra, siendo uno de los lugares más sagrados en el reino de Lordaeron. Los propios sacerdotes se dedicaron a acoger a los refugiados y con el tiempo estos se organizaron en una milicia que consiguió repeler unos pocos y pobres intentos por parte de la plaga de tomar el monasterio.\n\nCuatro meses antes de que empiece nuestra historia, Garithos y lo que quedaba del ejercito de Lordaeron fue diezmado en Ciudad Capital, haciendo que en los días siguientes llegaran soldados al monasterio buscando refugio, la llegada de soldados veteranos al monasterio no trajo a sus habitantes la tranquilidad esperada de ser más y estar mejor armados, pues temían que los soldados atrajeran la atención de los no-muertos.\n\nLos soldados no tardaron en tratar de tomar el mando del lugar con la reticencia de los sacerdotes y líderes civiles. La relativa tranquilidad y estabilidad que había tenido el monasterio durante la guerra toco a su fin, las disputas de poder llevaron a la pérdida de vidas y recursos a manos de unos no-muertos que antes eran rechazados y a su vez estas pérdidas recrudecían las peleas de los cabecillas.\n\nHace dos semanas Alexandros Mograine acabo con las disputas, apareció con un pequeño grupo de paladines y soldados. En pocos días consiguió que la mayoría de los cabecillas lo reconocieran a él como líder de lo que quedaba de Lordaeron, pero unirlos no bastaba, Alexandros comenzó a reorganizar todo el lugar, las ordenes llegaban a todos los supervivientes que se congregaban en el monasterio, nuevos puestos, nuevas tareas..." 
EXPLICACION_ATRIBUTOS = "FUERZA: La capacidad de mover objetos por peso, usada principalmente en habilidades que impliquen el uso de objetos pesados.\nSe usa este atributo para todo aquello que requiere musculo. Bien sea levantar pesos, golpear. Incide mucho en la potencia física. Típicas habilidades en las que este atributo influye de forma notoria: Atletismo, mazas, nadar...\n\nCONSTITUCION: Atributo principal de la vida de un personaje y también del aguante del mismo.\nSería la cualidad de cada personaje a aguantar adversidades físicas. Resistencia al frio, calor, golpes, etc. También hace referencia a cierta resistencia a enfermedades. En definitiva la tendencia a la buena salud en general.\n\nDESTREZA: El atributo ligado a todas las habilidades activas en mayor o menor medida.\nHay personas a las que, por naturaleza, se les da bien el trabajo manual o bien tienen buena puntería. Este atributo es el que aleja a nuestro personaje de la patanería y la torpeza.\n\nAGILIDAD: Si tu personaje se mueve, este atributo será necesario.Saltar, correr, esquivar y sobre todo rapidez, es la agilidad la que mide la celeridad de acción y reacción del personaje.\n\nENTENDIMIENTO: Atributo ligado a las habilidades más intelectuales y mágicas.\nMide la lucidez mental y lógica del individuo, su capacidad de comprensión, asimilación de conocimientos y concentración. Especialmente útil en intelectuales, estudiosos, magos, etc. Aunque también es necesario para estrategas, timadores, negociantes, comerciantes etc.\n\nVOLUNTAD: La fuerza interior, por así decirlo, aunque esta directamente ligado con el mana y la magia, la voluntad también influye sobre el límite del cansancio y vida, y en habilidades que impliquen resistencia.\nEste atributo conecta al individuo con su parte más espiritual, pues es el que nos hace más afines a los fenómenos paranormales. Es ese tipo de fortaleza interior a la que es difícil dar una explicación racional pero que en Azeroth existe de una manera manifiesta.  Permite al personaje salirse de los límites de sus mismas capacidades físicas. No solo es necesario en magos, brujos y sacerdotes, también es ese tipo de energía que hace crecer la determinación en personajes decididos a hacer lo que haga falta.\n\nPERCEPCION: La capacidad del personaje para ver, oír, notar o sentir lo que tiene alrededor tanto de manera no-mágica como mágica. "

LD_HistFrame=CreateFrame ( "Frame", "LD_HistFrame", UIParent )
LD_HistFrame:SetSize(400, 500)
LD_HistFrame:SetPoint("CENTER", 0, 150)
LD_HistFrame:SetBackdrop({
	--bgFile = [[Interface\Buttons\WHITE8x8]],
	bgFile = [[Interface\DialogFrame\UI-DialogBox-Gold-Background]],
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	edgeSize = 14,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
})
LD_HistFrame:SetMovable(true)
LD_HistFrame:EnableMouse(true)
LD_HistFrame.MyTitle = LD_HistFrame:CreateTitleRegion()
LD_HistFrame.MyTitle:SetSize(400, 300) 
LD_HistFrame.MyTitle:SetPoint("TOPLEFT", LD_HistFrame, "TOPLEFT", 0, 0)

LD_HistFrame.MyTit = LD_HistFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_HistFrame.MyTit:SetFont("Fonts\\MORPHEUS.TTF", 15)
LD_HistFrame.MyTit:SetTextColor(0.3, 1, 0.3, 1)
LD_HistFrame.MyTit:SetPoint("TOP", LD_HistFrame, "TOP", 0, -10)
LD_HistFrame.MyTit:SetText("Tu ficha de rol")

LD_HistFrame.MyTxt = LD_HistFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_HistFrame.MyTxt:SetTextColor(0.3, 1, 0.3, 1)
LD_HistFrame.MyTxt:SetPoint("TOPLEFT", LD_HistFrame, "TOPLEFT", 10, -27)
LD_HistFrame.MyTxt:SetJustifyH("LEFT")	
LD_HistFrame.MyTxt:SetText("Nombre:\nApellidos:\nEdad:\n\nAntecedentes históricos:\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nDescripción fisica:")

LD_HistFrame.NOMBRE = LD_EditFrameTrans (LD_HistFrame,  75,  -30, 150,  11, 1, "", false, 0.3)
LD_HistFrame.APELLI = LD_EditFrameTrans (LD_HistFrame,  75,  -42, 150,  11, 2, "", false, 0.3)
LD_HistFrame.EDAD   = LD_EditFrameTrans (LD_HistFrame,  75,  -54,  40,  11, 3, "", false, 0.3)
LD_HistFrame.HIST1  = LD_EditFrameTrans (LD_HistFrame,  20,  -90, 250, 150, 4, "", false, 0.3)
LD_HistFrame.HIST1:SetMultiLine(true)
LD_HistFrame.HIST1:SetMaxLetters(255)
LD_HistFrame.HIST1:SetSize(370,50)

LD_HistFrame.HIST2  = LD_EditFrameTrans (LD_HistFrame,  20,  -300, 250, 50, 1, "", false, 0.3)
LD_HistFrame.HIST2:SetMultiLine(true)
LD_HistFrame.HIST2:SetSize(370,50)
LD_HistFrame.HIST2:SetMaxLetters(255)

LD_HistFrame.TIRAMILLAS = CreateFrame ( "Button","TIRAMILLAS",LD_HistFrame,"UIPanelButtonTemplate") 
LD_HistFrame.TIRAMILLAS:SetSize(120,25)
LD_HistFrame.TIRAMILLAS:SetPoint("BOTTOMLEFT", LD_HistFrame, "BOTTOMLEFT", 50, 10)
LD_HistFrame.TIRAMILLAS:SetText("Enviar Historia")
LD_HistFrame.TIRAMILLAS:SetScript ("OnClick", function (self)
   StaticPopup_Show("CONFIRM_HISTORY")
end)
LD_HistFrame.CANCEL = CreateFrame ( "Button","HistCANCEL",LD_HistFrame,"UIPanelButtonTemplate") 
LD_HistFrame.CANCEL:SetSize(120,25)
LD_HistFrame.CANCEL:SetPoint("BOTTOMLEFT", LD_HistFrame, "BOTTOMLEFT", 200, 10)
LD_HistFrame.CANCEL:SetText("Cancelar")
LD_HistFrame.CANCEL:SetScript ("OnClick", function (self)
   LD_HistFrame:Hide()
end)
LD_HistFrame:Hide()
function LD_HistFrameLoad()
   if AIO_LD_CONFIG["ROL"] == nil then
      return
   end
   if AIO_LD_CONFIG["ROL"]["NOMBRE"] ~= nil then
      LD_HistFrame.NOMBRE:SetText(AIO_LD_CONFIG["ROL"]["NOMBRE"])
   end   
   if AIO_LD_CONFIG["ROL"]["APELLIDO"] ~= nil then
      LD_HistFrame.APELLI:SetText(AIO_LD_CONFIG["ROL"]["APELLIDO"])
   end   
   if AIO_LD_CONFIG["ROL"]["EDAD"] ~= nil then
      LD_HistFrame.EDAD:SetText(AIO_LD_CONFIG["ROL"]["EDAD"])
   end   
   if AIO_LD_CONFIG["ROL"]["HIST1"] ~= nil then
      LD_HistFrame.HIST1:SetText(AIO_LD_CONFIG["ROL"]["HIST1"])
   end   
   if AIO_LD_CONFIG["ROL"]["HIST2"] ~= nil then
      LD_HistFrame.HIST2:SetText(AIO_LD_CONFIG["ROL"]["HIST2"])
   end   
end


LD_ApproFrame=CreateFrame ( "Frame", "LD_ApproFrame", UIParent )
LD_ApproFrame:SetSize(400, 500)
LD_ApproFrame:SetPoint("CENTER", 0, 150)
LD_ApproFrame:SetBackdrop({
	--bgFile = [[Interface\Buttons\WHITE8x8]],
	bgFile = [[Interface\DialogFrame\UI-DialogBox-Gold-Background]],
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	edgeSize = 14,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
})
LD_ApproFrame:SetMovable(true)
LD_ApproFrame:EnableMouse(true)
LD_ApproFrame.MyTitle = LD_ApproFrame:CreateTitleRegion()
LD_ApproFrame.MyTitle:SetSize(400, 300) 
LD_ApproFrame.MyTitle:SetPoint("TOPLEFT", LD_ApproFrame, "TOPLEFT", 0, 0)
LD_ApproFrame.PjName = ""
LD_ApproFrame.Labels = LD_LabelTopColors ( 10, 
   -30, 
   LD_ApproFrame, 
   "  Nombre: \nApellidos: \nEdad: \n\n --- Reseña historica ---\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n --- Aspecto fisico ---", 
   0, 1, 0, 1 )
LD_ApproFrame.Cabecera  = LD_LabelTopColors ( 75,  -10, LD_ApproFrame, "-#-", 1, 1, 1, 1 )
LD_ApproFrame.Nombre    = LD_LabelTopColors ( 75,  -30, LD_ApproFrame, "-#-", 1, 1, 0, 1 )
LD_ApproFrame.Apellidos = LD_LabelTopColors ( 75,  -43, LD_ApproFrame, "-#-", 1, 1, 0, 1 )
LD_ApproFrame.Edad      = LD_LabelTopColors ( 50,  -55, LD_ApproFrame, "-#-", 1, 1, 0, 1 )
LD_ApproFrame.Hist1     = LD_LabelTopColors ( 10,  -95, LD_ApproFrame, "-#-", 1, 1, 0, 1 )
LD_ApproFrame.Hist1:SetSize ( 380, 100 )
LD_ApproFrame.Hist1:SetJustifyH("LEFT")
LD_ApproFrame.Hist1:SetJustifyV("TOP")
LD_ApproFrame.Hist1:SetWordWrap (true)
LD_ApproFrame.Hist2     = LD_LabelTopColors ( 10, -300, LD_ApproFrame, "-#-", 1, 1, 0, 1 )
LD_ApproFrame.Hist2:SetSize ( 380, 100 )
LD_ApproFrame.Hist2:SetJustifyH("LEFT")
LD_ApproFrame.Hist2:SetJustifyV("TOP")
LD_ApproFrame.Hist2:SetWordWrap (true)
   
LD_ApproFrame.Cabecera:SetJustifyH("LEFT")
LD_ApproFrame.Labels:SetJustifyH("LEFT")
LD_ApproFrame.Nombre:SetJustifyH("LEFT")
LD_ApproFrame.Apellidos:SetJustifyH("LEFT")
LD_ApproFrame.Edad:SetJustifyH("LEFT")

LD_ApproFrame.TIRAMILLAS = CreateFrame ( "Button","TIRAMILLAS",LD_ApproFrame,"UIPanelButtonTemplate") 
LD_ApproFrame.TIRAMILLAS:SetSize(120,25)
LD_ApproFrame.TIRAMILLAS:SetPoint("BOTTOMLEFT", LD_ApproFrame, "BOTTOMLEFT", 50, 10)
LD_ApproFrame.TIRAMILLAS:SetText("Aprobar")
LD_ApproFrame.TIRAMILLAS:SetScript ("OnClick", function (self)
   LDSendMsg("APPHI#" .. LD_ApproFrame.PjName )
end)
LD_ApproFrame.CANCEL = CreateFrame ( "Button","HistCANCEL",LD_ApproFrame,"UIPanelButtonTemplate") 
LD_ApproFrame.CANCEL:SetSize(120,25)
LD_ApproFrame.CANCEL:SetPoint("BOTTOMLEFT", LD_ApproFrame, "BOTTOMLEFT", 200, 10)
LD_ApproFrame.CANCEL:SetText("Cancelar")
LD_ApproFrame.CANCEL:SetScript ("OnClick", function (self)
   LD_ApproFrame:Hide()
end)


LD_ApproFrame:Hide()
--
-- BARRAS
--

StaticPopupDialogs["CONFIRM_HISTORY"] = {
  text = "Enviando esta peticion, el estado del personaje volverá a 'datos de rol pendientes'. ¿Estas seguro?",
  button1 = "Si",
  button2 = "No",
  OnAccept = function()
      LD_SetPjVar ( "APP", "ROL", "P" )
      LD_SetPjVar ( "NOMBRE"  , "ROL", LD_HistFrame.NOMBRE:GetText() )
      LD_SetPjVar ( "APELLIDO", "ROL", LD_HistFrame.APELLI:GetText() )
      LD_SetPjVar ( "EDAD"    , "ROL", LD_HistFrame.EDAD:GetText() )
      LD_SetPjVar ( "HIST1"   , "ROL", LD_HistFrame.HIST1:GetText() )
      LD_SetPjVar ( "HIST2"   , "ROL", LD_HistFrame.HIST2:GetText() )
      LD_HistFrame:Hide()
	  SysPrint ( "Tu historia ha sido enviada.")
	  SysPrint ( "En breve se analizará por el consejo y serás informad@ del resultado.")
  end,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
  preferredIndex = 3 }  

StaticPopupDialogs["MEATACAN"] = {
  text = "Te estan atacando, usa alguna de las habilidades de defensa o bien pulsa 'Ok' para usar la de defecto (1d15)",
  button1 = "Ok",
  button2 = "Huyes cobardemente",
  OnAccept = function()
     SysPrint ( "Has enviado tu defensa") 
     local MyRes = rand(1,15)
     SLD_Hability:ShowAllHabilities ()	 
  end,
  OnCancel = function()
     SysPrint ( "Has rechazado el combate (Cobarde)")  
	 SLD_Hability:ShowAllHabilities ()
  end,
  timeout = 120,
  whileDead = true,
  hideOnEscape = true,
  preferredIndex = 3 }  
  
  
LD_AttrTutor = CreateFrame ( "Frame", "LD_AttrTutor", UIParent )
LD_AttrTutor:SetSize(520, 500)
LD_AttrTutor:SetPoint("TOPLEFT", 10, -130)
LD_AttrTutor:SetBackdrop({
	-- bgFile = [[Interface\Buttons\WHITE8x8]],
	bgFile = [[Interface\PaperDollInfoFrame\UI-GearManager-Title-Background]],
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	edgeSize = 14,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
})
LD_AttrTutor.AttrDesc = ""
LD_AttrTutor.AttrBBDD = ""

LD_AttrTutor.MyVend = LD_AttrTutor:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_AttrTutor.MyVend:SetFont("Fonts\\MORPHEUS.TTF", 15)
LD_AttrTutor.MyVend:SetTextColor(1, 1, 0, 1)
LD_AttrTutor.MyVend:SetPoint("TOP", LD_AttrTutor, "TOP", 0, -10)
LD_AttrTutor.MyVend:SetText("Explicacion de los atributos")

LD_AttrTutor.MyVendTx = LD_AttrTutor:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_AttrTutor.MyVendTx:SetTextColor(0, 1, 0, 1)
LD_AttrTutor.MyVendTx:SetPoint("TOP", LD_AttrTutor, "TOP", 0, -30)
LD_AttrTutor.MyVendTx:SetJustifyH("LEFT")	
LD_AttrTutor.MyVendTx:SetText("________________________")

LD_AttrTutor.MyVendTxl = LD_AttrTutor:CreateFontString(nil,"ARTWORK","GameFontHighlight")
LD_AttrTutor.MyVendTxl:SetFont("Fonts\\ARIALN.TTF", 11)
LD_AttrTutor.MyVendTxl:SetTextColor(0.8, 0.8, 0, 1)
LD_AttrTutor.MyVendTxl:SetPoint("TOP", LD_AttrTutor, "TOP", 0, -50)
LD_AttrTutor.MyVendTxl:SetSize (500, 420)
LD_AttrTutor.MyVendTxl:SetWordWrap(true) 
LD_AttrTutor.MyVendTxl:SetJustifyH("LEFT")	
LD_AttrTutor.MyVendTxl:SetJustifyV("TOP")	
LD_AttrTutor.MyVendTxl:SetText("")
LD_AttrTutor.CANCEL = CreateFrame ( "Button","HistCANCEL",LD_AttrTutor,"UIPanelButtonTemplate") 
LD_AttrTutor.CANCEL:SetSize(220,25)
LD_AttrTutor.CANCEL:SetPoint("BOTTOMLEFT", LD_AttrTutor, "BOTTOMLEFT", 10, 10)
LD_AttrTutor.CANCEL:SetText("Cierra este rollo, por favor")
LD_AttrTutor.CANCEL:SetScript ("OnClick", function (self)
   LD_AttrTutor:Hide()
end)
LD_AttrTutor:Hide()
  
StaticPopupDialogs["CONFIRM_ATTR"] = {
  text = "Aumentar 1 punto de " .. LD_AttrVendFrame.AttrDesc .. "\n¿Estas seguro?",
  button1 = "Si",
  button2 = "No",
  OnAccept = function()
     local MyRaceLoc, MyRace = UnitRace("player")
	  if tonumber(AIO_LD_CONFIG["ROL"]["PATTR"]) <= 0 then
	     ErrPrint("No tienes suficientes puntos de atributo")
	     return
	  end
	  if tonumber(AIO_LD_CONFIG["ATRIBUTO"][LD_AttrVendFrame.AttrBBDD]) >= 
	     tonumber(AIO_LD_CONFIG["SYS"]["ATTRSETS"][MyRace][LD_AttrVendFrame.AttrBBDD .. "_MAX"]) then
	     ErrPrint("Has llegado al máximo permitido para tu raza de este atributo")
	     return
	  end
	  LD_ATRFrame:Hide()
      LD_SetPjVar ( LD_AttrVendFrame.AttrBBDD, 
	                "ATRIBUTO", 
					AIO_LD_CONFIG["ATRIBUTO"][LD_AttrVendFrame.AttrBBDD] + 1 )
      LD_SetPjVar ( "PATTR", 
	                "ROL", 
					AIO_LD_CONFIG["ROL"]["PATTR"] - 1 )
	  SysPrint ( "Has ganado 1 punto de " .. LD_AttrVendFrame.AttrDesc)
	  LD_ATRFrame:Show()
	  LD_RefreshBars()
  end,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
  preferredIndex = 3 }  
  
  

else
   PrintInfo("SLD Frames2 Loaded ...")
end