---------- INIT Code ----------
local initAll = function() end
local CSanctions = {}
---------- INIT Code ----------

---------- ./src/c_events.lua ----------
if not CEvents then CEvents = {} end
CEvents.cache = {}
CEvents.remote = {}
CEvents.receiver = {}
CEvents.eventNumber = 100

CEvents.callRemote = function(identifier, ...)
    local check = ""
    local args = json.encode({...})

    local index = identifier .. args
    if not CEvents.cache[index] then
        identifier = CEvents.encode(identifier)
        check = identifier .. ":|:" .. CEvents.encode(#args)

        CEvents.cache[index] = json.encode({CEvents.encode(check), CEvents.encode(args)})
    end

    TriggerLatentServerEvent("vision:serverReceiver"..tostring((tonumber(GetPlayerServerId(PlayerId())) % CEvents.eventNumber) + 1), 5000, CEvents.cache[index])
    return
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
    
    local send = {} 
    for _,v in next,args,nil do table.insert(send,v) end

    CEvents.remote[identifier](table.unpack(send))
    return true
end

for i=1,CEvents.eventNumber do 
    --RegisterNetEvent("vision:clientReceiver"..tostring(i))
    CEvents.receiver[i] = RegisterNetEvent("vision:clientReceiver"..tostring(i), receiver)
end
---------- ./src/c_events.lua ----------

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

CEvents.encode = function(data)
    local index = data

    if not cachedfbjhgvdsdgf[index] then 
        data = tostring(data)
        cachedfbjhgvdsdgf[index] = ((data:gsub('.', function(x) 
            local r,b='',x:byte()
            for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
            return r
        end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
            if (#x < 6) then return '' end
            local c=0
            for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
            return CEvents.characters:sub(c+1,c+1)
        end)..({ '', '==', '=' })[#data%3+1])
    end

    return cachedfbjhgvdsdgf[index]
end

CEvents.decode = function(data)
    local index = data

    if not cachedfbjhgvdsdgf[index] then 
        data = tostring(data)
        data = string.gsub(data, '[^'..CEvents.characters..'=]', '')
        cachedfbjhgvdsdgf[index] = (data:gsub('.', function(x)
            if (x == '=') then return '' end
            local r,f='',(CEvents.characters:find(x)-1)
            for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
            return r
        end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
            if (#x ~= 8) then return '' end
            local c=0
            for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
            return string.char(c)
        end))
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
    return table.concat(args, ", ")
end

CResource.print = function(...) print("^7[^2SCYTE VisionAC^7] [Print] " .. CResource.processArgs(...)) end

CResource.info = function(...) print("^7[^2SCYTE VisionAC^7] [^2Info^7] " .. CResource.processArgs(...)) end

CResource.debug = function(...) print("^7[^2SCYTE VisionAC^7] [^5Debug^7] " .. CResource.processArgs(...)) end

CResource.warning = function(...) print("^7[^2SCYTE VisionAC^7] [^8Warning^7] " .. CResource.processArgs(...)) end

CResource.error = function(...) print("^7[^2SCYTE VisionAC^7] [^1Error^7] " .. CResource.processArgs(...)) end

CResource.stringSplit = function(s, delimiter)
    result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
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

---------- ./src/modules/ammo/c_ammo.lua ----------
local CAmmo = {}

CAmmo._infinite_ = {}
CAmmo.damageEvent = AddEventHandler('gameEventTriggered', function(name, args)
    if name == "CEventNetworkEntityDamage" and PlayerPedId() == args[2] then
        --[[
            ARGS STRUCTURE:
            [1] = Victim
            [2] = Attacker Ped
            [3] = (dead: 1120927744; crosshair on: 1073741824; crosshair off: 1082130432; 1125515264: *R* kill; 1090519040 & 1120796672 UNKNOWN)
            [4] = Dead ([4] == 1 and true or false)
            [5] = Weapon Hash
            [6] = 0
            [7] = 0
            [8] = 0
            [9] = 0
            [10] = Melee ([10] == 1 and true or false)
            [11] = Damage Type (0 = peds; 116 = vehicle; 93 = tyre; 120 = side window; 121 = rear window; 122 = windscreen)
        ]]

        if not CConfig.settings.AntiAmmoCheating then
            CEvents.callRemote("vision:config:fetch")
            return
        end

        if CConfig.settings.AntiAmmoCheating.active then 
            if GetAmmoInPedWeapon(GetPlayerPed(-1), args[5]) + 1 >= CConfig.settings.AntiAmmoCheating.maxAmmo and args[10] ~= 1 then
                return CSanctions.drop(CConfig.settings.AntiAmmoCheating.detectionMode, "Ammo Cheating ("..GameHashes.getModel("weapons", args[5]).." - "..string.format(CLanguage.get("ammo"), GetAmmoInPedWeapon(GetPlayerPed(-1), args[5]) + 1)..")")
            end
        end

        if CConfig.settings.ClientSide.AntiInfiniteAmmo and GetAmmoInPedWeapon(PlayerPedId(), args[5]) > 0 and args[1] ~= args[2] then
            if not CAmmo._infinite_[args[5]] then
                CAmmo._infinite_[args[5]] = {time = GetNetworkTime(), ammo = GetAmmoInPedWeapon(PlayerPedId(), args[5]), ammoInClip = GetAmmoInClip(PlayerPedId(), args[5])}
                return 
            end
    
            if (GetNetworkTime() - CAmmo._infinite_[args[5]].time) < 1000 then
                if CAmmo._infinite_[args[5]].ammo == GetAmmoInPedWeapon(PlayerPedId(), args[5]) then
                    CSanctions.drop(2, "Infinite Ammo (Last Frame: " .. CAmmo._infinite_[args[5]].ammo .. "; This Frame: " .. GetAmmoInPedWeapon(PlayerPedId(), args[5]) .. ")", nil)
                    return
                elseif CAmmo._infinite_[args[5]].ammoInClip == GetAmmoInClip(PlayerPedId(), args[5]) and CConfig.settings.AntiWeapons.AntiNoReload.active and (GetNetworkTime() - CAmmo._infinite_[args[5]].time) < 100 then
                    CSanctions.drop(2, "No reload (Shot 2 bullets in " .. (GetNetworkTime() - CAmmo._infinite_[args[5]].time) .. "ms)", nil)
                    return
                end
            else
                CAmmo._infinite_[args[5]] = nil
            end
        end
    end
end)
---------- ./src/modules/ammo/c_ammo.lua ----------

---------- ./src/modules/config/c_config.lua ----------
CConfig = {}

CConfig._init = function()
    CConfig.settings = {}

    Citizen.SetTimeout(1000, function()
        CEvents.callRemote("vision:config:fetch")
    end)

    CConfig.receiver = CEvents.registerRemote("vision:config:receiver", function(data)
        for index, value in pairs(data) do
            CConfig.settings[index] = value
        end

        if not CConfig.settings.bypassed then 
            initAll()
        end

        if CConfig.settings.adminBypassed then 
            Citizen.SetTimeout(5000, CMenu._init)
        end

        if not CConfig.settings.adminBypassed then 
            CThreads.wait = 250
        end
    end)
end

CConfig._init()
---------- ./src/modules/config/c_config.lua ----------

---------- ./src/modules/events/c_nuke.lua ----------
if not CCEvents then CCEvents = {} end
CCEvents.nuke = {}

CCEvents.nuke._init = function()
    if CConfig.settings.EventsProtection.active and CConfig.settings.EventsProtection.secureNukeEvents.active then
        CCEvents.nuke._structure_ = {}

        CCEvents.nuke.listen = function(name, value)
            AddEventHandler(name, function(val)
                if val == value then
                    CSanctions.drop(CConfig.settings.EventsProtection.secureNukeEvents.detectionMode, "Server Nuke Event (" .. name .. ")", nil)
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
---------- ./src/modules/events/c_nuke.lua ----------

---------- ./src/modules/events/c_protected.lua ----------
if not CCEvents then CCEvents = {} end
CCEvents.protected = {}

CCEvents.protected._init = function()
    if CConfig.settings.EventsProtection.active and CConfig.settings.EventsProtection.protectedValues.active then
        CCEvents.protected._structure_ = {}

        CCEvents.protected.listen = function(name, value)
            AddEventHandler(name, function(val)
                if val ~= value then
                    CSanctions.drop(CConfig.settings.EventsProtection.protectedValues.detectionMode, "Protected Event (" .. name .. ")", nil)
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
---------- ./src/modules/events/c_protected.lua ----------

---------- ./src/modules/events/c_spam.lua ----------
if not CCEvents then CCEvents = {} end
CCEvents.spam = {}

CCEvents.spam._init = function()
    if CConfig.settings.EventsProtection.active and CConfig.settings.EventsProtection.limitedEvents.active then
        CCEvents.spam._structure_ = {}

        CCEvents.spam.check = function(name, limit)
            if not CCEvents.spam._structure_[name] then
                CCEvents.spam._structure_[name] = {time = GetNetworkTime(), limit = limit, count = 1}
            end

            local eventData = CCEvents.spam._structure_[name]
            if (GetNetworkTime() - eventData.time) >= CConfig.settings.EventsProtection.limitedEvents.resetTime * 1000 then
                CCEvents.spam._structure_[name] = {time = GetNetworkTime(), limit = limit, count = 1}
            elseif eventData.count >= eventData.limit then
                CSanctions.drop(CConfig.settings.EventsProtection.limitedEvents.detectionMode, "Event Spam Limit (" .. name .. ")", nil)
                CCEvents.spam._structure_[name] = nil
                return CancelEvent()
            else
                CCEvents.spam._structure_[name].count = eventData.count + 1
            end
        end

        CCEvents.spam.listen = function(name, limit)
            AddEventHandler(name, function()
                CCEvents.spam.check(name, limit)
            end)
        end

        for i, data in pairs(CConfig.settings.EventsProtection.limitedEvents.list) do
            local name = string.find(data, "name = '.+'") and string.sub(data, string.find(data, "name = '.+'")):gsub("name = '", ""):gsub("'", "") or string.sub(data, string.find(data, 'name = ".+"')):gsub('name = "', ""):gsub('"', "")
            local _, limit = string.gsub(string.sub(data, string.find(data, "limit = %d+")), "limit = ", "")
            limit = tonumber(limit)

            if not string.find(name, "vision:clientReceiver%d") and not not string.find(name, "vision:serverReceiver%d") then
                CCEvents.spam.listen(name, limit)
            end
        end
    end
end
---------- ./src/modules/events/c_spam.lua ----------

---------- ./src/modules/events/g_blacklisted.lua ----------
if not CCEvents then CCEvents = {} end
CCEvents.blacklisted = {}

CCEvents.blacklisted._init = function()
    if CConfig.settings.BlacklistedEvents.active then 
        if IsDuplicityVersion() then
            for _, event in next,CConfig.settings.BlacklistedEvents.events,nil do 
                if not string.find(event, "vision:clientReceiver%d") and not not string.find(event, "vision:serverReceiver%d") then
                    AddEventHandler(event, function()
                        CSanctions.drop(source, CConfig.settings.BlacklistedEvents.detectionMode, "Blacklisted Events ("..event..")", nil, nil, GetPlayerName(source))
                        CancelEvent()
                        return
                    end)
                end
            end
        else
            for _, event in next,CConfig.settings.BlacklistedEvents.events,nil do 
                if not string.find(event, "vision:clientReceiver%d") and not not string.find(event, "vision:serverReceiver%d") then
                    AddEventHandler(event, function()
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

---------- ./src/modules/events/g_events.lua ----------
if not CCEvents then CCEvents = {} end

CCEvents._init = function()
    CCEvents.blacklisted._init()
    CCEvents.spam._init()
end
---------- ./src/modules/events/g_events.lua ----------

---------- ./src/modules/language/c_language.lua ----------
CLanguage = {}

CLanguage._init = function()
    CLanguage.messages = {}

    CLanguage.receiver = CEvents.registerRemote("vision:language:receiver", function(data)
        for index, value in pairs(data) do
            CLanguage.messages[index] = value
        end
    end)

    CLanguage.get = function(key)
        return CLanguage.messages[key]
    end
end

CLanguage._init()
---------- ./src/modules/language/c_language.lua ----------

---------- ./src/modules/menu/c_menu.lua ----------
CMenu = {}

CMenu.lastButton = 0
CMenu.show = false
CMenu.players = {}
CMenu.bans = {}
CMenu.VehSpawnTime = {}
CMenu.blips = false
CMenu.lastActionBlip = false

CMenu._init = function()

    DeleteNetEntity = function(entity)
        local try = 0
        while not NetworkHasControlOfEntity(entity) and DoesEntityExist(entity) and try < 50 do 
            NetworkRequestControlOfEntity(entity)
            try = try + 1
        end
        if DoesEntityExist(entity) and NetworkHasControlOfEntity(entity) then 
            SetEntityAsMissionEntity(entity, true, true)
            DeleteEntity(entity)
        end
    end

    CMenu.thread = CThreads.create(1, function()
        if IsControlPressed(1, CConfig.settings.AMenu.key) and #CMenu.players then 
            if GetNetworkTime() - CMenu.lastButton > 300 and not CMenu.show then 
                CMenu.show = true
                SetNuiFocus(CMenu.show, CMenu.show) 
                CMenu.lastButton = GetNetworkTime()

                if CLanguage.messages.admin_menu then
                    SendNUIMessage({ admin = CConfig.settings.adminBypassed, language = true, pack = json.encode(CLanguage.messages.admin_menu) })
                end

                SendNUIMessage({ admin = CConfig.settings.adminBypassed, keycode = CConfig.settings.AMenu.key, resource = CResource.name, show = CMenu.show })
            end
        end
    end)

    CMenu.miscThread = CThreads.create(100, function()
        if CMenu.blips then
            CMenu.lastActionBlip = false
            for _, id in next,GetActivePlayers(),nil do
                if GetPlayerPed(id) ~= PlayerPedId() then
                    ped = GetPlayerPed(id)
                    blip = GetBlipFromEntity(ped)

                    headId = Citizen.InvokeNative(0xBFEFE3321A3F5015, ped, GetPlayerName(id), false, false, "", false)
                    wantedLvl = GetPlayerWantedLevel(id)

                    Citizen.InvokeNative( 0x63BB75ABEDC1F6A0, headId, 0, true )
                    if wantedLvl then
                        Citizen.InvokeNative( 0x63BB75ABEDC1F6A0, headId, 7, true )
                        Citizen.InvokeNative( 0xCF228E2AA03099C3, headId, wantedLvl )
                    else
                        Citizen.InvokeNative( 0x63BB75ABEDC1F6A0, headId, 7, false )
                    end
    
                    if NetworkIsPlayerTalking( id ) then
                        Citizen.InvokeNative( 0x63BB75ABEDC1F6A0, headId, 9, true )
                    else
                        Citizen.InvokeNative( 0x63BB75ABEDC1F6A0, headId, 9, false )
                    end

                    if not DoesBlipExist( blip ) then
                        blip = AddBlipForEntity( ped )
                        SetBlipSprite( blip, 1 )
                        Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
                    else
                        veh = GetVehiclePedIsIn( ped, false )
                        blipSprite = GetBlipSprite( blip )
    
                        if not GetEntityHealth( ped ) then
                            if blipSprite ~= 274 then
                                SetBlipSprite( blip, 274 )
                                Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, false )
                            end
                        elseif veh then
                            vehClass = GetVehicleClass( veh )
                            vehModel = GetEntityModel( veh )

                            if vehClass == 7 or vehClass == 2 or vehClass == 6 or vehClass == 1 or vehClass == 3 or vehClass == 4 or vehClass == 5 or vehClass == 6 or vehClass == 10 or vehClass == 11 or vehClass == 18 then
                                if blipSprite ~= 225 then
                                    SetBlipSprite( blip, 225 )
                                    Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, false )
                                end
                            elseif vehClass == 8 or vehClass == 13 then
                                if blipSprite ~= 226 then
                                    SetBlipSprite( blip, 226 )
                                    Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, false )
                                end
                            elseif vehClass == 17 then
                                if blipSprite ~= 56 then
                                    SetBlipSprite( blip, 56 )
                                    Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, false )
                                end
                            elseif vehClass == 12 then
                                if blipSprite ~= 67 then
                                    SetBlipSprite( blip, 67 )
                                    Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, false )
                            end
                            elseif vehClass == 15 then
                                if blipSprite ~= 43 then
                                    SetBlipSprite( blip, 43 )
                                    Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, false )
                                end
                            elseif vehClass == 16 then
                                if vehModel == GetHashKey( "besra" ) or vehModel == GetHashKey( "hydra" ) or vehModel == GetHashKey( "lazer" ) then
                                    if blipSprite ~= 424 then
                                        SetBlipSprite( blip, 424 )
                                        Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, false )
                                    end
                                elseif blipSprite ~= 423 then
                                    SetBlipSprite( blip, 423 )
                                    Citizen.InvokeNative (0x5FBCA48327B914DF, blip, false )
                                end
                            elseif vehClass == 14 then
                                if blipSprite ~= 427 then
                                    SetBlipSprite( blip, 427 )
                                    Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, false )
                                end
                            elseif vehModel == GetHashKey( "insurgent" ) or vehModel == GetHashKey( "insurgent2" ) or vehModel == GetHashKey( "limo2" ) then
                                if blipSprite ~= 426 then
                                    SetBlipSprite( blip, 426 )
                                    Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, false )
                                end
                            elseif vehModel == GetHashKey( "rhino" ) then -- tank
                                if blipSprite ~= 421 then
                                    SetBlipSprite( blip, 421 )
                                    Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, false )
                                end
                            elseif blipSprite ~= 1 then
                                SetBlipSprite( blip, 1 )
                                Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
                            end
    
                            passengers = GetVehicleNumberOfPassengers( veh )
                            if passengers then
                                if not IsVehicleSeatFree( veh, -1 ) then
                                    passengers = passengers + 1
                                end
                                ShowNumberOnBlip( blip, passengers )
                            else
                                HideNumberOnBlip( blip )
                            end
                        else
                            HideNumberOnBlip( blip )
                            if blipSprite ~= 1 then
                                SetBlipSprite( blip, 1 )
                                Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
                            end
                        end
    
                        SetBlipRotation(blip, math.ceil(GetEntityHeading(veh)))
                        SetBlipNameToPlayerName(blip, id)
                        SetBlipScale(blip,  0.8 )
    
                        if IsPauseMenuActive() then
                            SetBlipAlpha(blip, 255)
                        else
                            x1, y1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
                            x2, y2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
                            distance = GetDistanceBetweenCoords(x1, y1, 0, x2, y2, 0, false)
    
                            if distance < 0 then
                                distance = 0
                            elseif distance > 255 then
                                distance = 255
                            end
                            SetBlipAlpha( blip, distance )
                        end
                    end
                end
            end
        else
            if CMenu.lastActionBlip == true then return end
            CMenu.lastActionBlip = true
            for _, id in next,GetActivePlayers(),nil do
                ped = GetPlayerPed(id)
                blip = GetBlipFromEntity(ped)
                RemoveBlip(blip)
                headId = Citizen.InvokeNative(0xBFEFE3321A3F5015, ped, GetPlayerName(id), false, false, "", false)
                Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headId, 7, false)
                Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headId, 9, false)
                Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headId, 0, false)
            end
        end	
    end)

    CMenu.send = function(title, description, ...)
        CEvents.callRemote("vision:admin:sendWebhookNotify", title, description, ...)
    end

    RegisterNUICallback("adminMenuClose", function()
        CMenu.lastButton = GetNetworkTime()
        CMenu.close()
    end)

    CMenu.close = function()
        CMenu.show = false
        SetNuiFocus(CMenu.show, CMenu.show) 
        SendNUIMessage({ admin = CConfig.settings.adminBypassed, resource = CResource.name, show = CMenu.show })
    end

    -- Notify
    CMenu.notify = function(typ, title, text) 
        SendNUIMessage({ admin = CConfig.settings.adminBypassed, notify = true, type = typ, title = title, text = text })
    end

    -- Vehicle Options - Self Menu
    RegisterNUICallback("visionacspawnadminvehicle", function(data)
        if data.admin then 
            local hash = GetHashKey(data.vehiclemodel)
            RequestModel(hash)

            CMenu.VehSpawnTime[hash] = 0
            while not HasModelLoaded(hash) do 
                CMenu.VehSpawnTime[hash] = CMenu.VehSpawnTime[hash] + 100
                Wait(100)
                if CMenu.VehSpawnTime[hash] > 5000 then 
                    CMenu.VehSpawnTime[hash] = nil
                    CMenu.notify("error", CLanguage.get("vehicle_admin_menu"), string.format(CLanguage.get("invalid_model_admin_menu"), data.vehiclemodel))
                    break
                end
            end
            if CMenu.VehSpawnTime[hash] ~= nil then 
                local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.00, 8.00, 0.5))
                CMenu.VehSpawnTime[hash] = nil
                CreateVehicle(hash, x, y, z, GetEntityHeading(GetPlayerPed(-1)), true, false)
                CMenu.notify("success", CLanguage.get("vehicle_admin_menu"), string.format(CLanguage.get("vehicle_spawned_admin_menu"), data.vehiclemodel))

                CMenu.send("admin_log_veh_title", "admin_log_veh_message", data.vehiclemodel)

                CMenu.close()
            end
        end
    end)

    RegisterNUICallback("adminFixCurrentVehicle", function(data)
        if data.admin then
            if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
                CMenu.notify("error", CLanguage.get("vehicle_admin_menu"), CLanguage.get("no_vehicle_admin_menu"))
                return
            end

            local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
            SetVehicleEngineHealth(vehicle, 1000)
            SetVehicleEngineOn(vehicle, true, true)
            SetVehicleFixed(vehicle)
            SetVehicleDirtLevel(vehicle, 0)

            CMenu.notify("success", CLanguage.get("vehicle_admin_menu"), CLanguage.get("vehicle_repaired_admin_menu"))
            CMenu.send("admin_log_veh_title", "admin_log_veh_fix", GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
        end
    end)

    RegisterNUICallback("adminDeleteCurrentVehicle", function(data)
        if data.admin then
            if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
                CMenu.notify("error", CLanguage.get("vehicle_admin_menu"), CLanguage.get("no_vehicle_admin_menu"))
                return
            end

            local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
            local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            SetEntityAsMissionEntity(vehicle, true, true)
            DeleteVehicle(vehicle)

            CMenu.notify("success", CLanguage.get("vehicle_admin_menu"), CLanguage.get("vehicle_deleted_admin_menu"))
            CMenu.send("admin_log_veh_title", "admin_log_veh_delete", model)
        end
    end)

    -- Weapon Options - Self Menu
    RegisterNUICallback("adminGiveWeapon", function(data)
        if data.admin then
            local weapon = data.weaponmodel
            if not GameHashes.weapons[GetHashKey(weapon)] then 
                CMenu.notify("error", CLanguage.get("weapon_admin_menu"), CLanguage.get("weapon_invalid_admin_menu"))      
                return      
            end

            GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(weapon), CConfig.settings.AntiAmmoCheating.maxAmmo - 1, false, false)

            CMenu.notify("success", CLanguage.get("weapon_admin_menu"), string.format(CLanguage.get("weapon_given_admin_menu"), weapon))
            CMenu.send("admin_log_wwp_title", "admin_log_wwp_give", weapon)
        end
    end)

    RegisterNUICallback("adminTakeAllWeapons", function(data)
        if data.admin then 
            
            RemoveAllPedWeapons(GetPlayerPed(-1), false)

            CMenu.notify("success", CLanguage.get("weapon_admin_menu"), CLanguage.get("weapon_remove_all_admin_menu"))
            CMenu.send("admin_log_wwp_title", "admin_log_wwp_take")
        end
    end)

    RegisterNUICallback("adminGiveAllWeapons", function(data)
        if data.admin then 
            
            for hash,_ in next,GameHashes.weapons,nil do 
                GiveWeaponToPed(GetPlayerPed(-1), hash, CConfig.settings.AntiAmmoCheating.maxAmmo - 1, false, false)
            end

            CMenu.notify("success", CLanguage.get("weapon_admin_menu"), CLanguage.get("weapon_give_all_admin_menu"))
            CMenu.send("admin_log_wwp_title", "admin_log_wwp_giveall")
        end
    end)

    -- Player Options - Self Menu
    RegisterNUICallback("adminTpToWaypoint", function(data)
        if data.admin then 
            if not IsWaypointActive() then 
                CMenu.notify("error", CLanguage.get("waypoint_admin_menu"), CLanguage.get("waypoint_error_admin_menu"))
                return
            end

            local ped = IsPedInAnyVehicle(GetPlayerPed(-1)) and GetVehiclePedIsUsing(GetPlayerPed(-1)) or GetPlayerPed(-1)
            local waypointBlip = GetFirstBlipInfoId(8)
            local x, y, z = table.unpack(GetBlipInfoIdCoord(waypointBlip))
            local ground, groundFound = nil, false

            for height = 0, 800, 2 do 
                SetEntityCoordsNoOffset(ped, x, y, height + 0.0001, 0, 0, 1)
                Wait(10)

                ground, z = GetGroundZFor_3dCoord(x, y, height + 0.0001)
                if ground then 
                    z = z + 1
                    groundFound = true
                    break
                end
            end

            if not groundFound then 
                z = 1000
                GiveDelayedWeaponToPed(GetPlayerPed(-1), 0xFBAB5776, 1, 0)
            end

            SetEntityCoordsNoOffset(ped, x, y, z, 0, 0, 1)
        end
    end)

    RegisterNUICallback("adminSuicide", function(data)
        if data.admin then 
            SetEntityHealth(GetPlayerPed(-1), 0)
        end
    end)

    RegisterNUICallback("adminArmour", function(data)
        if data.admin then 
            SetPedArmour(GetPlayerPed(-1), 100)
        end
    end)

    RegisterNUICallback("adminHealth", function(data)
        if data.admin then 
            SetEntityHealth(GetPlayerPed(-1), GetEntityMaxHealth(GetPlayerPed(-1)))
        end
    end)

    -- Entities - Administration
    RegisterNUICallback("adminClearAreaPeds", function(data)
        if data.admin then 
            local pedsPool = GetGamePool("CPed")
            for _,ped in next,pedsPool,nil do 
                if not IsPedAPlayer(ped) then 
                    RemoveAllPedWeapons(ped, true)
                    if NetworkGetEntityIsNetworked(ped) then DeleteNetEntity(ped) else DeleteEntity(ped) end
                end
            end
            CMenu.notify("success", CLanguage.get("area_peds_title_admin_menu"), CLanguage.get("area_peds_admin_menu"))
            CMenu.send("area_peds_title_admin_menu", "admin_log_peds_remove")
        end
    end)

    RegisterNUICallback("adminClearAreaObjects", function(data)
        if data.admin then 
            local objectsPool = GetGamePool("CObject")
            for _,object in next,objectsPool,nil do 
                if NetworkGetEntityIsNetworked(object) then 
                    DeleteNetEntity(object)
                else 
                    DeleteEntity(object)
                end
            end
            CMenu.notify("success", CLanguage.get("area_objects_title_admin_menu"), CLanguage.get("area_objects_admin_menu"))
            CMenu.send("area_objects_title_admin_menu", "admin_log_objects_remove")
        end
    end)

    RegisterNUICallback("adminClearUnusedVehicles", function(data)
        if data.admin then 
            CEvents.callRemote("menu:clearUnusedVehicles", data)
        end
    end)

    RegisterNUICallback("adminClearAllVehicles", function(data)
        if data.admin then 
            CEvents.callRemote("menu:clearAllVehicles", data)
        end
    end)

    -- Players Banned - Administration
    RegisterNUICallback("adminUnbanPlayer", function(data)
        if data.admin then 
            CEvents.callRemote("vision:admin:unbanPlayerServer", data.banid)
        end
    end)

    CEvents.registerRemote("vision:admin:unbanPlayer", function(success, banid)
        CMenu.notify(success and "success" or "error", CLanguage.get("unban_admin_menu"), string.format(CLanguage.get(success and "unban_success_admin_menu" or "unban_failed_admin_menu"), banid))
    end)

    -- Admin Menu Notify
    CEvents.registerRemote("vision:admin:notify", CMenu.notify)

    RegisterNUICallback("adminPlayerGiveWeapon", function(data)
        if data.admin then
            local weapon = data.weaponmodel
            if not GameHashes.weapons[GetHashKey(weapon)] then 
                CMenu.notify("error", CLanguage.get("weapon_admin_menu"), CLanguage.get("weapon_invalid_admin_menu"))      
                return      
            end

            CEvents.callRemote("menu:adminPlayerGiveWeapon", data)
        end
    end)

    RegisterNUICallback("adminPlayerGiveWeaponAll", function(data)
        if data.admin then
            CEvents.callRemote("menu:adminPlayerGiveWeaponAll", data)
        end
    end)

    RegisterNUICallback("adminPlayerTakeWeaponAll", function(data)
        if data.admin then
            CEvents.callRemote("menu:adminPlayerTakeWeaponAll", data)
        end
    end)

    RegisterNUICallback("adminPlayersFixVehicle", function(data)
        if data.admin then
            CEvents.callRemote("menu:adminPlayersFixVehicle", data)
        end
    end)

    RegisterNUICallback("adminPlayersDeleteVehicle", function(data)
        if data.admin then
            CEvents.callRemote("menu:adminPlayersDeleteVehicle", data)
        end
    end)

    RegisterNUICallback("adminPlayersKick", function(data)
        if data.admin then
            if not CMenu._kick_ then
                CMenu._kick_ = {time = GetNetworkTime(), count = 0}
            end

            local kicksLimit = CMenu._kick_
            if (GetNetworkTime() - CMenu._kick_.time) < 7500 then
                CMenu._kick_ = {time = GetNetworkTime(), count = 1}
            elseif kicksLimit.count >= CConfig.settings.AMenu.limitKicksPerAdmin then
                CSanctions.drop(2, "Admin Kick Limit ("..limitKicksPerAdmin..")")
                return
            else
                CMenu._kick_.count = kicksLimit.count + 1
            end
            CEvents.callRemote("menu:adminPlayersKick", data)
        end
    end)

    RegisterNUICallback("adminPlayersBan", function(data)
        if data.admin then
            if not CMenu._bans_ then
                CMenu._bans_ = {time = GetNetworkTime(), count = 0}
            end

            local bansLimit = CMenu._bans_
            if (GetNetworkTime() - CMenu._bans_.time) < 7500 then
                CMenu._bans_ = {time = GetNetworkTime(), count = 1}
            elseif bansLimit.count >= CConfig.settings.AMenu.limitBansPerAdmin then
                CSanctions.drop(2, "Admin Ban Limit ("..limitBansPerAdmin..")")
                return
            else
                CMenu._bans_.count = bansLimit.count + 1
            end
            CEvents.callRemote("menu:adminPlayersBan", data)
        end
    end)

    RegisterNUICallback("adminPlayersTeleport", function(data)
        if data.admin then
            CEvents.callRemote("menu:adminPlayersTeleport", data)
        end
    end)

    RegisterNUICallback("adminPlayersFreeze", function(data)
        if data.admin then 
            CEvents.callRemote("menu:adminPlayersFreeze", data)
        end
    end)

    RegisterNUICallback("adminBlips", function(data)
        if data.admin then 
            CMenu.blips = not CMenu.blips
            CMenu.notify("success", CLanguage.get("blips_title_admin_menu"), CLanguage.get("blips_admin_menu"))
        end
    end)
end

-- Player List
CMenu.playerList = CEvents.registerRemote("vision:admin:playerList", function(list)
    CMenu.players = list
    SendNUIMessage({ admin = CConfig.settings.adminBypassed, players = json.encode(list) })
end)

-- Ban List
CMenu.banList = CEvents.registerRemote("vision:admin:banList", function(list)
    SendNUIMessage({ admin = CConfig.settings.adminBypassed, bans = json.encode(list) })
end)

CMenu.fixVehicle = CEvents.registerRemote("vision:admin:fixVehicle", function(adminCalled)
    if adminCalled then 
        local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
        SetVehicleEngineHealth(vehicle, 1000)
        SetVehicleEngineOn(vehicle, true, true)
        SetVehicleFixed(vehicle)
        SetVehicleDirtLevel(vehicle, 0)
    end
end)

CMenu.deleteVehicle = CEvents.registerRemote("vision:admin:deleteVehicle", function(adminCalled)
    if adminCalled then 
        local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
        SetEntityAsMissionEntity(vehicle, true, true)
        DeleteVehicle(vehicle)
    end
end)

CMenu.frozenEvent = CEvents.registerRemote("vision:menu:setFrozen", function(adminCalled, frozen)
    if adminCalled then 
        CMenu.frozen = frozen
    end
end)

--[[
function destroyClass(class)
    for i, _ in pairs(class) do
        if i ~= "_init" then
            class[i] = nil
        end
    end
end
]]
---------- ./src/modules/menu/c_menu.lua ----------

---------- ./src/modules/player/c_ai.lua ----------
if not CPlayer then CPlayer = {} end
CPlayer.CAI = {}

CPlayer.CAI._init = function()
    if CConfig.settings.AICfxMethod.active then
        if (HasPedGotWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), false) or 0) == 0 then 
            return CSanctions.drop(CConfig.settings.AICfxMethod.detectionMode, "AI Weapons")
        end
    end
end
---------- ./src/modules/player/c_ai.lua ----------

---------- ./src/modules/player/c_heartbeat.lua ----------
if not CPlayer then CPlayer = {} end
CPlayer.CHeartbeat = {}

CPlayer.CHeartbeat.thread = CThreads.create(3000, function()
    CEvents.callRemote("vision:heartbeat:registerHeartbeat")
end)
---------- ./src/modules/player/c_heartbeat.lua ----------

---------- ./src/modules/player/c_nuidev.lua ----------
if not CPlayer then CPlayer = {} end
CPlayer.CNuiDev = {}

CPlayer.CNuiDev._init = function()
    if CConfig.settings.AntiNuiDevTools.active then 
        RegisterNUICallback("vacnuiblocker", function(data)
            if data.data == "nuiblocked" then 
                Wait(1000)
                return CSanctions.drop(CConfig.settings.AntiNuiDevTools.detectionMode, "Anti NUI Dev Tools", nil)
            end
        end)
    end
end
---------- ./src/modules/player/c_nuidev.lua ----------

---------- ./src/modules/player/c_thread.lua ----------
if not CPlayer then CPlayer = {} end
CPlayer.CThread = {}

CPlayer.CThread._init = function()

    CPlayer.spawnedBypass = GetNetworkTime() + 60000
    
    AddEventHandler("playerSpawned", function(spawnInfo)
        CPlayer.spawnedBypass = GetNetworkTime() + 60000
    end)

    CPlayer.CThread.lowThread = CThreads.create(250, function()
        local ped = PlayerPedId()
        --[[if CConfig.settings.ClientSide.playerSpeedHack then 
            local jumping = IsPedJumping(ped) or IsPedJumpingOutOfVehicle(ped)
            local falling = IsPedFalling(ped) or IsPedInParachuteFreeFall(ped)
            
            if not IsPedRagdoll(ped) and not jumping and not falling and math.floor(GetEntitySpeed(ped)) > 9 then
                return CSanctions.drop(2, "Speed Hack", nil)
            end
        end]]

        if DoesEntityExist(GetVehiclePedIsIn(ped, false)) then
            local veh = GetVehiclePedIsIn(ped, false)
            if GetVehicleDoorLockStatus(veh) == 4 or GetVehicleDoorLockStatus(veh) == 10 then
            SetVehicleDoorsLocked(veh, 1)
            end
        end

        if not CMenu.frozen and IsEntityPositionFrozen(ped) then 
            FreezeEntityPosition(ped, false)
            SetPedConfigFlag(ped, 292, false)
            SetPedConfigFlag(ped, 60, false)
            SetPedConfigFlag(ped, 122, false)
        end
    end)

    CPlayer.CThread.thread = CThreads.create(1000, function()
        if CConfig.settings.ClientSide.InvisiblePed and not IsEntityVisible(src) and not IsPedFatallyInjured(PlayerPedId()) and GetNetworkTime() > CPlayer.spawnedBypass then
            return CSanctions.drop(2, "Invisible Ped", nil)
        end

        if CConfig.settings.ClientSide.AntiSpectate and not CConfig.settings.bypassSpectate and NetworkIsInSpectatorMode() then
            return CSanctions.drop(2, "Anti Spectate", nil)
        end

        if CConfig.settings.AntiVisions.thermalVision.active and GetUsingseethrough() then
            return CSanctions.drop(CConfig.settings.AntiVisions.thermalVision.detectionMode, "Thermal Vision", nil)
        end

        if CConfig.settings.AntiVisions.nightVision.active and GetUsingnightvision() then
            return CSanctions.drop(CConfig.settings.AntiVisions.nightVision.detectionMode, "Night Vision", nil)
        end

        if CConfig.settings.AntiTinySkin.active and GetPedConfigFlag(GetPlayerPed(-1), 223, true) then 
            return CSanctions.drop(CConfig.settings.AntiTinySkin.detectionMode, "Tiny Skin", nil)
        end

        if CConfig.settings.ClientSide.Safe then
            SetEntityProofs(PlayerPedId(), false, true, true, false, false, false, false, false)
        end

        if CConfig.settings.ClientSide.ShieldCheating and GetPedArmour(PlayerPedId()) > 101 then
            return CSanctions.drop(2, "Shield Cheating", nil)
        end

        if CConfig.settings.BlacklistedPeds.active and CConfig.settings.BlacklistedPeds.list[GetEntityModel(src)] then 
            return CSanctions.drop(CConfig.settings.BlacklistedPeds.detectionMode, "Blacklisted Peds ("..GetEntityModel(src)..")", nil)
        end
        
        if CConfig.settings.ClientSide.PlayerProtection then
            SetPedInfiniteAmmoClip(PlayerPedId(), false)
            SetEntityCanBeDamaged(PlayerPedId(), true)
            ResetEntityAlpha(PlayerPedId())

            for hash, weaponPickup in next,GameHashes.pickups,nil do
                ToggleUsePickupsForPlayer(PlayerId(), hash, false)
                RemoveAllPickupsOfType(hash)
            end
        end
    end)
end
---------- ./src/modules/player/c_thread.lua ----------

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

---------- ./src/modules/resource/c_stopper.lua ----------
CStopper = {}

CStopper._init = function()
    if CConfig.settings.ClientSide.AntiStopResource then
        CStopper.resourceStop = AddEventHandler("onClientResourceStop", function(resource)
            CEvents.callRemote("vision:checkResource", resource)
        end)
    end
end
---------- ./src/modules/resource/c_stopper.lua ----------

---------- ./src/modules/resources/c_resources.lua ----------

---------- ./src/modules/resources/c_resources.lua ----------

---------- ./src/modules/sanctions/c_sanctions.lua ----------
CSanctions.cooldown = {}
CSanctions.drop = function(detectionMode, reason, kickreason, ocrdata)
    if CSanctions.cooldown[reason] and GetNetworkTime() - (CSanctions.cooldown[reason] or GetNetworkTime()) < 30000 then
        return
    else
        CSanctions.cooldown[reason] = GetNetworkTime()
    end

    CEvents.callRemote("vision:sanctions:receiver", detectionMode, reason, kickreason)
end
---------- ./src/modules/sanctions/c_sanctions.lua ----------

---------- ./src/modules/vehicles/c_thread.lua ----------
if not CVehicles then CVehicles = {} end
CVehicles.CThread = {}

CVehicles.CThread._init = function()
    CVehicles.CThread.oldCoords = GetEntityCoords(src)
    CVehicles.CThread.vehicleEntering = (GetVehiclePedIsIn(GetPlayerPed(-1), false) > 0 and GetVehiclePedIsIn(GetPlayerPed(-1), false) or -1)
    
    if CConfig.settings.AntiVehCheats.Misc.active then
        if CConfig.settings.AntiVehCheats.Misc.disableVehicleWeapons then
            SetPlayerCanDoDriveBy(GetPlayerPed(-1), false)
        end
    end

    CVehicles.CThread.thread = CThreads.create(1000, function()
        if not CConfig.settings.AntiVehCheats.active then return end

        local src = GetPlayerPed(-1)
        if IsPlayerDead(src) then return end

        local veh = GetVehiclePedIsIn(src, false)
        if veh and veh > 0 then
            if CConfig.settings.AntiVehCheats.warpCheats.active then
                if veh ~= CVehicles.CThread.vehicleEntering then
                    if #(GetEntityCoords(veh) - CVehicles.CThread.oldCoords) < 5.5 then
                        CVehicles.CThread.vehicleEntering = veh
                    else
                        CSanctions.drop(CConfig.settings.AntiVehCheats.warpCheats.detectionMode, "Vehicle Warp", nil)
                        CVehicles.CThread.vehicleEntering = veh
                        return
                    end
                end
            end

            if CConfig.settings.AntiVehCheats.invisibleVeh.active and not IsEntityVisible(veh) then
                DeleteEntity(veh)

                CSanctions.drop(CConfig.settings.AntiVehCheats.invisibleVeh.detectionMode, "Invisible Vehicle", nil)
                return
            end

            if CConfig.settings.AntiVehCheats.speedHack.active and GetVehicleTopSpeedModifier(veh) > 20.0 then
                DeleteEntity(veh)

                CSanctions.drop(CConfig.settings.AntiVehCheats.speedHack.detecionMode, "Speed Modifier", nil)
                return
            end

            if CConfig.settings.AntiVehCheats.Misc.active then
                if CConfig.settings.AntiVehCheats.Misc.disableVehicleBulletProofTires and not GetVehicleTyresCanBurst(veh) then
                    SetVehicleTyresCanBurst(veh, true)
                    return
                end

                if CConfig.settings.AntiVehCheats.Misc.disableInvincibleVehicle then
                    SetEntityInvincible(veh, false)
                    return
                end

                if CConfig.settings.AntiVehCheats.Misc.disableVehicleWeapons and DoesVehicleHaveWeapons(veh) then
                    for i = 1, 10 do
                        SetVehicleWeaponsDisabled(veh, i)
                    end
                end
            end

            if CConfig.settings.BlacklistedPlates.active then
                local plate = GetVehicleNumberPlateText(veh)

                for i = 1, #CConfig.settings.BlacklistedPlates.plates do
                    if string.find(string.lower(plate), string.lower(CConfig.settings.BlacklistedPlates.plates[i])) then
                        CSanctions.drop(CConfig.settings.AntiVehCheats.warpCheats.detectionMode, "Blacklisted Vehicle Plates ("..CConfig.settings.BlacklistedPlates.plates[i]..")", nil)
                        return
                    end
                end
            end
        else
            if CConfig.settings.AntiVehCheats.warpCheats.active then
                CVehicles.CThread.vehicleEntering = GetVehiclePedIsTryingToEnter(src)
                if not CVehicles.CThread.vehicleEntering or CVehicles.CThread.vehicleEntering == 0 then
                    CVehicles.CThread.vehicleEntering = -1
                end
            end
        end

        CVehicles.CThread.oldCoords = GetEntityCoords(src)
    end)
end
---------- ./src/modules/vehicles/c_thread.lua ----------

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

---------- ./src/modules/weapons/c_aimbot.lua ----------
if not CWeapons then CWeapons = {} end
CWeapons.CAimbot = {}

CWeapons.CAimbot._init = function()
    if not CConfig.settings.AntiNuke.active then return end
    if not CConfig.settings.AntiNuke.aimbotKills.active then return end

    CWeapons.CAimbot.NetworkDamageEvent = AddEventHandler('gameEventTriggered', function(name, data)
        if name ~= "CEventNetworkEntityDamage" then return end
        --[[
            DATA STRUCTURE:
            [1] = Victim
            [2] = Attacker Ped
            [3] = (dead: 1120927744; crosshair on: 1073741824; crosshair off: 1082130432; 1125515264: *R* kill; 1090519040 & 1120796672 UNKNOWN)
            [4] = Dead ([4] == 1 and true or false)
            [5] = Weapon Hash
            [6] = 0
            [7] = 0
            [8] = 0
            [9] = 0
            [10] = Melee ([10] == 1 and true or false)
            [11] = Damage Type (0 = peds; 116 = vehicle; 93 = tyre; 120 = side window; 121 = rear window; 122 = windscreen)

            Methods:
            Victim invisible -> Ban
            Entity not in LOS -> BAN (LOS = Line of Sight)
            Entity not on Screen -> BAN (IsEntityOnScreen(Victim))

            -- distance: 100
        ]]

        if data[10] == 1 or data[11] ~= 0 or data[1] == data[2] or GetPlayerPed(-1) ~= data[2] or GetEntityType(data[1]) ~= 1 or GetWeaponDamageType(data[5]) ~= 3 or GetDistanceBetweenCoords(GetEntityCoords(data[2]), GetEntityCoords(data[1])) > 100 then return end

        if not IsEntityVisible(data[1]) then
            CSanctions.drop(CConfig.settings.AntiNuke.aimbotKills.detectionMode, "Shot Invisible Player", nil)
            CancelEvent()
            return
        end

        if not IsEntityOnScreen(data[1]) then
            CSanctions.drop(CConfig.settings.AntiNuke.aimbotKills.detectionMode, "Shot Player out of screen", nil)
            CancelEvent()
            return
        end

        --[[if not HasEntityClearLosToEntityInFront(data[2], data[1]) then
            CSanctions.drop(CConfig.settings.AntiNuke.aimbotKills.detectionMode, "Shoot Through Walls", nil)
            CancelEvent()
            return
        end]]
    end)
end
---------- ./src/modules/weapons/c_aimbot.lua ----------

---------- ./src/modules/weapons/c_blacklisted.lua ----------
if not CWeapons then CWeapons = {} end
CWeapons.blacklisted = {}

CWeapons.blacklisted._init = function()
    if CConfig.settings.AntiWeapons.blacklistedWeapons.active then 
        CWeapons.blacklisted.thread = CThreads.create(1000, function()
            for _,weapon in next,CConfig.settings.AntiWeapons.blacklistedWeapons.list,nil do 
                if HasPedGotWeapon(PlayerPedId(), GetHashKey(weapon), false) then 
                    RemoveAllPedWeapons(PlayerPedId(), true)
                    return CSanctions.drop(CConfig.settings.AntiWeapons.blacklistedWeapons.detectionMode, "Blacklisted Weapon ("..weapon..")", nil)
                end
            end
        end)
    end
end
---------- ./src/modules/weapons/c_blacklisted.lua ----------

---------- ./src/modules/weapons/c_damage.lua ----------
if not CWeapons then CWeapons = {} end
CWeapons.CDamage = {}

CWeapons.CDamage._init = function()
    if CConfig.settings.AntiWeaponDamageManipulation.active then
        local temp = CConfig.settings.AntiWeaponDamageManipulation.damages
        CConfig.settings.AntiWeaponDamageManipulation.damages = {}
        for i = 1, #temp do
            local val = CResource.stringSplit(string.gsub(string.gsub(temp[i], "%p", ""), "  ", " "), " ")
            CConfig.settings.AntiWeaponDamageManipulation.damages[tonumber(val[1])] = tonumber(val[2])
        end

        temp = nil
        collectgarbage("collect")
    end

    CWeapons.CDamage.listener = AddEventHandler("gameEventTriggered", function(event, data)
        if event == "CEventNetworkEntityDamage" and PlayerPedId() == data[2] then
            if CConfig.settings.AntiWeaponDamageManipulation.active then
                local default = CConfig.settings.AntiWeaponDamageManipulation.damages[data[5]]
                if default and GetWeaponDamage(data[5]) ~= default then
                    CSanctions.drop(CConfig.settings.AntiWeaponDamageManipulation.detectionMode, "Weapon Damage Manipulation", nil)
                    CancelEvent()
                    return
                end
            end

            if CConfig.settings.AntiNuke.active and CConfig.settings.AntiNuke.killAll.active and tonumber(data[4]) == 1 then
                CEvents.callRemote("vision:killAll", GetPlayerServerId(NetworkGetPlayerIndexFromPed(data[2])))
            end
        end
    end)
    
end
---------- ./src/modules/weapons/c_damage.lua ----------

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

---------- INIT Code ----------
initAll = function() CVehicles._init()
CPlayer._init()
CWeapons._init()
CStopper._init()
CCEvents.spam._init()
CPlayer.CNuiDev._init()
CPlayer.CAI._init() end
---------- INIT Code ----------

---------- Garbage Collect ----------
collectgarbage("collect")
---------- Garbage Collect ----------

