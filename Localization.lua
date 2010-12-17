--[[--------------------------------------------------------------------
	Diplomancer
	Automatically sets your watched faction based on your location.
	by Phanx < addons@phanx.net >
	Copyright © 2007–2010 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info9643-Diplomancer.html
	http://wow.curse.com/downloads/wow-addons/details/diplomancer.aspx
----------------------------------------------------------------------]]

local LOCALE = GetLocale()
if LOCALE:match("^en") then return end

local _, Diplomancer = ...
if not Diplomancer then -- WoW China is still running 3.2
	Diplomancer = { }
	_G.Diplomancer = Diplomancer
end
Diplomancer.L = { }

--[[--------------------------------------------------------------------
	deDE | German | Deutsch
	Contributors: paterbrown
	Last updated: 2009-02-07
----------------------------------------------------------------------]]

if LOCALE == "deDE" then

	L["Default faction"] = "Standardfraktion"
	L["Select a faction to watch when your current location doesn't have an associated faction."] = "Wähle eine Standardfraktion, welche angezeigt wird wenn dein Aufenthaltsort nicht mit einer Fraktion verknüpft ist."

	L["Reset"] = "Reset"
	L["Reset your default faction preference to your race's faction."] = "Zurücksetzen der Standardfraktion auf deine Volksfraktion."

--	L["Default to championed faction"] = ""
--	L["Use your currently championed faction as your default faction.] = ""

	L["Ignore exalted factions"] = "Ignoriere ehrfürchtige Fraktionen"
	L["Don't watch factions with whom you have already attained Exalted reputation."] = "Zeigt Fraktionen mit ehrfürchtigem Ruf nicht mehr an."

	L["Announce watched faction"] = "Schalte Benachrichtigungen ein"
	L["Show a message in the chat frame when your watched faction is changed."] = "Zeigt eine Meldung im Chatfenster wenn sich die angezeigte Fraktion ändert."

end

--[[--------------------------------------------------------------------
	esES | Spanish | Español
	Contributors: Phanx
	Last updated: 2010-12-14
----------------------------------------------------------------------]]

if LOCALE == "esES" or LOCALE == "esMX" then

	L["Default faction"] = "Facción por defecto"
	L["Select a faction to watch when your current location doesn't have an associated faction."] = "Seleccione una de las facciones a vigilar cuando su ubicación actual no tiene una facción asociada."

	L["Reset"] = "Restablecer"
	L["Reset your default faction preference to your race's faction."] = "Restablecer su preferencia por defecto a la facción de la facción de su raza."

	L["Default to championed faction"] = "Por defecto a facción abanderas"
	L["Use your currently championed faction as your default faction.] = "Utilice su facción en la actualidad abanderas como su facción por defecto."

	L["Ignore exalted factions"] = "Ignorar facciones Exaltados"
	L["Don't watch factions with whom you have already attained Exalted reputation."] = "No vea las facciones con las que ya hemos logrado la reputación de Exaltado."

	L["Announce watched faction"] = "Habilitar las notificaciones"
	L["Show a message in the chat frame when your watched faction is changed."] = "Mostrar un mensaje en el marco del chat al cambiar tu facción seguimientos."

end

--[[--------------------------------------------------------------------
	frFR | French | Français
	Contributors: ???
	Last updated: YYYY-MM-DD
----------------------------------------------------------------------]]

if LOCALE == "frFR" then

--	L["Default faction"] = ""
--	L["Select a faction to watch when your current location doesn't have an associated faction."] = ""

--	L["Reset"] = ""
--	L["Reset your default faction preference to your race's faction."] = ""

--	L["Default to championed faction"] = ""
--	L["Use your currently championed faction as your default faction.] = ""

--	L["Ignore exalted factions"] = ""
--	L["Don't watch factions with whom you have already attained Exalted reputation."] = ""

--	L["Announce watched faction"] = ""
--	L["Show a message in the chat frame when your watched faction is changed."] = ""

end

--[[--------------------------------------------------------------------
	ruRU | Russian | Русский
	Contributors: ???
	Last updated: YYYY-MM-DD
----------------------------------------------------------------------]]

if LOCALE == "ruRU" then

--	L["Default faction"] = ""
--	L["Select a faction to watch when your current location doesn't have an associated faction."] = ""

--	L["Reset"] = ""
--	L["Reset your default faction preference to your race's faction."] = ""

--	L["Default to championed faction"] = ""
--	L["Use your currently championed faction as your default faction.] = ""

--	L["Ignore exalted factions"] = ""
--	L["Don't watch factions with whom you have already attained Exalted reputation."] = ""

--	L["Announce watched faction"] = ""
--	L["Show a message in the chat frame when your watched faction is changed."] = ""

end

--[[--------------------------------------------------------------------
	koKR | Korean | 한국어
	Contributors: ???
	Last updated: YYYY-MM-DD
----------------------------------------------------------------------]]

if LOCALE == "koKR" then

--	L["Default faction"] = ""
--	L["Select a faction to watch when your current location doesn't have an associated faction."] = ""

--	L["Reset"] = ""
--	L["Reset your default faction preference to your race's faction."] = ""

--	L["Default to championed faction"] = ""
--	L["Use your currently championed faction as your default faction.] = ""

--	L["Ignore exalted factions"] = ""
--	L["Don't watch factions with whom you have already attained Exalted reputation."] = ""

--	L["Announce watched faction"] = ""
--	L["Show a message in the chat frame when your watched faction is changed."] = ""

end

--[[--------------------------------------------------------------------
	zhCN | Simplified Chinese | 简体中文
	Contributors: VENSTER, 急云@CWDG
	Last updated: 2010-08-05
----------------------------------------------------------------------]]

if LOCALE == "zhCN" then

	L["Default faction"] = "缺省声望"
	L["Select a faction to watch when your current location doesn't have an associated faction."] = "当目前所在区域没有对应声望时，选择监视的声望"

	L["Reset"] = "重置"
	L["Reset your default faction preference to your race's faction."] = "将你的缺省声望重置为种族声望"

--	L["Default to championed faction"] = ""
--	L["Use your currently championed faction as your default faction.] = ""

	L["Ignore exalted factions"] = "忽略已崇拜的声望"
	L["Don't watch factions with whom you have already attained Exalted reputation."] = "选择是否忽略监视已经崇拜的声望"

	L["Announce watched faction"] = "开启提示"
	L["Show a message in the chat frame when your watched faction is changed."] = "选择是否显示声望监视状态变动"

end

--[[--------------------------------------------------------------------
	zhTW | Traditional Chinese | 正體中文
	Contributors: 急云@CWDG
	Last updated: 2010-01-23
----------------------------------------------------------------------]]

if LOCALE == "zhTW" then

	L["Default faction"] = "缺省聲望"
	L["Select a faction to watch when your current location doesn't have an associated faction."] = "當目前所在區域沒有對應聲望時，選擇監視的聲望"

	L["Reset"] = "重置"
	L["Reset your default faction preference to your race's faction."] = "將你的缺省聲望重置為種族聲望"

--	L["Default to championed faction"] = ""
--	L["Use your currently championed faction as your default faction.] = ""

	L["Ignore exalted factions"] = "忽略已崇拜的聲望"
	L["Don't watch factions with whom you have already attained Exalted reputation."] = "選擇是否忽略監視已經崇拜的聲望"

	L["Announce watched faction"] = "開啟提示"
	L["Show a message in the chat frame when your watched faction is changed."] = "選擇是否顯示聲望監視狀態變動"

end