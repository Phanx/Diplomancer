--[[--------------------------------------------------------------------------------------------------------------------
  Diplomancer — Changes your watched faction reputation based on your current location.
  Copyright © 2007-2018 Phanx <addons@phanx.net>, Talyrius <contact@talyrius.net>. All rights reserved.
  See the accompanying LICENSE file for more information.

  Authorized distributions:
    https://github.com/Talyrius/Diplomancer
    https://wow.curseforge.com/projects/diplomancer
    https://www.curseforge.com/wow/addons/diplomancer
    https://www.wowinterface.com/downloads/info9643-Diplomancer.html
--]]--------------------------------------------------------------------------------------------------------------------

local ADDON_NAME, Diplomancer = ...
local L = Diplomancer.L

local db, onTaxi, tabard
local championFactions, championZones, racialFaction, subzoneFactions, zoneFactions

_G.Diplomancer = Diplomancer

------------------------------------------------------------------------------------------------------------------------

-- Debugging is toggled on/off via "/diplomancer debug".
function Diplomancer:Debug(text, ...)
  if self.DEBUG and text then
    if text:match("%%[dfqsx%d%.]") then
      (DEBUG_CHAT_FRAME or ChatFrame3):AddMessage("|cFF8ADCFFDiplomancer|cFF3D819B[|cFFE06C75Debug|cFF3D819B]|r: " .. format(text, ...))
    else
      (DEBUG_CHAT_FRAME or ChatFrame3):AddMessage("|cFF8ADCFFDiplomancer|cFF3D819B[|cFFE06C75Debug|cFF3D819B]|r: " .. strjoin(" ", text, tostringall(...)))
    end
  end
end

function Diplomancer:Print(text, ...)
  if text then
    if text:match("%%[dfqs%d%.]") then
      DEFAULT_CHAT_FRAME:AddMessage("|cFF8ADCFFDiplomancer|r: " .. format(text, ...))
    else
      DEFAULT_CHAT_FRAME:AddMessage("|cFF8ADCFFDiplomancer|r: " .. strjoin(" ", text, tostringall(...)))
    end
  end
end

------------------------------------------------------------------------------------------------------------------------

local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("ADDON_LOADED")
EventFrame:SetScript("OnEvent", function(self, event, ...)
  return Diplomancer[event] and Diplomancer[event](Diplomancer, event, ...)
end)
Diplomancer.EventFrame = EventFrame

------------------------------------------------------------------------------------------------------------------------

function Diplomancer:ADDON_LOADED(event, addon)
  if addon ~= ADDON_NAME then return end
  self:Debug("ADDON_LOADED", addon)

  if not DiplomancerSettings then
    self:Debug("No saved settings found!")
    DiplomancerSettings = {}
  end
  db = DiplomancerSettings

  if type(db.defaultFaction) == "string" then
    db.defaultFaction = self:GetFactionIDFromName(db, defaultFaction)
  end

  EventFrame:UnregisterEvent("ADDON_LOADED")
  self.ADDON_LOADED = nil

  if IsLoggedIn() then
    self:PLAYER_LOGIN(event)
  else
    EventFrame:RegisterEvent("PLAYER_LOGIN")
  end
end

------------------------------------------------------------------------------------------------------------------------

function Diplomancer:PLAYER_LOGIN(event)
  self:Debug("PLAYER_LOGIN")

  self:LocalizeData()
  if not self.localized then return end

  championFactions = self.championFactions
  championZones = self.championZones
  racialFaction = self.racialFaction
  subzoneFactions = self.subzoneFactions
  zoneFactions = self.zoneFactions

  EventFrame:RegisterEvent("ACTIONBAR_UPDATE_USABLE")
  EventFrame:RegisterEvent("CHAT_MSG_SYSTEM")
  EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
  EventFrame:RegisterEvent("UNIT_INVENTORY_CHANGED")
  EventFrame:RegisterEvent("ZONE_CHANGED")
  EventFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
  EventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")

  EventFrame:UnregisterEvent("PLAYER_LOGIN")
  self.PLAYER_LOGIN = nil

  tabard = GetInventoryItemID("player", INVSLOT_TABARD)
  if UnitOnTaxi("player") then
    onTaxi = true
  else
    self:Update(event)
  end
end

------------------------------------------------------------------------------------------------------------------------

function Diplomancer:GetBestMapForPlayer()
  local mapID = C_Map.GetBestMapForUnit("player")
  local mapInfo = mapID and C_Map.GetMapInfo(mapID)
  if mapInfo and mapInfo.mapType == Enum.UIMapType.Micro then
    mapID = mapInfo.parentMapID
  end
  return mapID
end

function Diplomancer:Update(event)
  if onTaxi then
    self:Debug("On taxi. Skipping update.")
    return
  end

  local faction
  local zone = self:GetBestMapForPlayer()
  self:Debug("Update", event, zone)

  local tabardFaction, tabardLevel = self:GetChampionedFaction()
  if tabardFaction then
    local _, instanceType = IsInInstance()
    if instanceType == "party" then
      self:Debug("Wearing tabard for:", tabardFaction)
      local instances = championZones[tabardLevel]
      if instances and instances[zone] then
        -- Championing this faction has a level requirement.
        if GetDungeonDifficultyID() >= instances[zone] then
          faction = tabardFaction
          self:Debug("CHAMPION", faction)
          if db.defaultChampion then
            db.defaultFaction = faction
          end
          if self:SetWatchedFactionByID(faction, db.verbose) then
            return
          end
        end
      elseif not instances and not championZones[70][zone] then
        -- Championing this faction doesn't have a level requirement,
        -- but Outland dungeons don't count, and WotLK/Cataclysm dungeons are weird.
        local minDifficulty = championZones[85][zone] or championZones[80][zone]
        if not minDifficulty or GetDungeonDifficultyID() >= minDifficulty then
          faction = tabardFaction
          self:Debug("CHAMPION", faction)
          if db.defaultChampion then
            db.defaultFaction = faction
          end
          if self:SetWatchedFactionByID(faction, db.verbose) then
            return
          end
        end
      end
    end
  end

  local subzone = GetSubZoneText() == "" and GetRealZoneText() or GetSubZoneText()
  self:Debug("Checking subzone:", subzone)
  if subzone then
    faction = subzoneFactions[zone] and subzoneFactions[zone][subzone]
    if faction then
      self:Debug("SUBZONE", faction)
      if self:SetWatchedFactionByID(faction, db.verbose) then
        return
      end
    end
  end

  faction = zoneFactions[zone]
  self:Debug("Checking zone:", zone, zone and C_Map.GetMapInfo(zone).name)
  if faction then
    self:Debug("ZONE", faction)
    if self:SetWatchedFactionByID(faction, db.verbose) then
      return
    end
  end

  if tabardFaction and db.defaultChampion then
    faction = tabardFaction
    if faction then
      self:Debug("DEFAULT CHAMPION", faction)
      if self:SetWatchedFactionByID(faction, db.verbose) then
        return
      end
    end
  end

  faction = db.defaultFaction or racialFaction
  self:Debug(db.defaultFaction and "DEFAULT" or "RACE", faction)
  if not self:SetWatchedFactionByID(faction, db.verbose) then
    self:Debug("NONE")
    SetWatchedFactionIndex(0)
  end
end

------------------------------------------------------------------------------------------------------------------------

do
  local running
  function Diplomancer:DelayedUpdate(event, duration)
    if not running then
      C_Timer.After(duration or 0.5, function()
        running = nil
        self:Update(event)
      end)
      running = true
    end
  end
end

Diplomancer.PLAYER_ENTERING_WORLD = Diplomancer.DelayedUpdate
Diplomancer.ZONE_CHANGED = Diplomancer.DelayedUpdate
Diplomancer.ZONE_CHANGED_INDOORS = Diplomancer.DelayedUpdate
Diplomancer.ZONE_CHANGED_NEW_AREA = Diplomancer.DelayedUpdate

------------------------------------------------------------------------------------------------------------------------

function Diplomancer:ACTIONBAR_UPDATE_USABLE(event)
  local nowTaxi = UnitOnTaxi("player")
  if nowTaxi == onTaxi then return end
  self:Debug("ACTIONBAR_UPDATE_USABLE", onTaxi, "->", nowTaxi)
  onTaxi = nowTaxi
  if not onTaxi then
    self:Update(event)
  end
end

------------------------------------------------------------------------------------------------------------------------

function Diplomancer:CHAT_MSG_SYSTEM(event, msg)
  local pattern = gsub(FACTION_STANDING_CHANGED, "%%s", ".+")
  if msg:match(pattern) then
    self:DelayedUpdate(event)
  end
end

------------------------------------------------------------------------------------------------------------------------

function Diplomancer:UNIT_INVENTORY_CHANGED(event, unit)
  if unit == "player" then
    local new = GetInventoryItemID(unit, INVSLOT_TABARD)
    if not (new or tabard) then return end
    self:Debug("UNIT_INVENTORY_CHANGED\nCurrent:", new and GetItemInfo(new) or "none", "\nPrevious:", tabard and GetItemInfo(tabard) or "none")
    if new ~= tabard then
      tabard = new
      self:Update(event)
    end
  end
end

------------------------------------------------------------------------------------------------------------------------

function Diplomancer:PickBestFaction(factions)
  if self.DEBUG then
    local str = ""
    for id in pairs(factions) do
      str = str .. " " .. id
    end
    self:Debug("PickBestFaction:", str)
  end
  local bestStandingID, bestFactionID = -1
  self:ExpandFactionHeaders()
  for i = 1, GetNumFactions() do
    local _, _, standingID, _, _, _, _, _, _, _, _, isWatched, _, factionID = GetFactionInfo(i)
    if factions[factionID] and standingID > bestStandingID then
      bestFactionID = factionID
      bestStandingID = standingID
    end
  end
  self:RestoreFactionHeaders()
  return bestFactionID
end

function Diplomancer:SetWatchedFactionByID(id, verbose)
  if type(id) == "table" then
    return self:SetWatchedFactionByID(self:PickBestFaction(id))
  end
  if type(id) ~= "number" then return end
  self:Debug("SetWatchedFactionByID:", id)
  self:ExpandFactionHeaders()
  for i = 1, GetNumFactions() do
    local name, _, standingID, _, _, _, _, _, _, _, _, isWatched, _, factionID = GetFactionInfo(i)
    --self:Debug("GetFactionInfo", i, factionID, name, standingID, isWatched)
    if factionID == id then
      self:Debug("Found faction:", name, standingID, isWatched)
      if (standingID < 8 or not db.ignoreExalted) then
        if not isWatched then
          SetWatchedFactionIndex(i)
          if verbose then
            self:Print(L.NowWatching, name)
          end
        end
        self:RestoreFactionHeaders()
        return name, id
      else
        break
      end
    end
  end
  self:RestoreFactionHeaders()
end

------------------------------------------------------------------------------------------------------------------------

function Diplomancer:GetChampionedFaction()
  for i = 1, 40 do
    local _, _, _, _, _, _, _, _, _, id = UnitBuff("player", i)
    if not id then
      break
    end
    local data = championFactions[id]
    if data then
      local faction, level = data[2], data[1]
      self:Debug("GetChampionedFaction:", tostring(faction), tostring(level))
      return faction, level
    end
  end
  self:Debug("GetChampionedFaction:", "none")
end

------------------------------------------------------------------------------------------------------------------------

function Diplomancer:GetFactionIDFromName(search)
  self:Debug("GetFactionIDFromName", search)
  local result1, result2
  if not search then
    return
  end
  search = gsub(strlower(tostring(search)), "['%s%-]", "")
  if strlen(search) < 1 then
    return
  end

  self:ExpandFactionHeaders()
  for i = 1, GetNumFactions() do
    local name, _, _, _, _, _, _, _, _, _, _, _, _, factionID = GetFactionInfo(i)
    local text = gsub(strlower(tostring(name)), "['%s%-]", "")
    if strmatch(text, search) then
      self:RestoreFactionHeaders()
      return factionID, name
    end
  end
  self:RestoreFactionHeaders()
end

function Diplomancer:GetFactionNameFromID(search)
  self:Debug("GetFactionNameFromID", search)
  if search and type(search) ~= "number" then
    search = tonumber(search)
  end
  if not search then
    return
  end

  self:ExpandFactionHeaders()
  for i = 1, GetNumFactions() do
    local name, _, _, _, _, _, _, _, _, _, _, _, _, factionID = GetFactionInfo(i)
    if factionID == search then
      self:RestoreFactionHeaders()
      return name, factionID
    end
  end
  self:RestoreFactionHeaders()
end

------------------------------------------------------------------------------------------------------------------------

local GetNumFactions, GetFactionInfo, ExpandFactionHeader, CollapseFactionHeader = GetNumFactions, GetFactionInfo, ExpandFactionHeader, CollapseFactionHeader
local wasCollapsed = {}

function Diplomancer:ExpandFactionHeaders()
  self:Debug("ExpandFactionHeaders")
  local i = 1
  while i <= GetNumFactions() do
    local name, _, _, _, _, _, _, _, isHeader, isCollapsed = GetFactionInfo(i)
    if isHeader then
      wasCollapsed[name] = isCollapsed
      if name == FACTION_INACTIVE then
        if not isCollapsed then
          CollapseFactionHeader(i)
        end
        break
      elseif isCollapsed then
        ExpandFactionHeader(i)
      end
    end
    i = i + 1
  end
end

function Diplomancer:RestoreFactionHeaders()
  self:Debug("RestoreFactionHeaders")
  local i = 1
  while i <= GetNumFactions() do
    local name, _, _, _, _, _, _, _, isHeader, isCollapsed = GetFactionInfo(i)
    if isHeader then
      if isCollapsed and not wasCollapsed[name] then
        ExpandFactionHeader(i)
      elseif wasCollapsed[name] and not isCollapsed then
        CollapseFactionHeader(i)
      end
    end
    i = i + 1
  end
  wipe(wasCollapsed)
end
