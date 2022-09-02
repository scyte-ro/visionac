---------- INIT Code ----------
local loaded = false
local CConfig = {}
local CPlayers = {}
CPlayers.playersList = {}
local CWebhook = {}
local CSanctions = {}
local CLanguage = {}
local CBans = {}
local CApi = {}
local CLicense = {}
local CIdentifiers = {}
local CVPN = {}
local CChatSpam = {}
local CWords = {}

---------- INIT Code ----------

---------- ./src/s_files.lua ----------
function io.fileExists(name)
    local f = io.open(name, "r")
    if f then 
        io.close(f)
        return true
    end
    return false
end

function io.readAll(name)
    if not io.fileExists(name) then return "" end
    local f = io.open(name, "rb")
    local content = f:read("*all")
    io.close(f)
    f = nil
    return content
end

function io.overwrite(file, text)
    local f = io.open(file, "w")
    f:write(text)
    io.close(f)
    f = nil 
end
---------- ./src/s_files.lua ----------

---------- ./src/g_events.lua ----------
if not CEvents then CEvents = {} end
CEvents.events = {}
CEvents.characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

CEvents.register = function(identifier, callback)
    if not identifier then
        return CResource.error("No identifier provided to register event.")
    end

    if not callback then
        return CResource.error("No callback provided to register event with identifier " .. identifier .. ".")
    end

    if not CEvents.events[tostring(identifier)] then
        CEvents.events[tostring(identifier)] = {}
    end

    local index = #CEvents.events[tostring(identifier)] + 1
    CEvents.events[tostring(identifier)][index] = callback
    return index
end

CEvents.call = function(identifier, ...)
    local events = CEvents.events[tostring(identifier)]
    if events then
        for i = 1, #events do
            events[i](...)
        end
    end
end

CEvents.destroy = function(identifier, index)
    if CEvents.events[tostring(identifier)] then
        CEvents.events[tostring(identifier)][index] = nil
    end
end

local cachedfbjhgvdsdgf = {}
local gsub = string.gsub
local byte = string.byte
local sub = string.sub
local find = string.find
local char = string.char
local ins = table.insert
local cnct = table.concat

CEvents.encode = function(data)
    local index = data

    if not cachedfbjhgvdsdgf[index] then 
        data = tostring(data)
        cachedfbjhgvdsdgf[index] = gsub(gsub(data, '.', function(x) 
            local r,b={},byte(x)
            for i=8,1,-1 do ins(r, (b%2^i-b%2^(i-1)>0 and '1' or '0')) end
            return cnct(r)
        end)..'0000', '%d%d%d?%d?%d?%d?', function(x)
            if (#x < 6) then return '' end
            local c=0
            for i=1,6 do c=c+(sub(x, i,i)=='1' and 2^(6-i) or 0) end
            return sub(CEvents.characters, c+1,c+1)
        end)..({ '', '==', '=' })[#data%3+1]
    end

    return cachedfbjhgvdsdgf[index]
end

CEvents.decode = function(data)
    local index = data

    if not cachedfbjhgvdsdgf[index] then 
        data = gsub(data, '[^'..CEvents.characters..'=]', '')
        cachedfbjhgvdsdgf[index] = gsub(gsub(data, '.', function(x)
            if (x == '=') then return '' end
            local r,f={},(find(CEvents.characters, x)-1)
            for i=6,1,-1 do ins(r, (f%2^i-f%2^(i-1)>0 and '1' or '0')) end
            return cnct(r)
        end), '%d%d%d?%d?%d?%d?%d?%d?', function(x)
            if (#x ~= 8) then return '' end
            local c=0
            for i=1,8 do c=c+(sub(x, i,i)=='1' and 2^(8-i) or 0) end
            return char(c)
        end)
    end

    return cachedfbjhgvdsdgf[index]
end
---------- ./src/g_events.lua ----------

---------- ./src/g_hashes.lua ----------
local GameHashes = {
    weapons = {
        [-1357824103] = { model = "WEAPON_ADVANCEDRIFLE" },
        [324506233] = { model = "WEAPON_AIRSTRIKE_ROCKET" },
        [738733437] = { model = "WEAPON_AIR_DEFENCE_GUN" },
        [-100946242] = { model = "WEAPON_ANIMAL" },
        [584646201] = { model = "WEAPON_APPISTOL" },
        [-1074790547] = { model = "WEAPON_ASSAULTRIFLE" },
        [-494615257] = { model = "WEAPON_ASSAULTSHOTGUN" },
        [-270015777] = { model = "WEAPON_ASSAULTSMG" },
        [317205821] = { model = "WEAPON_AUTOSHOTGUN" },
        [600439132] = { model = "WEAPON_BALL" },
        [1223143800] = { model = "WEAPON_BARBED_WIRE" },
        [-1786099057] = { model = "WEAPON_BAT" },
        [-853065399] = { model = "WEAPON_BATTLEAXE" },
        [-1955384325] = { model = "WEAPON_BLEEDING" },
        [-102323637] = { model = "WEAPON_BOTTLE" },
        [-2000187721] = { model = "WEAPON_BRIEFCASE" },
        [28811031] = { model = "WEAPON_BRIEFCASE_02" },
        [2132975508] = { model = "WEAPON_BULLPUPRIFLE" },
        [-1654528753] = { model = "WEAPON_BULLPUPSHOTGUN" },
        [-1600701090] = { model = "WEAPON_BZGAS" },
        [-2084633992] = { model = "WEAPON_CARBINERIFLE" },
        [2144741730] = { model = "WEAPON_COMBATMG" },
        [171789620] = { model = "WEAPON_COMBATPDW" },
        [1593441988] = { model = "WEAPON_COMBATPISTOL" },
        [125959754] = { model = "WEAPON_COMPACTLAUNCHER" },
        [1649403952] = { model = "WEAPON_COMPACTRIFLE" },
        [148160082] = { model = "WEAPON_COUGAR" },
        [-2067956739] = { model = "WEAPON_CROWBAR" },
        [-1834847097] = { model = "WEAPON_DAGGER" },
        [-275439685] = { model = "WEAPON_DBSHOTGUN" },
        [-38085395] = { model = "WEAPON_DIGISCANNER" },
        [-10959621] = { model = "WEAPON_DROWNING" },
        [1936677264] = { model = "WEAPON_DROWNING_IN_VEHICLE" },
        [-1833087301] = { model = "WEAPON_ELECTRIC_FENCE" },
        [910830060] = { model = "WEAPON_EXHAUSTION" },
        [539292904] = { model = "WEAPON_EXPLOSION" },
        [-842959696] = { model = "WEAPON_FALL" },
        [-544306709] = { model = "WEAPON_FIRE" },
        [101631238] = { model = "WEAPON_FIREEXTINGUISHER" },
        [2138347493] = { model = "WEAPON_FIREWORK" },
        [1233104067] = { model = "WEAPON_FLARE" },
        [1198879012] = { model = "WEAPON_FLAREGUN" },
        [-499989876] = { model = "WEAPON_GARBAGEBAG" },
        [1141786504] = { model = "WEAPON_GOLFCLUB" },
        [-1813897027] = { model = "WEAPON_GRENADE" },
        [-1568386805] = { model = "WEAPON_GRENADELAUNCHER" },
        [1305664598] = { model = "WEAPON_GRENADELAUNCHER_SMOKE" },
        [1627465347] = { model = "WEAPON_GUSENBERG" },
        [1317494643] = { model = "WEAPON_HAMMER" },
        [-800287667] = { model = "WEAPON_HANDCUFFS" },
        [-102973651] = { model = "WEAPON_HATCHET" },
        [-771403250] = { model = "WEAPON_HEAVYPISTOL" },
        [984333226] = { model = "WEAPON_HEAVYSHOTGUN" },
        [205991906] = { model = "WEAPON_HEAVYSNIPER" },
        [341774354] = { model = "WEAPON_HELI_CRASH" },
        [-868994466] = { model = "WEAPON_HIT_BY_WATER_CANNON" },
        [1672152130] = { model = "WEAPON_HOMINGLAUNCHER" },
        [-1716189206] = { model = "WEAPON_KNIFE" },
        [-656458692] = { model = "WEAPON_KNUCKLE" },
        [-581044007] = { model = "WEAPON_MACHETE" },
        [-619010992] = { model = "WEAPON_MACHINEPISTOL" },
        [-598887786] = { model = "WEAPON_MARKSMANPISTOL" },
        [-952879014] = { model = "WEAPON_MARKSMANRIFLE" },
        [-1660422300] = { model = "WEAPON_MG" },
        [324215364] = { model = "WEAPON_MICROSMG" },
        [1119849093] = { model = "WEAPON_MINIGUN" },
        [-1121678507] = { model = "WEAPON_MINISMG" },
        [615608432] = { model = "WEAPON_MOLOTOV" },
        [-1466123874] = { model = "WEAPON_MUSKET" },
        [1737195953] = { model = "WEAPON_NIGHTSTICK" },
        [375527679] = { model = "WEAPON_PASSENGER_ROCKET" },
        [883325847] = { model = "WEAPON_PETROLCAN" },
        [-1169823560] = { model = "WEAPON_PIPEBOMB" },
        [453432689] = { model = "WEAPON_PISTOL" },
        [-1716589765] = { model = "WEAPON_PISTOL50" },
        [-1810795771] = { model = "WEAPON_POOLCUE" },
        [-1420407917] = { model = "WEAPON_PROXMINE" },
        [487013001] = { model = "WEAPON_PUMPSHOTGUN" },
        [1834241177] = { model = "WEAPON_RAILGUN" },
        [133987706] = { model = "WEAPON_RAMMED_BY_CAR" },
        [856002082] = { model = "WEAPON_REMOTESNIPER" },
        [-1045183535] = { model = "WEAPON_REVOLVER" },
        [-1312131151] = { model = "WEAPON_RPG" },
        [-1553120962] = { model = "WEAPON_RUN_OVER_BY_CAR" },
        [2017895192] = { model = "WEAPON_SAWNOFFSHOTGUN" },
        [736523883] = { model = "WEAPON_SMG" },
        [-37975472] = { model = "WEAPON_SMOKEGRENADE" },
        [100416529] = { model = "WEAPON_SNIPERRIFLE" },
        [126349499] = { model = "WEAPON_SNOWBALL" },
        [-1076751822] = { model = "WEAPON_SNSPISTOL" },
        [-1063057011] = { model = "WEAPON_SPECIALCARBINE" },
        [741814745] = { model = "WEAPON_STICKYBOMB" },
        [1752584910] = { model = "WEAPON_STINGER" },
        [911657153] = { model = "WEAPON_STUNGUN" },
        [-538741184] = { model = "WEAPON_SWITCHBLADE" },
        [-1569615261] = { model = "WEAPON_UNARMED" },
        [-1090665087] = { model = "WEAPON_VEHICLE_ROCKET" },
        [137902532] = { model = "WEAPON_VINTAGEPISTOL" },
        [419712736] = { model = "WEAPON_WRENCH" }
    },
}

if not IsDuplicityVersion() then
    GameHashes.pickups = {
        [1426343849] = "PICKUP_AMMO_BULLET_MP",
        [-114341780] = "PICKUP_AMMO_FIREWORK",
        [1613316560] = "PICKUP_AMMO_FIREWORK_MP",
        [-535568356] = "PICKUP_AMMO_FLAREGUN",
        [-2011516760] = "PICKUP_AMMO_GRENADELAUNCHER",
        [-1541298894] = "PICKUP_AMMO_GRENADELAUNCHER_MP",
        [1548844439] = "PICKUP_AMMO_HOMINGLAUNCHER",
        [-564600653] = "PICKUP_AMMO_MG",
        [-228982343] = "PICKUP_AMMO_MINIGUN",
        [-107080240] = "PICKUP_AMMO_MISSILE_MP",
        [544828034] = "PICKUP_AMMO_PISTOL",
        [-457363514] = "PICKUP_AMMO_RIFLE",
        [-2071756841] = "PICKUP_AMMO_RPG",
        [2012476125] = "PICKUP_AMMO_SHOTGUN",
        [292537574] = "PICKUP_AMMO_SMG",
        [-1070796507] = "PICKUP_AMMO_SNIPER",
        [1274757841] = "PICKUP_ARMOUR_STANDARD",
        [-482507216] = "PICKUP_CAMERA",
        [738282662] = "PICKUP_CUSTOM_SCRIPT",
        [-512375144] = "PICKUP_GANG_ATTACK_MONEY",
        [483577702] = "PICKUP_HEALTH_SNACK",
        [-1888453608] = "PICKUP_HEALTH_STANDARD",
        [-831529621] = "PICKUP_MONEY_CASE",
        [545862290] = "PICKUP_MONEY_DEP_BAG",
        [341217064] = "PICKUP_MONEY_MED_BAG",
        [1897726628] = "PICKUP_MONEY_PAPER_BAG",
        [513448440] = "PICKUP_MONEY_PURSE",
        [-562499202] = "PICKUP_MONEY_SECURITY_CASE",
        [-31919185] = "PICKUP_MONEY_VARIABLE",
        [1575005502] = "PICKUP_MONEY_WALLET",
        [1735599485] = "PICKUP_PARACHUTE",
        [-301062413] = "PICKUP_PORTABLE_CRATE_FIXED_INCAR",
        [-1477820210] = "PICKUP_PORTABLE_CRATE_FIXED_INCAR_SMALL",
        [-1605465331] = "PICKUP_PORTABLE_CRATE_FIXED_INCAR_WITH_PASSENGERS",
        [1852930709] = "PICKUP_PORTABLE_CRATE_UNFIXED",
        [-1863327941] = "PICKUP_PORTABLE_CRATE_UNFIXED_INAIRVEHICLE_WITH_PASSENGERS",
        [1263688126] = "PICKUP_PORTABLE_CRATE_UNFIXED_INCAR",
        [-1009939663] = "PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL",
        [79909481] = "PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_WITH_PASSENGERS",
        [-1795552418] = "PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW",
        [837436873] = "PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE",
        [-2136239332] = "PICKUP_PORTABLE_PACKAGE",
        [1651898027] = "PICKUP_PORTABLE_PACKAGE_LARGE_RADIUS",
        [-405862452] = "PICKUP_SUBMARINE",
        [1125567497] = "PICKUP_VEHICLE_ARMOUR_STANDARD",
        [-1514616151] = "PICKUP_VEHICLE_CUSTOM_SCRIPT",
        [1104334678] = "PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW",
        [83435908] = "PICKUP_VEHICLE_CUSTOM_SCRIPT_NO_ROTATE",
        [160266735] = "PICKUP_VEHICLE_HEALTH_STANDARD",
        [-34700440] = "PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW",
        [1704231442] = "PICKUP_VEHICLE_MONEY_VARIABLE",
        [-863291131] = "PICKUP_VEHICLE_WEAPON_APPISTOL",
        [1751145014] = "PICKUP_VEHICLE_WEAPON_ASSAULTSMG",
        [-794112265] = "PICKUP_VEHICLE_WEAPON_COMBATPISTOL",
        [-1491601256] = "PICKUP_VEHICLE_WEAPON_GRENADE",
        [-1200951717] = "PICKUP_VEHICLE_WEAPON_MICROSMG",
        [-2066319660] = "PICKUP_VEHICLE_WEAPON_MOLOTOV",
        [-1521817673] = "PICKUP_VEHICLE_WEAPON_PISTOL",
        [-744254618] = "PICKUP_VEHICLE_WEAPON_PISTOL50",
        [772217690] = "PICKUP_VEHICLE_WEAPON_SAWNOFF",
        [-864236261] = "PICKUP_VEHICLE_WEAPON_SMG",
        [1705498857] = "PICKUP_VEHICLE_WEAPON_SMOKEGRENADE",
        [746606563] = "PICKUP_VEHICLE_WEAPON_STICKYBOMB",
        [-1296747938] = "PICKUP_WEAPON_ADVANCEDRIFLE",
        [996550793] = "PICKUP_WEAPON_APPISTOL",
        [-214137936] = "PICKUP_WEAPON_ASSAULTRIFLE",
        [-2121850769] = "PICKUP_WEAPON_ASSAULTRIFLE_MK2",
        [-1835415205] = "PICKUP_WEAPON_ASSAULTSHOTGUN",
        [1948018762] = "PICKUP_WEAPON_ASSAULTSMG",
        [-1127890446] = "PICKUP_WEAPON_AUTOSHOTGUN",
        [-2115084258] = "PICKUP_WEAPON_BAT",
        [158843122] = "PICKUP_WEAPON_BATTLEAXE",
        [-95310859] = "PICKUP_WEAPON_BOTTLE",
        [-2124585240] = "PICKUP_WEAPON_BULLPUPRIFLE",
        [-1945122029] = "PICKUP_WEAPON_BULLPUPRIFLE_MK2",
        [1850631618] = "PICKUP_WEAPON_BULLPUPSHOTGUN",
        [-546236071] = "PICKUP_WEAPON_CARBINERIFLE",
        [-1109887812] = "PICKUP_WEAPON_CARBINERIFLE_MK2",
        [-1298986476] = "PICKUP_WEAPON_COMBATMG",
        [-1457529717] = "PICKUP_WEAPON_COMBATMG_MK2",
        [2023061218] = "PICKUP_WEAPON_COMBATPDW",
        [-1989692173] = "PICKUP_WEAPON_COMBATPISTOL",
        [-253098439] = "PICKUP_WEAPON_COMPACTLAUNCHER",
        [266812085] = "PICKUP_WEAPON_COMPACTRIFLE",
        [-2027042680] = "PICKUP_WEAPON_CROWBAR",
        [-1074893765] = "PICKUP_WEAPON_DAGGER",
        [-102572257] = "PICKUP_WEAPON_DBSHOTGUN",
        [990867623] = "PICKUP_WEAPON_DOUBLEACTION",
        [582047296] = "PICKUP_WEAPON_FIREWORK",
        [-1118969278] = "PICKUP_WEAPON_FLAREGUN",
        [-1112080475] = "PICKUP_WEAPON_FLASHLIGHT",
        [1577485217] = "PICKUP_WEAPON_GRENADE",
        [779501861] = "PICKUP_WEAPON_GRENADELAUNCHER",
        [1393009900] = "PICKUP_WEAPON_GUSENBERG",
        [-1997886297] = "PICKUP_WEAPON_GolfClub",
        [693539241] = "PICKUP_WEAPON_HAMMER",
        [1311775952] = "PICKUP_WEAPON_HATCHET",
        [-1661912808] = "PICKUP_WEAPON_HEAVYPISTOL",
        [-1093374267] = "PICKUP_WEAPON_HEAVYSHOTGUN",
        [1765114797] = "PICKUP_WEAPON_HEAVYSNIPER",
        [-16088425] = "PICKUP_WEAPON_HEAVYSNIPER_MK2",
        [-1071729032] = "PICKUP_WEAPON_HOMINGLAUNCHER",
        [663586612] = "PICKUP_WEAPON_KNIFE",
        [-40063266] = "PICKUP_WEAPON_KNUCKLE",
        [-668632385] = "PICKUP_WEAPON_MACHETE",
        [-171582756] = "PICKUP_WEAPON_MACHINEPISTOL",
        [-1965167499] = "PICKUP_WEAPON_MARKSMANPISTOL",
        [127042729] = "PICKUP_WEAPON_MARKSMANRIFLE",
        [-1621765815] = "PICKUP_WEAPON_MARKSMANRIFLE_MK2",
        [-2050315855] = "PICKUP_WEAPON_MG",
        [496339155] = "PICKUP_WEAPON_MICROSMG",
        [792114228] = "PICKUP_WEAPON_MINIGUN",
        [-747492773] = "PICKUP_WEAPON_MINISMG",
        [768803961] = "PICKUP_WEAPON_MOLOTOV",
        [1983869217] = "PICKUP_WEAPON_MUSKET",
        [1587637620] = "PICKUP_WEAPON_NIGHTSTICK",
        [-962731009] = "PICKUP_WEAPON_PETROLCAN",
        [-1352061783] = "PICKUP_WEAPON_PIPEBOMB",
        [-105925489] = "PICKUP_WEAPON_PISTOL",
        [1817941018] = "PICKUP_WEAPON_PISTOL50",
        [1234831722] = "PICKUP_WEAPON_PISTOL_MK2",
        [155106086] = "PICKUP_WEAPON_POOLCUE",
        [1649373715] = "PICKUP_WEAPON_PROXMINE",
        [-1456120371] = "PICKUP_WEAPON_PUMPSHOTGUN",
        [1572258186] = "PICKUP_WEAPON_PUMPSHOTGUN_MK2",
        [-462548556] = "PICKUP_WEAPON_RAILGUN",
        [1959050722] = "PICKUP_WEAPON_RAYCARBINE",
        [1000920287] = "PICKUP_WEAPON_RAYMINIGUN",
        [-482150160] = "PICKUP_WEAPON_RAYPISTOL",
        [1632369836] = "PICKUP_WEAPON_REVOLVER",
        [1835046764] = "PICKUP_WEAPON_REVOLVER_MK2",
        [1295434569] = "PICKUP_WEAPON_RPG",
        [-1766583645] = "PICKUP_WEAPON_SAWNOFFSHOTGUN",
        [978070226] = "PICKUP_WEAPON_SMG",
        [-282365040] = "PICKUP_WEAPON_SMG_MK2",
        [483787975] = "PICKUP_WEAPON_SMOKEGRENADE",
        [-30788308] = "PICKUP_WEAPON_SNIPERRIFLE",
        [-977852653] = "PICKUP_WEAPON_SNSPISTOL",
        [1038697149] = "PICKUP_WEAPON_SNSPISTOL_MK2",
        [157823901] = "PICKUP_WEAPON_SPECIALCARBINE",
        [94531552] = "PICKUP_WEAPON_SPECIALCARBINE_MK2",
        [2081529176] = "PICKUP_WEAPON_STICKYBOMB",
        [-862936205] = "PICKUP_WEAPON_STONE_HATCHET",
        [-48884066] = "PICKUP_WEAPON_STUNGUN",
        [-572254182] = "PICKUP_WEAPON_SWITCHBLADE",
        [-336028321] = "PICKUP_WEAPON_VINTAGEPISTOL",
        [-451800215] = "PICKUP_WEAPON_WRENCH",
        [-1569615261] = "WEAPON_UNARMED",
        [-1716189206] = "WEAPON_KNIFE",
        [-656458692] = "WEAPON_KNUCKLE",
        [1737195953] = "WEAPON_NIGHTSTICK",
        [1317494643] = "WEAPON_HAMMER",
        [-1786099057] = "WEAPON_BAT",
        [1141786504] = "WEAPON_GOLFCLUB",
        [-2067956739] = "WEAPON_CROWBAR",
        [-102323637] = "WEAPON_BOTTLE",
        [-1834847097] = "WEAPON_DAGGER",
        [-102973651] = "WEAPON_HATCHET",
        [-581044007] = "WEAPON_MACHETE",
        [-1951375401] = "WEAPON_FLASHLIGHT",
        [-538741184] = "WEAPON_SWITCHBLADE",
        [453432689] = "WEAPON_PISTOL",
        [-1075685676] = "WEAPON_PISTOL_MK2",
        [1593441988] = "WEAPON_COMBATPISTOL",
        [584646201] = "WEAPON_APPISTOL",
        [-1716589765] = "WEAPON_PISTOL50",
        [-1076751822] = "WEAPON_SNSPISTOL",
        [-771403250] = "WEAPON_HEAVYPISTOL",
        [137902532] = "WEAPON_VINTAGEPISTOL",
        [911657153] = "WEAPON_STUNGUN",
        [1198879012] = "WEAPON_FLAREGUN",
        [-598887786] = "WEAPON_MARKSMANPISTOL",
        [-1045183535] = "WEAPON_REVOLVER",
        [324215364] = "WEAPON_MICROSMG",
        [736523883] = "WEAPON_SMG",
        [-1121678507] = "WEAPON_MINISMG",
        [2024373456] = "WEAPON_SMG_MK2",
        [-270015777] = "WEAPON_ASSAULTSMG",
        [-1660422300] = "WEAPON_MG",
        [2144741730] = "WEAPON_COMBATMG",
        [-608341376] = "WEAPON_COMBATMG_MK2",
        [171789620] = "WEAPON_COMBATPDW",
        [1627465347] = "WEAPON_GUSENBERG",
        [-1355376991] = "WEAPON_RAYPISTOL",
        [-619010992] = "WEAPON_MACHINEPISTOL",
        [-1074790547] = "WEAPON_ASSAULTRIFLE",
        [961495388] = "WEAPON_ASSAULTRIFLE_MK2",
        [-2084633992] = "WEAPON_CARBINERIFLE",
        [-86904375] = "WEAPON_CARBINERIFLE_MK2",
        [-1357824103] = "WEAPON_ADVANCEDRIFLE",
        [-1063057011] = "WEAPON_SPECIALCARBINE",
        [2132975508] = "WEAPON_BULLPUPRIFLE",
        [1649403952] = "WEAPON_COMPACTRIFLE",
        [487013001] = "WEAPON_PUMPSHOTGUN",
        [2017895192] = "WEAPON_SAWNOFFSHOTGUN",
        [-1654528753] = "WEAPON_BULLPUPSHOTGUN",
        [-494615257] = "WEAPON_ASSAULTSHOTGUN",
        [-1466123874] = "WEAPON_MUSKET",
        [984333226] = "WEAPON_HEAVYSHOTGUN",
        [-275439685] = "WEAPON_DBSHOTGUN",
        [100416529] = "WEAPON_SNIPERRIFLE",
        [205991906] = "WEAPON_HEAVYSNIPER",
        [177293209] = "WEAPON_HEAVYSNIPER_MK2",
        [-952879014] = "WEAPON_MARKSMANRIFLE",
        [-1568386805] = "WEAPON_GRENADELAUNCHER",
        [1305664598] = "WEAPON_GRENADELAUNCHER_SMOKE",
        [-1312131151] = "WEAPON_RPG",
        [1752584910] = "WEAPON_STINGER",
        [2138347493] = "WEAPON_FIREWORK",
        [1672152130] = "WEAPON_HOMINGLAUNCHER",
        [-1813897027] = "WEAPON_GRENADE",
        [741814745] = "WEAPON_STICKYBOMB",
        [-1420407917] = "WEAPON_PROXMINE",
        [1119849093] = "WEAPON_MINIGUN",
        [1834241177] = "WEAPON_RAILGUN",
        [-1810795771] = "WEAPON_POOLCUE",
        [-1600701090] = "WEAPON_BZGAS",
        [-37975472] = "WEAPON_SMOKEGRENADE",
        [615608432] = "WEAPON_MOLOTOV",
        [101631238] = "WEAPON_FIREEXTINGUISHER",
        [883325847] = "WEAPON_PETROLCAN",
        [126349499] = "WEAPON_SNOWBALL",
        [1233104067] = "WEAPON_FLARE",
        [600439132] = "WEAPON_BALL",
    }
end

GameHashes.getModel = function(typ, hash) 
    if not GameHashes[typ] then return "unknown" end
    if not GameHashes[typ][hash] then return "unknown" end
    if not GameHashes[typ][hash].model then return "unknown" end
    return GameHashes[typ][hash].model 
end
---------- ./src/g_hashes.lua ----------

---------- ./src/s_events.lua ----------
if not CEvents then CEvents = {} end
CEvents.remote = {}
CEvents.receiver = {}
CEvents.eventNumber = 100
CEvents.cache = {}

CEvents.callRemote = function(identifier, playerId, ...)
    local check = ""
    local args = json.encode({...})

    local index = identifier .. args
    if not CEvents.cache[index] then
        identifier = CEvents.encode(identifier)
        check = identifier .. ":|:" .. CEvents.encode(#args)

        CEvents.cache[index] = json.encode({CEvents.encode(check), CEvents.encode(args)})
    end

    return TriggerLatentClientEvent('vision:clientReceiver'..tostring((tonumber(playerId) % CEvents.eventNumber) + 1), tonumber(playerId), 5000, CEvents.cache[index])
end

CEvents.registerRemote = function(identifier, callback)
    CEvents.remote[identifier] = callback

    return identifier
end

local receiver = function(data)
    data = json.decode(data)
    local check, args = table.unpack(data)
    args = CEvents.decode(args)

    check = CEvents.decode(check)
    check = CResource.stringSplit(check, ":|:")
    local identifier = CEvents.decode(check[1])

    if not CEvents.remote[identifier] then
        return CancelEvent()
    end

    if tonumber(CEvents.decode(check[2])) ~= #args then
        return CancelEvent()
    end

    args = json.decode(args)
    CEvents.remote[identifier](table.unpack(args))
    return true
end

for i=1,CEvents.eventNumber do 
    RegisterServerEvent("vision:serverReceiver"..tostring(i))
    CEvents.receiver[i] = AddEventHandler("vision:serverReceiver"..tostring(i), receiver)
end
---------- ./src/s_events.lua ----------

---------- ./src/g_threads.lua ----------
CThreads = {}
CThreads.tick = 0
CThreads.wait = 25
CThreads.maxTick = 0
CThreads.threads = {}

if IsDuplicityVersion() then
    CThreads.wait = 5000
end

CThreads.thread = Citizen.CreateThread(function()
    while true do
        if CThreads.tick == CThreads.maxTick then
            CThreads.tick = 0
        end

        CThreads.tick = CThreads.tick + 1

        local tick = CThreads.tick
        tick = tick * CThreads.wait
        for wait, functions in next,CThreads.threads,nil do
            if (tick % wait == 0) then
                for i = 1, #functions do
                    local fnc = functions[i]
                    fnc[1](table.unpack(fnc[2]))
                end
            end
        end

        Citizen.Wait(CThreads.wait)
    end
end)

CThreads.create = function(wait, callback, ...)
    if wait and callback then
        local args = {...}
        wait = tonumber(wait)
        
        if not CThreads.threads[wait] then
            CThreads.threads[wait] = {}
        end

        local index = #CThreads.threads[wait] + 1
        local identifier = wait .. ":" .. index
        CThreads.threads[wait][index] = {callback, args}

        if wait / CThreads.wait > CThreads.maxTick then
            CThreads.maxTick = math.floor(wait / CThreads.wait)
        end

        return identifier
    end
end

CThreads.destroy = function(identifier)
    if identifier and type(identifier) == "string" then
        identifier = CResource.stringSplit(identifier, ":")
        identifier[1] = tonumber(identifier[1])
        identifier[2] = tonumber(identifier[2])

        if identifier[1] and CThreads.threads[identifier[1]] then
            if identifier[2] and CThreads.threads[identifier[1]][identifier[2]] then
                table.remove(CThreads.threads[identifier[1]], identifier[2])
            end
        end
    end
end
---------- ./src/g_threads.lua ----------

---------- ./src/s_players.lua ----------
CPlayers.players = {}

CPlayers.bypasses = {
    ["full"] = "vacadministrator", --
    ["menu"] = "vacmenuacces",
    ["vpn"] = "vacbypassvpn", --
    ["spectate"] = "vacbypassspectate", --
    ["globalban"] = "vacglobalbanbypass", --
    ["dmv"] = "vacbypassdmv", --
    ["vacadministrator"] = {},
    ["vacbypassvpn"] = {},
    ["vacmenuacces"] = {},
    ["vacbypassspectate"] = {},
    ["vacglobalbanbypass"] = {},
    ["vacbypassdmv"] = {},
}

CPlayers.bypassCache = {}

CPlayers._init = function()
    CPlayers.connecting = AddEventHandler("playerConnecting", function(pName, kRez, def)
        local src = source
        
        def.defer()
	Wait(0)
        CPlayers.loadPlayer(src, def)
    end)

    CPlayers.joinning = AddEventHandler("playerJoining", function(oldID)
        CPlayers.players[source] = CPlayers.players[tonumber(oldID)]
        CPlayers.players[tonumber(oldID)] = nil

        if CConfig.settings.Server.disconnect.log.active then 
            CResource.info(string.format(CLanguage.get("log_playerconnect"), GetPlayerName(source), GetPlayerEndpoint(source)))
        end
        if CConfig.settings.Server.disconnect.log.discord then 
            CWebhook.send("connection", nil, CLanguage.get("playerconnect"), string.format(CLanguage.get("playerconnect_desc"), GetPlayerName(source), GetPlayerEndpoint(source)))
        end
    end)

    CPlayers.getIdentifiers = function(src)
        if src == nil then return {} end
        local identifiers = {}
        
        identifiers["license"] = "N/A"
        identifiers["ip"] = "N/A"
        identifiers["xbl"] = "N/A"
        identifiers["steam"] = "N/A"
        identifiers["live"] = "N/A"
        identifiers["discord"] = "N/A"
        identifiers["fivem"] = "N/A"

        for _, identifier in next,GetPlayerIdentifiers(src),nil do 
            local split = CResource.stringSplit(identifier, ":")
            identifiers[split[1]] = split[2]
        end

        return identifiers
    end

    CPlayers.getTokens = function(src)
        local numToken = GetNumPlayerTokens(src)
        local tokens = {}
        for i=0,numToken do ins(tokens, GetPlayerToken(src, i)) end

        return tokens
    end

    CPlayers.dropped = AddEventHandler("playerDropped", function(reason)
        CPlayers.players[source] = nil

        if CConfig.settings.Server.disconnect.log.active then 
            CResource.info(string.format(CLanguage.get("log_playerdisconnect"), GetPlayerName(source), GetPlayerEndpoint(source)))
        end
        if CConfig.settings.Server.disconnect.log.discord then 
            CWebhook.send("disconnection", tonumber("ff0000", 16), CLanguage.get("playerdisconnect"), string.format(CLanguage.get("playerdisconnect_desc"), GetPlayerName(source), GetPlayerEndpoint(source), reason))
        end
    end)

    CPlayers.hasBypass = function(src, bypass) 
        --[[local cacheidentif = table.concat({src,bypass}, "|")
        if CPlayers.bypassCache[cacheidentif] then
            return CPlayers.bypassCache[cacheidentif]
        end]]
        bypass = CPlayers.bypasses[CPlayers.bypasses[bypass]]

        local identifiers = (CPlayers.players[src] and CPlayers.players[src].identifiers or CPlayers.getIdentifiers(src))
        for _,identifier in next,identifiers,nil do 
            if bypass[identifier] then 
             --   CPlayers.bypassCache[cacheidentif] = true
                return true
            end
        end

        -- CPlayers.bypassCache[cacheidentif] = false
        return false
    end

    CPlayers.loadPlayer = function(src, def)
        if def then 
            def.update(CLanguage.get("checking_bans"))
        end
        local identifiers = CPlayers.getIdentifiers(src)
        local ip = GetPlayerEndpoint(src)
        local tokens = CPlayers.getTokens(src)

        if identifiers["license"] == "N/A" then 
            if def then
                return def.done(CConfig.settings.BanSystem.message)
            else
                return DropPlayer(src, CConfig.settings.BanSystem.message)
            end
        end

        CPlayers.players[src] = {
            identifiers = identifiers,
            ip = ip,
            tokens = tokens
        }

        local processResult = CBans.process(identifiers, tokens)
        if type(processResult) == "table" then 
            if def then
                return def.done("\nVisionAC: "..CConfig.settings.BanSystem.message.."\n\nBan ID: "..processResult.id)
            else
                return DropPlayer(src, "\nVisionAC: "..CConfig.settings.BanSystem.message.."\n\nBan ID: "..processResult.id)
            end
        end

        if def then 
            def.done() 
        end

        CPlayers.players[src].identifiers = CPlayers.getIdentifiers(src)
    end

    for _, src in next,GetPlayers(),nil do 
        CPlayers.loadPlayer(tonumber(src))
    end
end
---------- ./src/s_players.lua ----------

---------- ./src/g_resource.lua ----------
ESX = nil
TriggerEvent("esx:getSharedObject",function(obj) ESX = obj end)

CResource = {}

CResource.version = "3.0.0"
CResource.newest = nil
CResource.language = "RO"
CResource.name = GetCurrentResourceName()
if IsDuplicityVersion() then
    CResource.startTime = os.time()
end

CResource.processArgs = function(...)
    local args = {...}
    for index, arg in pairs(args) do
        local argType = type(arg)
        if argType ~= "string" then
            if argType == "table" then
                args[index] = json.encode(arg)
            else
                args[index] = tostring(arg)
            end
        end
    end
    return cnct(args, ", ")
end

CResource.print = function(...) print("^7[^2SCYTE VisionAC^7] [Print] " .. CResource.processArgs(...)) end

CResource.info = function(...) print("^7[^2SCYTE VisionAC^7] [^2Info^7] " .. CResource.processArgs(...)) end

CResource.debug = function(...) print("^7[^2SCYTE VisionAC^7] [^5Debug^7] " .. CResource.processArgs(...)) end

CResource.warning = function(...) print("^7[^2SCYTE VisionAC^7] [^8Warning^7] " .. CResource.processArgs(...)) end

CResource.error = function(...) print("^7[^2SCYTE VisionAC^7] [^1Error^7] " .. CResource.processArgs(...)) end

local splitCache = {}

CResource.stringSplit = function(s, delimiter)
    local cacheIdentifier = table.concat({s, "|", delimiter})
    if splitCache[cacheIdentifier] then
        return splitCache[cacheIdentifier]
    end

    result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        ins(result, match)
    end
    splitCache[cacheIdentifier] = result
    return result
end

if IsDuplicityVersion() then
    Citizen.SetTimeout(5, function()
        print(" ")
        CResource.info([[^2    /$$    /$$ /$$           /$$                      /$$$$$$   /$$$$$$ ^0]])
        CResource.info([[^2   | $$   | $$|__/          |__/                     /$$__  $$ /$$__  $$^0]])
        CResource.info([[^2   | $$   | $$ /$$  /$$$$$$$ /$$  /$$$$$$  /$$$$$$$ | $$  \ $$| $$  \__/^0]])
        CResource.info([[^2   |  $$ / $$/| $$ /$$_____/| $$ /$$__  $$| $$__  $$| $$$$$$$$| $$      ^0]])
        CResource.info([[^2    \  $$ $$/ | $$|  $$$$$$ | $$| $$  \ $$| $$  \ $$| $$__  $$| $$      ^0]])
        CResource.info([[^2     \  $$$/  | $$ \____  $$| $$| $$  | $$| $$  | $$| $$  | $$| $$    $$^0]])
        CResource.info([[^2      \  $/   | $$ /$$$$$$$/| $$|  $$$$$$/| $$  | $$| $$  | $$|  $$$$$$/^0]])
        CResource.info([[^2       \_/    |__/|_______/ |__/ \______/ |__/  |__/|__/  |__/ \______/ ^0]])
        CResource.info(" ")
        CResource.info([[============ ^2https://vision.scyte.ro^0 | ^2https://scyte.ro/discord^0 ============^0]])
        CResource.info(" ")
    end)
end
---------- ./src/g_resource.lua ----------

---------- ./src/modules/api/s_api.lua ----------

if not CApi then CApi = {} end
CApi._init = function()
    CApi.calls = {}

    CApi.sendWebhook = function(url, callback, data, ...)
        CApi.internal(url, callback, {...}, data, 'POST', {["Content-Type"] = "application/json"})
    end

    CApi.get = function(url, callback, ...)
        CApi.internal(url, callback, {...}, {}, 'GET', {})
    end

    CApi.internal = function(url, callback, callbackArgs, data, method, headers)
        data = data or {}
        headers = headers or {}
        method = method or 'GET'

        local requestData = {
            method = method,
            headers = headers,
            url = url,
            data = json.encode(data)
        }

        requestData = json.encode(requestData)
        local identifier = PerformHttpRequestInternal(requestData, #requestData)

        CApi.calls[identifier] = {callback, callbackArgs}
        return true
    end

    CApi.listener = AddEventHandler('__cfx_internal:httpResponse', function(identifier, status, body, headers)
        if CApi.calls[identifier] then
            CApi.calls[identifier][1](status, body, headers, table.unpack(CApi.calls[identifier][2]))
            CApi.calls[identifier] = nil
            return true
        end

        return false
    end)
end

CApi._init()
---------- ./src/modules/api/s_api.lua ----------

---------- ./src/modules/vpn/s_vpn.lua ----------

CVPN._init = function()
    CVPN.joinEvent = CEvents.register("vision:antivpn", function(source, name, setKickReason, def, ip)
        if CConfig.settings.AntiVPN.active then
            local src = source

            def.update(CLanguage.get("checking_vpn"))

            if ip then 
                CApi.get("http://check.getipintel.net/check.php?ip="..ip.."&contact=scyte.technologies@gmail.com&flags=f", function(err, res, head, src, deff, ip)
                    if tonumber(res or "0") == 1.00 and not CPlayers.hasBypass(src, "vpn") then 
                        CSanctions.drop(src, 1, nil, nil, deff)
                        if CConfig.settings.AntiVPN.discordLog then 
                            
                            local identifiers = {}
                            ins(identifiers, CLanguage.get("antivpn_desc"))
                            for cat, val in pairs(CPlayers.players[src]["identifiers"]) do
                                ins(identifiers, "**" .. cat:gsub("^%l", string.upper) .. ":** `" .. val .. "`")
                            end
                            ins(identifiers, "**Rata Succes:** `" .. tonumber(res) * 100 .. "%%`")
    
                            CWebhook.send("vpn", tonumber("ff0000", 16), CLanguage.get("antivpn"), string.format(cnct(identifiers, "\n")))
                        end
                    else
                        deff.done()
                    end
                end, src, def, ip)
            else 
                if def then def.done() end
            end
        end
    end)
end
---------- ./src/modules/vpn/s_vpn.lua ----------

---------- ./src/modules/bans/s_bans.lua ----------
CBans._init = function()
    CBans.file = "bans.vac"
    CBans.list = {}
    CBans.adminList = {}

    CBans.load = function()
        if io.fileExists("bans.vac") then 
            CBans.list = json.decode(io.readAll("bans.vac")) or {}

            for _,ban in next,CBans.list,nil do
                ins(CBans.adminList, { id = ban.id, name = ban.name })
            end

        else io.overwrite("bans.vac", json.encode(CBans.list)) end
        collectgarbage("collect")
    end

    CBans.saveBans = function()
        io.overwrite("bans.vac", json.encode(CBans.list))
    end

    CBans.addBan = function(src, reason)
        local banid = tostring(math.random(1000000, 999999999))
        while CBans.list[banid] do banid = tostring(math.random(1000000, 999999999)) end

        CBans.list[banid] = {
            id = banid,
            name = GetPlayerName(src),
            reason = reason,
            identifiers = CPlayers.players[src] and CPlayers.players[src].identifiers or CPlayers.getIdentifiers(src),
            tokens = CPlayers.players[src] and CPlayers.players[src].tokens or CPlayers.getTokens(src),
        }

        CBans.saveBans()

        ins(CBans.adminList, { id = banid, name = CBans.list[banid].name })
        for _,src in next,CMenu.adminPlayers,nil do 
            CEvents.callRemote("vision:admin:banList", tonumber(src), CBans.adminList)
        end

        return banid
    end

    CBans.removeBan = function(banid) 
        if CBans.list[banid] then 
            CBans.list[banid] = nil
            for ind,player in next,CBans.adminList,nil do
                if player.id == banid then
                    table.remove( CBans.adminList, ind )
                    break
                end
            end

            for _,src in next,CMenu.adminPlayers,nil do 
                CEvents.callRemote("vision:admin:banList", tonumber(src), CBans.adminList)
            end

            CBans.saveBans()
            return true
        end
        return false
    end

    CBans.process = function(identifiers, tokens)
        for identifier, value in pairs(identifiers) do
            if value == "N/A" then
                identifiers[identifier] = ""
            end
        end

        for banid, ban in pairs(CBans.list) do
            if ban.identifiers then 
                if ban.identifiers["license"] == identifiers["license"] or ban.identifiers["ip"] == identifiers["ip"]
                    or ban.identifiers["xbl"] == identifiers["xbl"] or ban.identifiers["steam"] == identifiers["steam"]
                    or ban.identifiers["live"] == identifiers["live"] or ban.identifiers["discord"] == identifiers["discord"] then
                    return ban
                end
            end

            if ban.tokens then 
                for i = 1, #tokens do
                    if ban.tokens[i] and ban.tokens[i] == tokens[i] then
                        return ban
                    end
                end
            end
        end

        return false
    end

    CBans.load()
end

CBans._init()
---------- ./src/modules/bans/s_bans.lua ----------

---------- ./src/modules/menu/s_menu.lua ----------
CMenu = {}
CMenu.players = {}
CMenu.adminPlayers = {}
CMenu.playerss = {}

CMenu._init = function()
    CMenu.loadPlayer = function(src) 
        ins(CMenu.players, { source = src, name = GetPlayerName(src), identifiers = CPlayers.getIdentifiers(src) })
    end

    CMenu.sendNotify = function(src, title, description, ...)
        local srrc = tonumber(source)
        if not CMenu.playerss[srrc] then return end
        local src = source
        local identifiers = CPlayers.players[src] and CPlayers.players[src].identifiers or CPlayers.getIdentifiers(src)
        CWebhook.send("amenulogs", tonumber("00b869", 16), CLanguage.get(title), string.format(CLanguage.get(description), table.unpack({...}) or "", GetPlayerName(src), CPlayers.players[src].identifiers["license"]))
    end

    CMenu.sendWebhook = CEvents.registerRemote("vision:admin:sendWebhookNotify", function(title, description, ...)
        CMenu.sendNotify(source, title, description, ...)
    end)

    CMenu.unban = CEvents.registerRemote("vision:admin:unbanPlayerServer", function(banid)
        local src = tonumber(source)
        if not CMenu.playerss[src] then return end
        CEvents.callRemote("vision:admin:unbanPlayer", source, CBans.removeBan(banid), banid)
    end)


    CMenu.joinning = AddEventHandler("playerJoining", function(oldID)
        local srrc = source
        CMenu.loadPlayer(srrc)
        if CPlayers.hasBypass(tonumber(srrc), "menu") then 
            ins(CMenu.adminPlayers, srrc)
            CMenu.playerss[tonumber(srrc)] = true
        end

        Citizen.SetTimeout(1000, function()
            for _, src in next,CMenu.adminPlayers,nil do 
                CEvents.callRemote("vision:admin:playerList", tonumber(src), CMenu.players)
                CEvents.callRemote("vision:admin:banList", tonumber(src), CBans.adminList)
            end
        end)
    end)

    CMenu.leaving = AddEventHandler("playerDropped", function(reason)
        local src = tonumber(source)
        CMenu.playerss[src] = nil
        for i=1,#CMenu.adminPlayers do 
            if CMenu.adminPlayers[i] == src then 
                table.remove(CMenu.adminPlayers, i)
                break
            end
        end

        for i = 1, #CMenu.players do
            if CMenu.players[i].source == src then
                table.remove(CMenu.players, i)
                break
            end
        end

        Citizen.SetTimeout(1000, function()
            for _,src in next,CMenu.adminPlayers,nil do 
                CEvents.callRemote("vision:admin:playerList", tonumber(src), CMenu.players)
                CEvents.callRemote("vision:admin:banList", tonumber(src), CBans.adminList)
            end
        end)
    end)

    CMenu.adminPlayerGiveWeapon = CEvents.registerRemote("menu:adminPlayerGiveWeapon", function(data)
        local src = tonumber(source)
        if not CMenu.playerss[src] then return end
        GiveWeaponToPed(GetPlayerPed(tonumber(data.player)), GetHashKey(data.weaponmodel), CConfig.settings.AntiAmmoCheating.maxAmmo - 1, false, false)
        CEvents.callRemote("vision:admin:notify", source, "success", CLanguage.get("weapon_admin_menu"), string.format(CLanguage.get("weapon_given_admin_menu"), data.weaponmodel))
    end)

    CMenu.adminPlayerGiveWeaponAll = CEvents.registerRemote("menu:adminPlayerGiveWeaponAll", function(data)
        local src = tonumber(source)
        if not CMenu.playerss[src] then return end
        for hash,_ in next,GameHashes.weapons,nil do 
            GiveWeaponToPed(GetPlayerPed(tonumber(data.player)), hash, CConfig.settings.AntiAmmoCheating.maxAmmo - 1, false, false)
        end
        
        CEvents.callRemote("vision:admin:notify", source, "success", CLanguage.get("weapon_admin_menu"), CLanguage.get("weapon_give_all_admin_menu"))
    end)

    CMenu.adminPlayerTakeWeaponAll = CEvents.registerRemote("menu:adminPlayerTakeWeaponAll", function(data)
        local src = tonumber(source)
        if not CMenu.playerss[src] then return end
        RemoveAllPedWeapons(GetPlayerPed(tonumber(data.player)), false)
           
        CEvents.callRemote("vision:admin:notify", source, "success", CLanguage.get("weapon_admin_menu"), CLanguage.get("weapon_remove_all_admin_menu"))
    end)

    CMenu.adminPlayersFixVehicle = CEvents.registerRemote("menu:adminPlayersFixVehicle", function(data)
        local src = tonumber(source)
        if not CMenu.playerss[src] then return end
        local ped = GetPlayerPed(tonumber(data.player))
        if GetVehiclePedIsIn(ped, false) == 0 then
            return CEvents.callRemote("vision:admin:notify", source, "error", CLanguage.get("vehicle_admin_menu"), CLanguage.get("no_vehicle_admin_menu"))
        end
        
        CEvents.callRemote("vision:admin:fixVehicle", tonumber(data.player), true)
        CEvents.callRemote("vision:admin:notify", source, "success", CLanguage.get("vehicle_admin_menu"), CLanguage.get("vehicle_repaired_admin_menu"))
    end)

    CMenu.adminPlayersDeleteVehicle = CEvents.registerRemote("menu:adminPlayersDeleteVehicle", function(data)
        local src = tonumber(source)
        if not CMenu.playerss[src] then return end
        local ped = GetPlayerPed(tonumber(data.player))
        if GetVehiclePedIsIn(ped, false) == 0 then
            return CEvents.callRemote("vision:admin:notify", source, "error", CLanguage.get("vehicle_admin_menu"), CLanguage.get("no_vehicle_admin_menu"))
        end
        
        CEvents.callRemote("vision:admin:deleteVehicle", tonumber(data.player), true)
        CEvents.callRemote("vision:admin:notify", source, "success", CLanguage.get("vehicle_admin_menu"), CLanguage.get("vehicle_deleted_admin_menu"))
    end)

    CMenu.clearUnusedVehicles = CEvents.registerRemote("menu:clearUnusedVehicles", function(data)
        local src = tonumber(source)
        if not CMenu.playerss[src] then return end
        local vehicles = GetAllVehicles()
        for i=1,#vehicles do
            if not DoesEntityExist(GetPedInVehicleSeat(vehicles[i], -1)) then 
                DeleteEntity(vehicles[i])
            end
        end
        
        CEvents.callRemote("vision:admin:notify", source, "success", CLanguage.get("delete_vehicles_admin_menu"), CLanguage.get("delete_unused_vehicles_admin_menu"))
    end)

    CMenu.clearAllVehicles = CEvents.registerRemote("menu:clearAllVehicles", function(data)
        local src = tonumber(source)
        if not CMenu.playerss[src] then return end
        local vehicles = GetAllVehicles()
        for i=1,#vehicles do
            DeleteEntity(vehicles[i])
        end

        CEvents.callRemote("vision:admin:notify", source, "success", CLanguage.get("delete_vehicles_admin_menu"), CLanguage.get("delete_all_vehicles_admin_menu"))
    end)

    CMenu.adminPlayersKick = CEvents.registerRemote("menu:adminPlayersKick", function(data)
        local src = tonumber(source)
        if not CMenu.playerss[src] then return end
        CSanctions.drop(tonumber(data.player), 1, "Admin Kick")
        CEvents.callRemote("vision:admin:notify", source, "success", CLanguage.get("kick_player_admin_menu"), string.format(CLanguage.get("kick_player_body_admin_menu"), GetPlayerName(tonumber(data.player)):gsub("^%l", string.upper)))
    end)

    CMenu.adminPlayersBan = CEvents.registerRemote("menu:adminPlayersBan", function(data)
        local src = tonumber(source)
        if not CMenu.playerss[src] then return end
        CSanctions.drop(tonumber(data.player), 2, "Admin Ban")
        CEvents.callRemote("vision:admin:notify", source, "success", CLanguage.get("ban_player_admin_menu"), string.format(CLanguage.get("ban_player_body_admin_menu"), GetPlayerName(tonumber(data.player)):gsub("^%l", string.upper)))
    end)

    CMenu.adminPlayersTeleport = CEvents.registerRemote("menu:adminPlayersTeleport", function(data)
        local src = tonumber(source)
        if not CMenu.playerss[src] then return end
        if not GetPlayerName(data.player) then return end
        local coords = GetEntityCoords(GetPlayerPed(tonumber(data.player)))
        local rot = GetEntityRotation(GetPlayerPed(tonumber(data.player)))

        SetEntityCoords(GetPlayerPed(source), coords.x + 2, coords.y + 2, coords.z)
        CEvents.callRemote("vision:admin:notify", source, "success", CLanguage.get("teleport_player_admin_menu"), string.format(CLanguage.get("teleport_player_body_admin_menu"), GetPlayerName(tonumber(data.player)):gsub("^%l", string.upper)))
    end)

    CMenu.adminPlayersFreeze = CEvents.registerRemote("menu:adminPlayersFreeze", function(data)
        local src = tonumber(source)
        if not CMenu.playerss[src] then return end
        if not GetPlayerName(data.player) then return end
        local src = tonumber(data.player)

        if not CPlayers.players[src].frozen then 
            CPlayers.players[src].frozen = false
        end

        CPlayers.players[src].frozen = not CPlayers.players[src].frozen
        FreezeEntityPosition(GetPlayerPed(src), CPlayers.players[src].frozen)
        CEvents.callRemote("vision:menu:setFrozen", src, true, CPlayers.players[src].frozen)
        CMenu.sendNotify(source, "admin_log_freeze_title", "admin_log_freeze", GetPlayerName(src))
        CEvents.callRemote("vision:admin:notify", source, "success", CLanguage.get("freeze_player_admin_menu"), string.format(CLanguage.get("freeze_player_body_admin_menu"), GetPlayerName(tonumber(data.player)):gsub("^%l", string.upper)))
    end)

    for _,src in next,GetPlayers(),nil do 
        CMenu.loadPlayer(tonumber(src))
    end
end
---------- ./src/modules/menu/s_menu.lua ----------

---------- ./src/modules/events/s_nuke.lua ----------
if not CCEvents then CCEvents = {} end
CCEvents.nuke = {}

CCEvents.nuke._init = function()
    if CConfig.settings.EventsProtection.active and CConfig.settings.EventsProtection.secureNukeEvents.active then
        CCEvents.nuke._structure_ = {}

        CCEvents.nuke.listen = function(name, value)
            RegisterNetEvent(name, function(val)
                if val == value then
                    CSanctions.drop(source, CConfig.settings.EventsProtection.secureNukeEvents.detectionMode, "Server Nuke Event (" .. name .. ")", nil, nil, GetPlayerName(source))
                    CancelEvent()
                    return
                end
            end)
        end

        for i, data in pairs(CConfig.settings.EventsProtection.secureNukeEvents.list) do
            local name = string.find(data, "name = '.+'") and string.sub(data, string.find(data, "name = '.+'")):gsub("name = '", ""):gsub("'", "") or string.sub(data, string.find(data, 'name = ".+"')):gsub('name = "', ""):gsub('"', "")
            local value = ""

            if string.find(data, "value = '.+'") then
                value = string.sub(data, string.find(data, "value = '.+'")):gsub("value = '", ""):gsub("'", "")
            elseif string.find(data, 'value = ".+"') then
                value = string.sub(data, string.find(data, 'value = ".+"')):gsub('value = "', ""):gsub('"', "")
            elseif string.find(data, "value = %d+") then
                value = tonumber(string.gsub(string.sub(data, string.find(data, "value = %d+")), "value = ", ""))
            end

            if not string.find(name, "vision:clientReceiver%d") and not not string.find(name, "vision:serverReceiver%d") then
                CCEvents.nuke.listen(name, value)
            end
        end
    end
end
---------- ./src/modules/events/s_nuke.lua ----------

---------- ./src/modules/events/s_spam.lua ----------
if not CCEvents then CCEvents = {} end
CCEvents.spam = {}

CCEvents.spam._init = function()
    if CConfig.settings.EventsProtection.active and CConfig.settings.EventsProtection.limitedEvents.active then
        CCEvents.spam._structure_ = {}

        CCEvents.spam.check = function(source, name, limit)
            if not CCEvents.spam._structure_[source] then
                CCEvents.spam._structure_[source] = {}
            end

            if not CCEvents.spam._structure_[source][name] then
                CCEvents.spam._structure_[source][name] = {time = os.time(), limit = limit, count = 1}
                return
            end

            local eventData = CCEvents.spam._structure_[source][name]
            if os.difftime(os.time(), eventData.time) >= CConfig.settings.EventsProtection.limitedEvents.resetTime then
                CCEvents.spam._structure_[source][name] = {time = os.time(), limit = limit, count = 1}
            elseif eventData.count >= eventData.limit then
                CSanctions.drop(source, CConfig.settings.EventsProtection.limitedEvents.detectionMode, "Event Spam Limit (" .. name .. ")", nil, nil, GetPlayerName(source))
                CCEvents.spam._structure_[source] = nil
                return CancelEvent()
            else
                CCEvents.spam._structure_[source][name].count = eventData.count + 1
            end
        end

        CCEvents.spam.listen = function(name, limit)
            RegisterNetEvent(name, function()
                CCEvents.spam.check(source, name, limit)
            end)
        end

        for i, data in pairs(CConfig.settings.EventsProtection.limitedEvents.list) do
            local name = string.find(data, "name = '.+'") and string.sub(data, string.find(data, "name = '.+'")):gsub("name = '", ""):gsub("'", "") or string.sub(data, string.find(data, 'name = ".+"')):gsub('name = "', ""):gsub('"', "")
            local limit = string.gsub(string.sub(data, string.find(data, "limit = %d+")), "limit = ", "")

            if not string.find(name, "vision:clientReceiver%d") and not not string.find(name, "vision:serverReceiver%d") then
                CCEvents.spam.listen(name, limit)
            end
        end
    end
end
---------- ./src/modules/events/s_spam.lua ----------

---------- ./src/modules/words/s_words.lua ----------
CWords._init = function()
    if CConfig.settings.Words.active and CConfig.settings.Words.BlacklistedWords.active then 
        CWords.event = AddEventHandler("chatMessage", function(src, name, text)
            for _, word in next,CConfig.settings.Words.BlacklistedWords.words,nil do 
                if string.match(string.lower(text), string.lower(word)) then 
                    CSanctions.drop(src, CConfig.settings.Words.BlacklistedWords.detectionMode, "Blacklisted Words ("..word..")", nil, nil, name)
                    CancelEvent()
                end
            end
        end)
    end
end
---------- ./src/modules/words/s_words.lua ----------

---------- ./src/modules/player/s_carry.lua ----------
if not CPlayer then CPlayer = {} end
CPlayer.CCarry = {}

CPlayer.CCarry._init = function()
    if CConfig.settings.ClientSide.AntiCarryExploit then
        RegisterServerEvent("CarryPeople:sync")
        AddEventHandler("CarryPeople:sync", function(players)
            if players == -1 then
                return CSanctions.drop(source, 2, "Carry Exploit", nil, nil, GetPlayerName(source))
            end
        end)
    end
end
---------- ./src/modules/player/s_carry.lua ----------

---------- ./src/modules/weapons/g_main.lua ----------
if not CWeapons then CWeapons = {} end

CWeapons._init = function()
    for n, k in pairs(CWeapons) do
        if type(k) == 'table' then
            for i, v in pairs(k) do
                if i == "_init" then
                    v()
                end
            end
        end
    end
end
---------- ./src/modules/weapons/g_main.lua ----------

---------- ./src/modules/commands/s_help.lua ----------
if not CCommands then CCommands = {} end
CCommands.help = {}

CCommands.help.syntax = "help"

CCommands.help.help = function() return CLanguage.get("help_help") end

CCommands.help.exec = function()
    CResource.info(CLanguage.get("commands_list_text"))
    for _,command in next,CCommands,nil do 
        CResource.info("^2vac "..command.syntax.."^0 - "..command.help())
    end
end
---------- ./src/modules/commands/s_help.lua ----------

---------- ./src/modules/commands/s_main.lua ----------
if not CCommands then CCommands = {} end

RegisterCommand("vac", function(source, args, rawCommand)
    if not CResource.newest then return end
    if source ~= 0 then return end
    if CCommands[args[1]] then 
        local command = args[1]
        table.remove(args, 1)
        CCommands[command].exec(table.unpack(args))
    else
        CCommands["help"].exec(table.unpack(args))
    end
end, false)
---------- ./src/modules/commands/s_main.lua ----------

---------- ./src/modules/config/s_config.lua ----------
CConfig._init = function ()
    CConfig.settings = {}
    CConfig.loaded = false

    CConfig.sync = function(player)
        if not CConfig.loaded then 
            return
        end
        local temp = {}
        temp.AntiVehCheats = CConfig.settings.AntiVehCheats
        temp.ClientSide = CConfig.settings.ClientSide
        temp.AntiWeapons = CConfig.settings.AntiWeapons
        temp.AntiWeaponDamageManipulation = CConfig.settings.AntiWeaponDamageManipulation
        temp.AntiVisions = CConfig.settings.AntiVisions
        temp.AntiMenus = CConfig.settings.AntiMenus
        temp.AntiNuke = CConfig.settings.AntiNuke
        temp.AntiTinySkin = CConfig.settings.AntiTinySkin
        temp.imagecache = CConfig.settings.Webhooks.imagecache
        temp.AntiAmmoCheating = CConfig.settings.AntiAmmoCheating
        temp.EventsProtection = CConfig.settings.EventsProtection
        temp.EventsProtection = CConfig.settings.EventsProtection
        temp.AntiNuiDevTools = CConfig.settings.AntiNuiDevTools
        temp.BlacklistedPlates = CConfig.settings.BlacklistedPlates
        temp.AMenu = CConfig.settings.AMenu
        temp.BlacklistedEvents = CConfig.settings.BlacklistedEvents
        temp.BlacklistedPeds = CConfig.settings.Entities.Peds.Blacklisted
        temp.AICfxMethod = CConfig.settings.AICfxMethod.weapons

        if player == -1 then 
            for _,src in next,GetPlayers(),nil do 
                temp.bypassed = CPlayers.hasBypass(tonumber(src), "full")
                temp.bypassSpectate = CPlayers.hasBypass(tonumber(src), "spectate")
                temp.adminBypassed = CPlayers.hasBypass(tonumber(src), "menu")
                CEvents.callRemote("vision:config:receiver", tonumber(src), temp)

                if temp.adminBypassed then 
                    Citizen.SetTimeout(3000, function()
                        CEvents.callRemote("vision:admin:playerList", tonumber(src), CMenu.players)
                        CEvents.callRemote("vision:admin:banList", tonumber(src), CBans.adminList)
                    end)
                end
            end
        else 
            temp.bypassed = CPlayers.hasBypass(player, "full")
            temp.bypassSpectate = CPlayers.hasBypass(player, "spectate")
            temp.adminBypassed = CPlayers.hasBypass(player, "menu")
            CEvents.callRemote("vision:config:receiver", player, temp)

            if temp.adminBypassed then 
                Citizen.SetTimeout(3000, function()
                    CEvents.callRemote("vision:admin:playerList", player, CMenu.players)
                    CEvents.callRemote("vision:admin:banList", player, CBans.adminList)
                end)
            end
        end
    end

    CConfig.settings = json.decode(LoadResourceFile(GetCurrentResourceName(), "config.json"))

    for _,identifier in next,CConfig.settings.Bypass.Bypass,nil do CPlayers.bypasses["vacadministrator"][identifier] = true end
    for _,identifier in next,CConfig.settings.Bypass.VPN,nil do CPlayers.bypasses["vacbypassvpn"][identifier] = true end
    for _,identifier in next,CConfig.settings.Bypass.adminMenu,nil do CPlayers.bypasses["vacmenuacces"][identifier] = true end
    for _,identifier in next,CConfig.settings.Bypass.Spectate,nil do CPlayers.bypasses["vacbypassspectate"][identifier] = true end
    for _,identifier in next,CConfig.settings.Bypass.globalBans,nil do CPlayers.bypasses["vacglobalbanbypass"][identifier] = true end
    for _,identifier in next,CConfig.settings.Bypass.DMV,nil do CPlayers.bypasses["vacbypassdmv"][identifier] = true end

    CConfig.loaded = true

    SetTimeout(1000, function() 
        CPlayers._init()
        CPlayer._init()
        CVPN._init()
        CClearPedTask._init()
        CIdentifiers._init()
        CChatSpam._init()
        CVehicles._init()
        CWords._init()
        CCEvents._init()
        CAntiParticles._init()
        CWeapons.CExplosion._init()
        CWeapons.CDamage._init()
        CStopper._init()
        CMenu._init()
        CWeapons.CProtection._init()
        
        if not loaded then 
            CWebhook.send("general", nil, CLanguage.get("serverstarted"), string.format(CLanguage.get("serverstarted_desc"), CResource.version))
            CResource.info(CLanguage.get("startup_message"))
            loaded = true
        end
    end)

    CConfig.syncPl = CEvents.registerRemote("vision:config:fetch", function()
        local src = source
        CLanguage.sync(src)
        CConfig.sync(src)

        if not CPlayers.hasBypass then return end
        if CPlayers.hasBypass(src, "menu") then 
            CEvents.callRemote("vision:admin:playerList", src, CMenu.players)
            CEvents.callRemote("vision:admin:banList", src, CBans.adminList)
        end
    end)
end

CConfig._init()
---------- ./src/modules/config/s_config.lua ----------

---------- ./src/modules/events/g_events.lua ----------
if not CCEvents then CCEvents = {} end

CCEvents._init = function()
    CCEvents.blacklisted._init()
    CCEvents.spam._init()
end
---------- ./src/modules/events/g_events.lua ----------

---------- ./src/modules/player/g_player.lua ----------
if not CPlayer then CPlayer = {} end

CPlayer._init = function()
    Citizen.SetTimeout(1000, function()
        for n, k in pairs(CPlayer) do
            if type(k) == 'table' then
                for i, v in pairs(k) do
                    if i == "_init" then
                        v()
                    end
                end
            end
        end
    end)
end
---------- ./src/modules/player/g_player.lua ----------

---------- ./src/modules/vehicles/g_main.lua ----------
if not CVehicles then CVehicles = {} end

CVehicles._init = function()
    for n, k in pairs(CVehicles) do
        if type(k) == 'table' then
            for i, v in pairs(k) do
                if i == "_init" then
                    v()
                end
            end
        end
    end
end
---------- ./src/modules/vehicles/g_main.lua ----------

---------- ./src/modules/commands/s_unban.lua ----------
if not CCommands then CCommands = {} end
CCommands.unban = {}

CCommands.unban.syntax = "unban <banid>"

CCommands.unban.help = function()
    return CLanguage.get("ban_help")
end

CCommands.unban.exec = function(banid)
    if not banid then 
        CResource.info("^2vac "..CCommands.unban.syntax.."^0 - "..CCommands.unban.help())
        return
    end
    if banid == "all" then 
        local unbanned_players = 0
        for banid,_ in next,CBans.list,nil do 
            CBans.removeBan(banid)
            unbanned_players = unbanned_players + 1
        end
        CResource.info(string.format(CLanguage.get("unbanned_all"), unbanned_players))
        return
    end

    if not CBans.removeBan(banid) then 
        CResource.error(string.format(CLanguage.get("invalid_ban"), banid))
        return
    end

    CResource.info(string.format(CLanguage.get("unbanned"), banid))
    return
end
---------- ./src/modules/commands/s_unban.lua ----------

---------- ./src/modules/weapons/s_damage.lua ----------
if not CWeapons then CWeapons = {} end
CWeapons.CDamage = {}

CWeapons.CDamage._init = function()
    if CConfig.settings.AntiNuke.active and CConfig.settings.AntiNuke.killAll.active then
        CWeapons.CDamage.advancedLimit = 30

        CWeapons.CDamage.updateAdvancedLimit = function()
            local playerCount = #GetPlayers()

            if playerCount >= 150 then
                CWeapons.CDamage.advancedLimit = 30
            elseif playerCount >= 100 then
                CWeapons.CDamage.advancedLimit = 20
            elseif playerCount >= 50 then
                CWeapons.CDamage.advancedLimit = 12
            elseif playerCount >= 25 then
                CWeapons.CDamage.advancedLimit = 8
            end
        end

        CWeapons.CDamage.killAll = CEvents.registerRemote("vision:killAll", function(attacker)
            attacker = tonumber(attacker)
            if not CPlayers.players[attacker] then return end
            if not CPlayers.players[attacker].killAll then CPlayers.players[attacker].killAll = {count = 0, time = os.time()} end
            CWeapons.CDamage.updateAdvancedLimit()

            local killAll = CPlayers.players[attacker].killAll
            if os.difftime(os.time(), killAll.time) >= 7500 / 1000 then
                CPlayers.players[attacker].killAll = {count = 1, time = os.time()}
            elseif CConfig.settings.AntiNuke.killAll.mode ~= "advanced" and killAll.count >= CConfig.settings.AntiNuke.killAll.maxPlayersKilled then
                CSanctions.drop(attacker, CConfig.settings.AntiNuke.killAll.detectionMode, "Nuke Kill All (" .. CConfig.settings.AntiNuke.killAll.mode .. ")", nil, nil, GetPlayerName(attacker))
                CancelEvent()
                return
            elseif CConfig.settings.AntiNuke.killAll.mode == "advanced" and killAll.count >= CWeapons.CDamage.advancedLimit then
                CSanctions.drop(attacker, CConfig.settings.AntiNuke.killAll.detectionMode, "Nuke Kill All (" .. CConfig.settings.AntiNuke.killAll.mode .. ")", nil, nil, GetPlayerName(attacker))
                CancelEvent()
                return
            else
                CPlayers.players[attacker].killAll.count = killAll.count + 1
            end
        end)

        CWeapons.CDamage.updateAdvancedLimit()
    end
end
---------- ./src/modules/weapons/s_damage.lua ----------

---------- ./src/modules/weapons/s_protect.lua ----------
if not CWeapons then CWeapons = {} end
CWeapons.CProtection = {}

CWeapons.CProtection._init = function()
    if CConfig.settings.AntiWeapons.playerProtection.active then
        CWeapons.CProtection.giveWeapon = AddEventHandler("giveWeaponEvent", function(sender, data)
            CSanctions.drop(sender, CConfig.settings.AntiWeapons.playerProtection.detectionMode, "Player Weapon Protection (GIVE)", nil, nil, GetPlayerName(sender))
            CancelEvent()
            return
        end)

        CWeapons.CProtection.removeWeapon = AddEventHandler("RemoveWeaponEvent", function(sender, data)
            CSanctions.drop(sender, CConfig.settings.AntiWeapons.playerProtection.detectionMode, "Player Weapon Protection (REMOVE)", nil, nil, GetPlayerName(sender))
            CancelEvent()
            return
        end)

        CWeapons.CProtection.removeAllWeapons = AddEventHandler("removeAllWeaponsEvent", function(sender, data)
            CSanctions.drop(sender, CConfig.settings.AntiWeapons.playerProtection.detectionMode, "Player Weapon Protection (REMOVE_ALL)", nil, nil, GetPlayerName(sender))
            CancelEvent()
            return
        end)
    end
end
---------- ./src/modules/weapons/s_protect.lua ----------

---------- ./src/modules/webhook/s_webhook.lua ----------
CWebhook = {
    name = {
        ["general"] = "General",
        ["bans"] = "Bans",
        ["kicks"] = "Kicks",
        ["warnings"] = "Warnings",
        ["connection"] = "Connect",
        ["disconnection"] = "Disconnect",
        ["vpn"] = "VPN",
        ["errors"] = "Errors",
        ["amenulogs"] = "Admin Menu Logs",
        ["imagecache"] = "Image Cache",
        ["heartbeats"] = "Heartbeats",
    },
    timeouts = {}
}

CWebhook.get = function(webhook) return CConfig.settings.Webhooks[webhook] end

CWebhook.send = function(wtype, color, title, description)
    if string.len(CWebhook.get(wtype) or "") < 12 then return end 
    local defaultSend = { 
        username = "VisionAC - "..CWebhook.name[wtype], 
        avatar_url = "https://cdn.discordapp.com/attachments/912784317187493929/912820942978293780/vision_discord.png",
        embeds = {
            {
                ["color"] = color or 47209,
                ["type"] = "rich",
                ["timestamp"] = os.date("!%Y%m%dT%H%M%S").."Z",
                author = {
                    name = "VisionAC",
                    url = "https://scyte.ro/discord",
                    icon_url = "https://cdn.discordapp.com/attachments/912784317187493929/912820942978293780/vision_discord.png"
                },
                ["title"] = title,
                ["description"] = description,
                footer = {
                    text = "Youthful Zone SRL © 2016 - "..os.date("%Y")..". Toate drepturile rezervate."
                }
            }
        } 
    }

    if not CWebhook.timeouts[wtype] then 
        CWebhook.timeouts[wtype] = os.time()
    end
    CApi.sendWebhook(CWebhook.get(wtype), function(err, res, head)
        if math.floor(err / 100) ~= 2 and err ~= 0 and os.difftime(os.time(), CWebhook.timeouts[wtype]) > 60 then 
            CResource.error(string.format(CLanguage.get("invalid_webhook"), CWebhook.name[wtype]))
            CWebhook.timeouts[wtype] = os.time()
        end
    end, defaultSend)
end

---------- ./src/modules/webhook/s_webhook.lua ----------

---------- ./src/modules/commands/s_version.lua ----------
if not CCommands then CCommands = {} end
CCommands.version = {}

CCommands.version.syntax = "version"

CCommands.version.help = function() return CLanguage.get("version_help") end

CCommands.version.exec = function()
    CResource.info(string.format(CLanguage.get("vac_version"), CResource.version, string.format(CLanguage.get(CResource.newest == CResource.version and "vac_newestversion" or "vac_needupdate"), CResource.newest)))
end
---------- ./src/modules/commands/s_version.lua ----------

---------- ./src/modules/events/s_protected.lua ----------
if not CCEvents then CCEvents = {} end
CCEvents.protected = {}

CCEvents.protected._init = function()
    if CConfig.settings.EventsProtection.active and CConfig.settings.EventsProtection.protectedValues.active then
        CCEvents.protected._structure_ = {}

        CCEvents.protected.listen = function(name, value)
            RegisterNetEvent(name, function(val)
                if val ~= value then
                    CSanctions.drop(source, CConfig.settings.EventsProtection.protectedValues.detectionMode, "Protected Event (" .. name .. ")", nil, nil, GetPlayerName(source))
                    CancelEvent()
                    return
                end
            end)
        end

        for i, data in pairs(CConfig.settings.EventsProtection.protectedValues.list) do
            local name = string.find(data, "name = '.+'") and string.sub(data, string.find(data, "name = '.+'")):gsub("name = '", ""):gsub("'", "") or string.sub(data, string.find(data, 'name = ".+"')):gsub('name = "', ""):gsub('"', "")
            local value = ""

            if string.find(data, "value = '.+'") then
                value = string.sub(data, string.find(data, "value = '.+'")):gsub("value = '", ""):gsub("'", "")
            elseif string.find(data, 'value = ".+"') then
                value = string.sub(data, string.find(data, 'value = ".+"')):gsub('value = "', ""):gsub('"', "")
            elseif string.find(data, "value = %d+") then
                value = tonumber(string.gsub(string.sub(data, string.find(data, "value = %d+")), "value = ", ""))
            end

            if not string.find(name, "vision:clientReceiver%d") and not not string.find(name, "vision:serverReceiver%d") then
                CCEvents.protected.listen(name, value)
            end
        end
    end
end
---------- ./src/modules/events/s_protected.lua ----------

---------- ./src/modules/player/s_heartbeat.lua ----------
if not CPlayer then CPlayer = {} end
CPlayer.CHeartbeat = {}

CPlayer.CHeartbeat._init = function()
    CPlayer.CHeartbeat.__list__ = {}
    CPlayer.CHeartbeat.event = CEvents.registerRemote("vision:heartbeat:registerHeartbeat", function()
        local src = tonumber(source)
        CPlayer.CHeartbeat.__list__[src] = os.time()
        if CConfig.settings.AntiSuperJump.active then
            if IsPlayerUsingSuperJump(src) == true then 
                return CSanctions.drop(src, CConfig.settings.AntiSuperJump.detectionMode, "Super Jump", nil) 
            end
        end
    end)

    CPlayer.CHeartbeat.thread = CThreads.create(15000, function()
        for src,time in next,CPlayer.CHeartbeat.__list__,nil do 
            if os.difftime(os.time(), time) > 15 and CResource.startTime + 60 > os.time() then
                CPlayer.CHeartbeat.__list__[src] = nil
                -- return DropPlayer(src, "Couldn't handshake to server. Please rejoin.")
            end
        end
    end)

    CPlayer.CHeartbeat.respawnEvent = AddEventHandler("respawnPlayerPedEvent", function(src)
        if CPlayers.hasBypass(src, "full") == false then return end
        CPlayer.CHeartbeat.__list__[tonumber(src)] = os.time()
    end)
end
---------- ./src/modules/player/s_heartbeat.lua ----------

---------- ./src/modules/resource/s_stopper.lua ----------
CStopper = {}

CStopper._init = function()
    if CConfig.settings.ClientSide.AntiStopResource then
        CStopper.listener = CEvents.registerRemote("vision:checkResource", function(resource)
            local src = source
            local state = GetResourceState(resource)
            if state ~= "stopping" and state ~= "stopped" then 
                -- return CSanctions.drop(src, 2, "Resource Stopper ("..resource..")")
            end
        end)
    end
end
---------- ./src/modules/resource/s_stopper.lua ----------

---------- ./src/modules/vehicles/s_removed.lua ----------
CVehicles.CRemoved = {}

CVehicles.CRemoved._init = function()
    CVehicles.CRemoved.listener = AddEventHandler("entityRemoved", function(handle)
        if GetEntityType(handle) == 2 and (GetEntityPopulationType(handle) == 6 or GetEntityPopulationType(handle) == 7) then
            local src = NetworkGetEntityOwner(handle)
            src = tonumber(src)

            -- Destroy Mass Vehicles
            if CConfig.settings.Entities.Vehicles.DMV.active and CPlayers.hasBypass(src, "dmv") then
                if not CPlayers.players[src].vehiclesDestroyLimit then
                    CPlayers.players[src].vehiclesDestroyLimit = {time = os.time(), count = 1}
                end

                local vehiclesDestroyLimit = CPlayers.players[src].vehiclesDestroyLimit
                if os.difftime(os.time(), vehiclesDestroyLimit.time) >= 7500 / 1000 then
                    CPlayers.players[src].vehiclesDestroyLimit = {time = os.time(), count = 1}
                elseif vehiclesDestroyLimit.count >= CConfig.settings.Entities.Vehicles.DMV.limit then
                    return CSanctions.drop(src, CConfig.settings.Entities.Vehicles.DMV.detectionMode, "Vehicles Mass Destroy", nil, nil, GetPlayerName(src))
                else
                    CPlayers.players[src].vehiclesDestroyLimit.count = vehiclesDestroyLimit.count + 1
                end
            end
        end
    end)
end
---------- ./src/modules/vehicles/s_removed.lua ----------

---------- ./src/modules/chatspam/s_chatspam.lua ----------

CChatSpam._init = function()
    if CConfig.settings.Words.active and CConfig.settings.AntiSpam.active then 
        CChatSpam.chatEvent = AddEventHandler("chatMessage", function(src, name, text)
            if string.len(text) >= CConfig.settings.AntiSpam.limit then 
                CancelEvent()
                CSanctions.drop(src, CConfig.settings.AntiSpam.detectionMode, "Chat Spam", "You message is too long. Make it shorter.", nil, name)
            end
        end)
    end
end
---------- ./src/modules/chatspam/s_chatspam.lua ----------

---------- ./src/modules/language/s_language.lua ----------
CLanguage.file = "language.vac"
CLanguage.messages = json.decode(LoadResourceFile(CResource.name, CLanguage.file) or {})

CLanguage.sync = function(player)
    local temp = {}
    temp.vehicle_admin_menu = CLanguage.get("vehicle_admin_menu")
    temp.invalid_model_admin_menu = CLanguage.get("invalid_model_admin_menu")
    temp.vehicle_spawned_admin_menu = CLanguage.get("vehicle_spawned_admin_menu")
    temp.vehicle_repaired_admin_menu = CLanguage.get("vehicle_repaired_admin_menu")
    temp.vehicle_deleted_admin_menu = CLanguage.get("vehicle_deleted_admin_menu")
    temp.vehicle_tunned_admin_menu = CLanguage.get("vehicle_tunned_admin_menu")
    temp.no_vehicle_admin_menu = CLanguage.get("no_vehicle_admin_menu")
    temp.weapon_admin_menu = CLanguage.get("weapon_admin_menu")
    temp.weapon_invalid_admin_menu = CLanguage.get("weapon_invalid_admin_menu")
    temp.weapon_given_admin_menu = CLanguage.get("weapon_given_admin_menu")
    temp.weapon_remove_all_admin_menu = CLanguage.get("weapon_remove_all_admin_menu")
    temp.weapon_give_all_admin_menu = CLanguage.get("weapon_give_all_admin_menu")
    temp.unban_success_admin_menu = CLanguage.get("unban_success_admin_menu")
    temp.unban_failed_admin_menu = CLanguage.get("unban_failed_admin_menu")
    temp.unban_admin_menu = CLanguage.get("unban_admin_menu")
    temp.area_peds_title_admin_menu = CLanguage.get("area_peds_title_admin_menu")
    temp.area_peds_admin_menu = CLanguage.get("area_peds_admin_menu")
    temp.area_objects_title_admin_menu = CLanguage.get("area_objects_title_admin_menu")
    temp.area_objects_admin_menu = CLanguage.get("area_objects_admin_menu")
    temp.admin_menu = CLanguage.get("admin_menu")
    temp.waypoint_admin_menu = CLanguage.get("waypoint_admin_menu")
    temp.waypoint_error_admin_menu = CLanguage.get("waypoint_error_admin_menu")
    temp.ammo = CLanguage.get("ammo")
    temp.blips_title_admin_menu = CLanguage.get("blips_title_admin_menu")
    temp.blips_admin_menu = CLanguage.get("blips_admin_menu")

    if player == -1 then 
        for _,src in next,GetPlayers(),nil do 
            CEvents.callRemote("vision:language:receiver", tonumber(src), temp)
        end
    else 
        CEvents.callRemote("vision:language:receiver", player, temp)
    end
end

CLanguage.update = function()
    local file = LoadResourceFile(CResource.name, CLanguage.file)
    if not file then return false end

    CLanguage.messages = json.decode(file)
    collectgarbage("collect")
    return true
end

CLanguage.update()

CLanguage.get = function(identifier)
    if identifier == nil then return end

    if CConfig.loaded then 
        return CLanguage.messages[identifier][string.lower(CConfig.settings.Logs.language)] 
    end
    return CLanguage.messages[identifier]["ro"]
end
---------- ./src/modules/language/s_language.lua ----------

---------- ./src/modules/vehicles/s_creating.lua ----------
CVehicles.CCreating = {}

CVehicles.CCreating._init = function()
    local temp = CConfig.settings.Entities.Vehicles.BlacklistedVehicles.list
    CConfig.settings.Entities.Vehicles.BlacklistedVehicles.list = {}
    for i = 1, #temp do
        CConfig.settings.Entities.Vehicles.BlacklistedVehicles.list[tonumber(temp[i], 10) or GetHashKey(temp[i])] = temp[i]
    end

    temp = CConfig.settings.Entities.AntiProps.whitelistedProps
    CConfig.settings.Entities.AntiProps.whitelistedProps = {}
    for i = 1, #temp do
        CConfig.settings.Entities.AntiProps.whitelistedProps[tonumber(temp[i], 10) or GetHashKey(temp[i])] = temp[i]
    end

    temp = CConfig.settings.Entities.Peds.Blacklisted.list
    CConfig.settings.Entities.Peds.Blacklisted.list = {}
    for i = 1, #temp do
        CConfig.settings.Entities.Peds.Blacklisted.list[tonumber(temp[i], 10) or GetHashKey(temp[i])] = temp[i]
    end
    if type(CConfig.settings.Entities.AntiProps.OSL.limit) == "string" then
	CConfig.settings.Entities.AntiProps.OSL.limit = 7
    end

    temp = nil
    collectgarbage("collect")

    CVehicles.CCreating.listener = AddEventHandler("entityCreating", function(handle)
	if GetEntityType(handle) == 0 then
		CancelEvent()
		return
	end
        local poptype = GetEntityPopulationType(handle)
        if poptype == 2 or poptype == 3 or poptype == 4 or poptype == 5 then return end

        SetEntityRoutingBucket(handle, 7330)

        if not NetworkGetEntityOwner(handle) then
            CancelEvent()
            return
        end

        local src = NetworkGetEntityOwner(handle)
        src = tonumber(src)

        if GetEntityType(handle) == 1 and (poptype == 6 or poptype == 7) and CConfig.settings.Entities.Peds.active then

            -- Peds Block All
            if CConfig.settings.Entities.Peds.blockAll then
                CSanctions.drop(src, CConfig.settings.Entities.Peds.detectionMode, "Blacklisted Peds ("..GetEntityModel(handle)..")", nil, nil, GetPlayerName(src))
                if CPlayers.hasBypass(src, "full") == false then CancelEvent() end
                return
            end

            -- Peds blacklist
            if CConfig.settings.Entities.Peds.Blacklisted.active and CConfig.settings.Entities.Peds.Blacklisted.list[GetEntityModel(handle)] then
                CSanctions.drop(src, CConfig.settings.Entities.Peds.Blacklisted.detectionMode, "Blacklisted Peds ("..CConfig.settings.Entities.Peds.Blacklisted.list[GetEntityModel(handle)]..")", nil, nil, GetPlayerName(src))
                if CPlayers.hasBypass(src, "full") == false then CancelEvent() end
                return
            end

        elseif GetEntityType(handle) == 2 then
            if not CPlayers.players[src] then return end

            -- Blacklisted Vehicles
            if CConfig.settings.Entities.Vehicles.BlacklistedVehicles.active then
                if CConfig.settings.Entities.Vehicles.BlacklistedVehicles.list[GetEntityModel(handle)] then
                    CSanctions.drop(src, CConfig.settings.Entities.Vehicles.BlacklistedVehicles.detectionMode, "Blacklisted Vehicle ("..CConfig.settings.Entities.Vehicles.BlacklistedVehicles.list[GetEntityModel(handle)]..")", nil, nil, GetPlayerName(src))
                    if CPlayers.hasBypass(src, "full") == false then CancelEvent() end
                    return
                end
            end

            -- Vehicles Spawn Limit
            if CConfig.settings.Entities.Vehicles.VSL.active then
                if not CPlayers.players[src].vehiclesSpawnLimit then
                    CPlayers.players[src].vehiclesSpawnLimit = {time = os.time(), count = 0, entities = {}}
                end

                local vehiclesSpawnLimit = CPlayers.players[src].vehiclesSpawnLimit
                if os.difftime(os.time(), vehiclesSpawnLimit.time) >= 7500 / 1000 then
                    CPlayers.players[src].vehiclesSpawnLimit = {time = os.time(), count = 1, entities = {}}
                elseif vehiclesSpawnLimit.count >= CConfig.settings.Entities.Vehicles.VSL.limit then
                    for i = 1, #CPlayers.players[src].vehiclesSpawnLimit.entities do
                        local entity = CPlayers.players[src].vehiclesSpawnLimit.entities[i]
                        if DoesEntityExist(entity) then
                            DeleteEntity(entity)
                        end
                    end

                    CPlayers.players[src].vehiclesSpawnLimit = nil
                    CSanctions.drop(src, CConfig.settings.Entities.Vehicles.VSL.detectionMode, "Vehicle Spawn Limit ("..CConfig.settings.Entities.Vehicles.VSL.limit..")", nil, nil, GetPlayerName(src))
                    if CPlayers.hasBypass(src, "full") == false then
                        CancelEvent()
                    end
                    return
                else
                    CPlayers.players[src].vehiclesSpawnLimit.count = vehiclesSpawnLimit.count + 1
                    ins(CPlayers.players[src].vehiclesSpawnLimit.entities, handle)
                end
            end

            -- Vehicles Blacklisted Plates
            if CConfig.settings.BlacklistedPlates.active then
                local plate = GetVehicleNumberPlateText(handle)

                for i = 1, #CConfig.settings.BlacklistedPlates.plates do
                    if string.find(string.lower(plate), string.lower(CConfig.settings.BlacklistedPlates.plates[i])) then
                        CSanctions.drop(src, CConfig.settings.BlacklistedPlates.detectionMode, "Blacklisted Vehicle Plates ("..CConfig.settings.BlacklistedPlates.plates[i]..")", nil, nil, GetPlayerName(src))
                        if CPlayers.hasBypass(src, "full") == false then
                            CancelEvent()
                        end
                        return
                    end
                end
            end

        elseif GetEntityType(handle) == 3 and poptype == 0 and CConfig.settings.Entities.AntiProps.active then

            -- Whitelisted Props
            if not CConfig.settings.Entities.AntiProps.whitelistedProps[GetEntityModel(handle)] and GetEntityModel(handle) ~= 0 then
                CSanctions.drop(src, CConfig.settings.Entities.AntiProps.detectionMode, "Blacklisted Props ("..GetEntityModel(handle)..")", nil, nil, GetPlayerName(src))
                if CPlayers.hasBypass(src, "full") == false then CancelEvent() end
                return
            end

            -- Prop Spawn Limit
            if CConfig.settings.Entities.AntiProps.OSL.active and CPlayers.players[src] then
                if not CPlayers.players[src].propSpawnLimit then
                    CPlayers.players[src].propSpawnLimit = {time = os.time(), count = 0, entities = {}}
                end
    
                local propSpawnLimit = CPlayers.players[src].propSpawnLimit
                if os.difftime(os.time(), propSpawnLimit.time) >= 7500 / 1000 then
                    CPlayers.players[src].propSpawnLimit = {time = os.time(), count = 1, entities = {}}
                elseif propSpawnLimit.count >= CConfig.settings.Entities.AntiProps.OSL.limit then
                    for i = 1, #CPlayers.players[src].propSpawnLimit.entities do
                        local entity = CPlayers.players[src].propSpawnLimit.entities[i]
                        if DoesEntityExist(entity) then
                            DeleteEntity(entity)
                        end
                    end

                    CSanctions.drop(src, CConfig.settings.Entities.AntiProps.OSL.detectionMode, "Prop Spawn Limit ("..CConfig.settings.Entities.AntiProps.OSL.limit..")", nil, nil, GetPlayerName(src))
                    if CPlayers.hasBypass(src, "full") == false then
                        CancelEvent()
                    end
                    return
                else
                    CPlayers.players[src].propSpawnLimit.count = propSpawnLimit.count + 1
                    ins(CPlayers.players[src].propSpawnLimit.entities, handle)
                end
            end
        end

        SetEntityRoutingBucket(handle, GetPlayerRoutingBucket(src))
    end)
end
---------- ./src/modules/vehicles/s_creating.lua ----------

---------- ./src/modules/weapons/s_explosion.lua ----------
if not CWeapons then CWeapons = {} end
CWeapons.CExplosion = {}

CWeapons.CExplosion._init = function()
    if CConfig.settings.BlacklistedExplosions.active then
        CWeapons.CExplosion.listener = AddEventHandler("explosionEvent", function(src, data)
            src = tonumber(src)
            --[[
                {
                    "f216":false,
                    "f240":false,
                    "f241":false,
                    "f191":false,
                    "f126":false,
                    "f189":false
                }

                damageScale => Explosion Damage Radius
                explosionType => Explosion Type
                posX => Explosion Position X
                posY => Explosion Position Y
                posZ => Explosion Position Z
                posX224 => Object Position X on Map if explosion was made by an object like Petrol Pump
                posY224 => Object Position Y on Map if explosion was made by an object like Petrol Pump
                posZ224 => Object Position Z on Map if explosion was made by an object like Petrol Pump
                cameraShake => Players Camera Shake
                ownerNetId => Explosion Owner (Spoofable, best get sender)
                isInvisible => Invisible Explosion
                isAudible => Audible Explosion
                f210 => Explosion on object (Network ID)
                f190 => Explosion was on a (prop or vehicle) and bomb type?
                f164 => Explosion Weapon
                f242 => Is object / vehicle / prop destroyed?
                f243 => Affected object / vehicle / prop?
                unkX => Particle Position X offset on map from explosion coordonates
                unkY => Particle Position Y offset on map from explosion coordonates
                unkZ => Particle Position Z offset on map from explosion coordonates
            ]]

            if not data.isAudible and CConfig.settings.BlacklistedExplosions.antiWithoutSound then
                CSanctions.drop(src, CConfig.settings.BlacklistedExplosions.detectionMode, "Explosion Protection (No Sound)", nil, nil, GetPlayerName(src))
                CancelEvent()
                return
            elseif data.isInvisible and CConfig.settings.BlacklistedExplosions.antiInvisible then
                CSanctions.drop(src, CConfig.settings.BlacklistedExplosions.antiInvisible, "Explosion Protection (Invisible)", nil, nil, GetPlayerName(src))
                CancelEvent()
                return
            end

            CancelEvent()
        end)
    end
end
---------- ./src/modules/weapons/s_explosion.lua ----------

---------- ./src/modules/events/g_blacklisted.lua ----------
if not CCEvents then CCEvents = {} end
CCEvents.blacklisted = {}

CCEvents.blacklisted._init = function()
    if CConfig.settings.BlacklistedEvents.active then 
        if IsDuplicityVersion() then
            for _, event in next,CConfig.settings.BlacklistedEvents.events,nil do 
                if not string.find(event, "vision:clientReceiver%d") and not not string.find(event, "vision:serverReceiver%d") then
                    RegisterNetEvent(event, function()
                        CSanctions.drop(source, CConfig.settings.BlacklistedEvents.detectionMode, "Blacklisted Events ("..event..")", nil, nil, GetPlayerName(source))
                        CancelEvent()
                        return
                    end)
                end
            end
        else
            for _, event in next,CConfig.settings.BlacklistedEvents.events,nil do 
                if not string.find(event, "vision:clientReceiver%d") and not not string.find(event, "vision:serverReceiver%d") then
                    RegisterNetEvent(event, function()
                        CSanctions.drop(CConfig.settings.BlacklistedEvents.detectionMode, "Blacklisted Events ("..event..")", nil)
                        CancelEvent()
                        return
                    end)
                end
            end
        end
    end
end
---------- ./src/modules/events/g_blacklisted.lua ----------

---------- ./src/modules/resources/s_resources.lua ----------

---------- ./src/modules/resources/s_resources.lua ----------

---------- ./src/modules/sanctions/s_sanctions.lua ----------
CSanctions._init = function()
    CSanctions.cooldown = {}
    
    CSanctions.drop = function(source, detectionMode, reason, kickreason, def, playerName, ocrdata)
        local src = source
        if not reason then return end

        if not CSanctions.cooldown[src] then
            CSanctions.cooldown[src] = {}
        end

        if CSanctions.cooldown[src][reason] and os.difftime(os.time(), CSanctions.cooldown[src][reason] or os.time()) < 30 then
            return
        else
            CSanctions.cooldown[src][reason] = os.time()
        end

        local player = CPlayers.players[src] or { identifiers = CPlayers.getIdentifiers(src), ip = GetPlayerEndpoint(src), tokens = CPlayers.getTokens(src) }
        local name = playerName or GetPlayerName(src)

        if CPlayers.hasBypass(src, "full") then
            detectionMode = 0
            reason = reason.." (AC Bypass)"
        end

        if detectionMode == 0 or detectionMode == 3 then
            if detectionMode == 3 then 
                TriggerClientEvent(CConfig.settings.AntiSpam.chatTrigger, src, "Server", {255, 0, 0}, kickreason)
            end

            CResource.info(string.format(CLanguage.get("player_warned"), name, reason))
            
            local identifiers = string.format(CLanguage.get("playerwarn_desc"), reason, name)
            for cat, val in pairs(player["identifiers"]) do
                identifiers = identifiers .. "\n**" .. cat:gsub("^%l", string.upper) .. ":** `" .. val .. "`"
            end
            CWebhook.send("warnings", tonumber("ebb134", 16), CLanguage.get("playerwarn"), identifiers)
        elseif detectionMode == 1 then
            CResource.info(string.format(CLanguage.get("player_kicked"), name, reason))
            
            local identifiers = string.format(CLanguage.get("playerkick_desc"), reason, name)
            for cat, val in pairs(player["identifiers"]) do
                identifiers = identifiers .. "\n**" .. cat:gsub("^%l", string.upper) .. ":** `" .. val .. "`"
            end            
            
            CWebhook.send("kicks", nil, CLanguage.get("playerkick"), identifiers)
            CSanctions.out(src, def, kickreason)
            
        elseif detectionMode == 2 then
            local banid = tostring(CBans.addBan(src, reason, "UPLOADING..."))
            local identifiers = string.format(CLanguage.get("playerban_desc"), banid, reason, name)
            for cat, val in pairs(player["identifiers"]) do
                identifiers = identifiers .. "\n**" .. cat:gsub("^%l", string.upper) .. ":** `" .. val .. "`"
            end
            CResource.info(string.format(CLanguage.get("player_banned"), name, reason, banid))

            CWebhook.send("bans", tonumber("ff0000", 16), CLanguage.get("playerban"), identifiers)
            CSanctions.out(src, def, kickreason)
        end
    end

    CSanctions.out = function(src, def, kickreason)
        if def then 
            def.done(kickreason or CConfig.settings.BanSystem.message)
        else 
            DropPlayer(src, kickreason or CConfig.settings.BanSystem.message)
        end
    end

    CSanctions.event = CEvents.registerRemote("vision:sanctions:receiver", function(detectionMode, reason, kickreason, ocrdata)
        local src = source
        CSanctions.drop(src, detectionMode, reason, kickreason, nil, GetPlayerName(src), ocrdata)
    end)
end

CSanctions._init()
---------- ./src/modules/sanctions/s_sanctions.lua ----------

---------- ./src/modules/identifiers/s_identifiers.lua ----------

CIdentifiers._init = function()
    CIdentifiers.playerJoin = AddEventHandler("playerConnecting", function(name, setKickReason, deferalls)
        local src = source
        deferalls.defer()
	    Wait(0)

        if CConfig.settings.AntiIdentifiers.blacklistedName.active then 
            deferalls.update(CLanguage.get("checking_name"))
            Citizen.SetTimeout(100, function()
                for key,value in next,CConfig.settings.AntiIdentifiers.blacklistedName.names,nil do 
                    if string.match(string.lower(name), string.lower(value)) then 
                        CSanctions.drop(src, 1, "Blacklisted Name", CConfig.settings.AntiIdentifiers.blacklistedName.message, deferalls, name)
                        CancelEvent()
                    end
                end
            end)
        end

        if CConfig.settings.AntiIdentifiers.forceSteam.active then 
            deferalls.update(CLanguage.get("checking_steam"))
            Citizen.SetTimeout(100, function()
                if CPlayers.players[src]["identifiers"]["steam"] == "N/A" then 
                    CSanctions.drop(src, 1, "Force Steam", CConfig.settings.AntiIdentifiers.forceSteam.message, deferalls, name)
                    CancelEvent()
                end
            end)
        end

        if CConfig.settings.AntiIdentifiers.forceDiscord.active then 
            deferalls.update(CLanguage.get("checking_discord"))
            Citizen.SetTimeout(100, function()
                if CPlayers.players[src]["identifiers"]["discord"] == "N/A" then 
                    CSanctions.drop(src, 1, "Force Discord", CConfig.settings.AntiIdentifiers.forceDiscord.message, deferalls, name)
                    CancelEvent()
                end
            end)
        end

        CEvents.call("vision:antivpn", src, name, setKickReason, deferalls, GetPlayerEndpoint(src))
    end)
end
---------- ./src/modules/identifiers/s_identifiers.lua ----------

---------- ./src/modules/particles/s_antiparticles.lua ----------
CAntiParticles = {}

CAntiParticles._init = function()
    if CConfig.settings.AntiFXParticles.active then
        local temp = CConfig.settings.AntiFXParticles.antiBlacklisted.particles
        CConfig.settings.AntiFXParticles.antiBlacklisted.particles = {}
        for i = 1, #temp do
            CConfig.settings.AntiFXParticles.antiBlacklisted.particles[GetHashKey(temp[i])] = true
        end

        temp = nil
        collectgarbage("collect")

        CAntiParticles.event = AddEventHandler("ptFxEvent", function(sender, data)
            sender = tonumber(sender)

            -- Anti FX Particles | Block All
            if CConfig.settings.AntiFXParticles.blockAll then
                CSanctions.drop(sender, CConfig.settings.AntiFXParticles.detectionMode, "FX Particles ("..data.effectHash..")", nil, nil, GetPlayerName(sender))
                return
            end

            -- Anti FX Particles | Block Mass
            if CConfig.settings.AntiFXParticles.blockMass and CPlayers.players[sender] then
                if not CPlayers.players[sender].fxSpawnLimit then
                    CPlayers.players[sender].fxSpawnLimit = {time = os.time(), count = 0, entities = {}}
                end

                local fxSpawnLimit = CPlayers.players[sender].fxSpawnLimit
                if os.difftime(os.time(), fxSpawnLimit.time) >= 7500 / 1000 then
                    CPlayers.players[sender].fxSpawnLimit = {time = os.time(), count = 1, entities = {}}
                elseif fxSpawnLimit.count >= 4 then
                    for i = 1, #CPlayers.players[sender].fxSpawnLimit.entities do
                        local entity = CPlayers.players[sender].fxSpawnLimit.entities[i]
                        if DoesEntityExist(entity) then
                            DeleteEntity(entity)
                        end
                    end

                    CSanctions.drop(sender, CConfig.settings.Entities.Vehicles.VSL.detectionMode, "Mass FX Particles", nil, nil, GetPlayerName(sender))
                    return
                else
                    CPlayers.players[sender].fxSpawnLimit.count = fxSpawnLimit.count + 1
                end
            end

            -- Anti FX Particles | Blacklisted
            if CConfig.settings.AntiFXParticles.antiBlacklisted.active and CConfig.settings.AntiFXParticles.antiBlacklisted.particles[data.effectHash] then
                CSanctions.drop(sender, CConfig.settings.Entities.Vehicles.VSL.detectionMode, "Blacklisted FX Particles ("..data.effectHash..")", nil, nil, GetPlayerName(sender))
                return
            end
        end)
    end
end
---------- ./src/modules/particles/s_antiparticles.lua ----------

---------- ./src/modules/clearpedtasks/s_clearpedtasks.lua ----------
CClearPedTask = {}

CClearPedTask._init = function()
    if CConfig.settings.AntiClearPedTasks.active then 
        CClearPedTask.event = AddEventHandler("clearPedTasksEvent", function(source, data)
            if data.immediately or (DoesEntityExist(NetworkGetEntityFromNetworkId(data.pedId)) and tonumber(source) ~= NetworkGetEntityOwner(NetworkGetEntityFromNetworkId(data.pedId))) then 
                CSanctions.drop(source, CConfig.settings.AntiClearPedTasks.detectionMode, "Clear Ped Task")
                CancelEvent()
                return
            end
        end)
    end
end

---------- ./src/modules/clearpedtasks/s_clearpedtasks.lua ----------
