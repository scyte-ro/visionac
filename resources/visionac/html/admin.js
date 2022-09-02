let showed = false;
let resource = ""
let players = [];
let bans = [];
let selectedPlayer = -2;
let admin = false;
var Pagination = {
    AddElement: (e, t, n, d, l, m = "") => {
        null != document.getElementById(e) && (document.getElementById(e).innerHTML += `<${t} id="${n}" class="${d}" style="${l}">${m}</${t}>`)
    },
    AddText: (e, t) => {
        null != document.getElementById(e) && (document.getElementById(e).innerHTML += `${t}`)
    },
    ClearElement: e => {
        null != document.getElementById(e) && (document.getElementById(e).innerHTML = "")
    },
    DeleteElement: e => {
        document.getElementById(e).parentElement.removeChild(document.getElementById(e))
    }
};

function Notification(status, title, text) {
    new Notify({
        status: status,
        title: title,
        text: text,
        effect: 'fade',
        speed: 300,
        customClass: 'vac-notification',
        customIcon: null,
        showIcon: true,
        showCloseButton: false,
        autoclose: true,
        autotimeout: 3000,
        gap: 20,
        distance: 20,
        type: 1,
        position: 'right bottom'
    })
}
window.addEventListener("message", function(event) {
    if (event.data.admin) {
        if (event.data.show != undefined) {
            showed = event.data.show
            this.document.getElementById("adminApp").style.display = showed ? "block" : "none";
            resource = event.data.resource
        } else if (event.data.players != undefined) {
            players = JSON.parse(event.data.players)
            Pagination.ClearElement("_players_")
            for (let index = 0; index < players.length; index++) {
                let player = players[index]
                Pagination.AddElement('_players_', 'div', player.source, 'py-2.5 px-8 bg-gray-800 rounded-lg text-center grid grid-cols-2 ' + (index > 0 && 'mt-2'), '', `<p>${player.name}</p><i name="PlayerMenu" data-reference="${player.source}" data-index="${index}" class="fas fa-angle-right self-center justify-self-end cursor-pointer"></i>`)
            }
        } else if (event.data.bans != undefined) {
            bans = JSON.parse(event.data.bans)
            Pagination.ClearElement("_bans_")
            if (bans && Object.keys(bans).length > 0) {
                Object.keys(bans).forEach((key, index) => {
                    let ban = bans[key];
                    Pagination.AddElement('_bans_', 'div', ban.id, 'py-2.5 px-8 bg-gray-800 rounded-lg text-center grid grid-cols-2 ' + (index > 0 && 'mt-2'), `" onclick="unbanUser('${ban.id}')`, `<p>${ban.name}</p><i class="fas fa-circle-minus self-center justify-self-end cursor-pointer"></i>`);
                })
            } else {
                Pagination.AddElement('_bans_', 'div', '', 'py-2.5 px-8 bg-gray-800 rounded-lg text-center grid grid-cols-2', '', `<p>There are no bans</p>`)
            }
        } else if (event.data.notify != undefined) {
            Notification(event.data.type, event.data.title, event.data.text)
        } else if (event.data.language != undefined) {
            event.data.pack = JSON.parse(event.data.pack)
            let elements = document.querySelectorAll('[data-translate]')
            for (let i = 0; i < elements.length; i++) {
                let element = elements[i]
                if (event.data.pack[element.dataset.translate]) {
                    if (element.tagName == "INPUT" && element.type == "button") {
                        element.value = event.data.pack[element.dataset.translate]
                    } else {
                        element.innerHTML = event.data.pack[element.dataset.translate]
                    }
                }
            }
        }
        admin = true;
    }
})
document.addEventListener('keydown', function(key) {
    if (key.code == "Backspace") {
        fetch(`https://${resource}/adminMenuClose`, {
            method: 'POST',
            mode: 'cors',
            body: JSON.stringify({})
        }).catch((err) => {})
    }
})
let NavSelf = document.getElementById('NavSelf');
let NavPlayers = document.getElementById('NavPlayers');
let NavAdministration = document.getElementById('NavAdministration');
let SectionSelf = document.getElementById('Self');
let SectionPlayers = document.getElementById('Players');
let SectionAdministration = document.getElementById('Administration');
NavSelf.addEventListener('click', () => {
    if (!NavSelf.classList.contains('active')) NavSelf.classList.add('active');
    if (NavPlayers.classList.contains('active')) NavPlayers.classList.remove('active');
    if (NavAdministration.classList.contains('active')) NavAdministration.classList.remove('active');
    if (SectionSelf.classList.contains('hidden')) SectionSelf.classList.remove('hidden');
    if (!SectionPlayers.classList.contains('hidden')) SectionPlayers.classList.add('hidden');
    if (!SectionAdministration.classList.contains('hidden')) SectionAdministration.classList.add('hidden');
})
let Options = document.getElementsByName('Options');
for (const option of Options) {
    option.addEventListener('click', () => {
        for (const opt of Options) {
            if (opt.classList.contains('active')) opt.classList.remove('active');
            if (!document.getElementById(opt.getAttribute("data-section")).classList.contains("hidden")) document.getElementById(opt.getAttribute("data-section")).classList.add("hidden");
        }
        option.classList.add('active');
        document.getElementById(option.getAttribute("data-section")).classList.remove("hidden");
    })
}
NavPlayers.addEventListener('click', () => {
    if (NavSelf.classList.contains('active')) NavSelf.classList.remove('active');
    if (!NavPlayers.classList.contains('active')) NavPlayers.classList.add('active');
    if (NavAdministration.classList.contains('active')) NavAdministration.classList.remove('active');
    if (!SectionSelf.classList.contains('hidden')) SectionSelf.classList.add('hidden');
    if (SectionPlayers.classList.contains('hidden')) SectionPlayers.classList.remove('hidden');
    if (!SectionAdministration.classList.contains('hidden')) SectionAdministration.classList.add('hidden');
    let PlayerMenus = document.getElementsByName('PlayerMenu');
    for (const playerMenu of PlayerMenus) {
        playerMenu.addEventListener('click', () => {
            if (!document.getElementById('PlayerLists').classList.contains('hidden')) document.getElementById('PlayerLists').classList.add('hidden');
            if (document.getElementById('PlayerListMenu').classList.contains('hidden')) document.getElementById('PlayerListMenu').classList.remove('hidden');
            document.getElementById('PlayerListMenu').setAttribute('data-reference', playerMenu.dataset.reference)
            selectedPlayer = playerMenu.dataset.reference
            Pagination.ClearElement('_identifiers_')
            let playersData = players[Number(playerMenu.dataset.index)]
            Object.keys(playersData.identifiers).forEach((key, index) => {
                const identifier = playersData.identifiers[key];
                Pagination.AddElement('_identifiers_', 'div', '', 'py-2.5 px-8 bg-gray-800 rounded-lg text-center grid grid-cols-2 ' + (index > 0 && 'mt-2'), '', `<p class="justify-self-start">${key.toUpperCase()}</p><p class="justify-self-end cursor-pointer">${identifier}</p>`)
            })
        })
    }
    let PlayerMenuOptions = document.getElementsByName('PlayerListMenuOptions');
    for (const option of PlayerMenuOptions) {
        option.addEventListener('click', () => {
            let execution = option.dataset.execute;
            if (execution) {
                switch (execution) {
                    case "GoBack": {
                        if (document.getElementById('PlayerLists').classList.contains('hidden')) document.getElementById('PlayerLists').classList.remove('hidden');
                        if (!document.getElementById('PlayerListMenu').classList.contains('hidden')) document.getElementById('PlayerListMenu').classList.add('hidden');
                        document.getElementById('PlayerListMenu').removeAttribute('data-reference')
                    }
                }
            } else {
                for (const opt of PlayerMenuOptions) {
                    if (opt.classList.contains('active')) opt.classList.remove('active');
                    if (opt.dataset.section)
                        if (!document.getElementById(opt.getAttribute("data-section")).classList.contains("hidden")) document.getElementById(opt.getAttribute("data-section")).classList.add("hidden");
                }
                option.classList.add('active');
                document.getElementById(option.getAttribute("data-section")).classList.remove("hidden");
            }
        })
    }
})
NavAdministration.addEventListener('click', () => {
    if (NavSelf.classList.contains('active')) NavSelf.classList.remove('active');
    if (NavPlayers.classList.contains('active')) NavPlayers.classList.remove('active');
    if (!NavAdministration.classList.contains('active')) NavAdministration.classList.add('active');
    if (!SectionSelf.classList.contains('hidden')) SectionSelf.classList.add('hidden');
    if (!SectionPlayers.classList.contains('hidden')) SectionPlayers.classList.add('hidden');
    if (SectionAdministration.classList.contains('hidden')) SectionAdministration.classList.remove('hidden');
    let Options = document.getElementsByName('AdministrationOptions');
    for (const option of Options) {
        option.addEventListener('click', () => {
            for (const opt of Options) {
                if (opt.classList.contains('active')) opt.classList.remove('active');
                if (!document.getElementById(opt.getAttribute("data-section")).classList.contains("hidden")) document.getElementById(opt.getAttribute("data-section")).classList.add("hidden");
            }
            option.classList.add('active');
            document.getElementById(option.getAttribute("data-section")).classList.remove("hidden");
        })
    }
})
let VehicleSpawn = document.getElementById('VehicleSpawn');
let VehicleModel = document.getElementById('VehicleModel');
VehicleSpawn.addEventListener('click', () => {
    let input = VehicleModel.value;
    if (input.length > 0) {
        VehicleModel.value = ""
        fetch(`https://${resource}/visionacspawnadminvehicle`, {
            method: 'POST',
            mode: 'cors',
            body: JSON.stringify({
                admin: admin,
                vehiclemodel: input
            })
        }).catch((errs) => {})
    }
})
let VehicleFix = document.getElementById('VehicleFix');
VehicleFix.addEventListener('click', () => {
    fetch(`https://${resource}/adminFixCurrentVehicle`, {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify({
            admin: admin,
        })
    }).catch((errs) => {})
})
let VehicleDestroy = document.getElementById('VehicleDestroy');
VehicleDestroy.addEventListener('click', () => {
    fetch(`https://${resource}/adminDeleteCurrentVehicle`, {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify({
            admin: admin,
        })
    }).catch((errs) => {})
})
let WeaponGive = document.getElementById('WeaponGive');
let WeaponModel = document.getElementById('WeaponModel');
WeaponGive.addEventListener('click', () => {
    let input = WeaponModel.value;
    if (input.length > 0) {
        WeaponModel.value = ""
        fetch(`https://${resource}/adminGiveWeapon`, {
            method: 'POST',
            mode: 'cors',
            body: JSON.stringify({
                admin: admin,
                weaponmodel: input
            })
        }).catch((errs) => {})
    }
})
let WeaponGiveAll = document.getElementById('WeaponGiveAll');
WeaponGiveAll.addEventListener('click', () => {
    fetch(`https://${resource}/adminGiveAllWeapons`, {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify({
            admin: admin,
        })
    }).catch((errs) => {})
})
let WeaponTakeAll = document.getElementById('WeaponTakeAll');
WeaponTakeAll.addEventListener('click', () => {
    fetch(`https://${resource}/adminTakeAllWeapons`, {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify({
            admin: admin,
        })
    }).catch((errs) => {})
})
let GiveHealth = document.getElementById('GiveHealth');
GiveHealth.addEventListener('click', () => {
    fetch(`https://${resource}/adminHealth`, {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify({
            admin: admin,
        })
    }).catch((errs) => {})
})
let GiveArmor = document.getElementById('GiveArmor');
GiveArmor.addEventListener('click', () => {
    fetch(`https://${resource}/adminArmour`, {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify({
            admin: admin,
        })
    }).catch((errs) => {})
})
let Suicide = document.getElementById('Suicide');
Suicide.addEventListener('click', () => {
    fetch(`https://${resource}/adminSuicide`, {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify({
            admin: admin,
        })
    }).catch((errs) => {})
})
let TeleportToWaypoint = document.getElementById('TeleportToWaypoint');
TeleportToWaypoint.addEventListener('click', () => {
    fetch(`https://${resource}/adminTpToWaypoint`, {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify({
            admin: admin,
        })
    }).catch((errs) => {})
})
let Blips = document.getElementById('Blips');
Blips.addEventListener('click', () => {
    fetch(`https://${resource}/adminBlips`, {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify({
            admin: admin,
        })
    }).catch((errs) => {})
})
let ClearAreaPeds = document.getElementById('ClearAreaPeds');
ClearAreaPeds.addEventListener('click', () => {
    fetch(`https://${resource}/adminClearAreaPeds`, {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify({
            admin: admin,
        })
    }).catch((errs) => {})
})
let ClearAreaObjects = document.getElementById('ClearAreaObjects');
ClearAreaObjects.addEventListener('click', () => {
    fetch(`https://${resource}/adminClearAreaObjects`, {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify({
            admin: admin,
        })
    }).catch((errs) => {})
})
let ClearUnusedVehicles = document.getElementById('ClearUnusedVehicles');
ClearUnusedVehicles.addEventListener('click', () => {
    fetch(`https://${resource}/adminClearUnusedVehicles`, {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify({
            admin: admin,
        })
    }).catch((errs) => {})
});
let ClearAllVehicles = document.getElementById('ClearAllVehicles');
ClearAllVehicles.addEventListener('click', () => {
    fetch(`https://${resource}/adminClearAllVehicles`, {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify({
            admin: admin,
        })
    }).catch((errs) => {})
});
let PlayersWeaponGive = document.getElementById('PlayersWeaponGive');
PlayersWeaponGive.addEventListener('click', () => {
    let input = document.getElementById('PlayersWeaponInput').value;
    if (input.length > 0) {
        document.getElementById('PlayersWeaponInput').value = ""
        fetch(`https://${resource}/adminPlayerGiveWeapon`, {
            method: 'POST',
            mode: 'cors',
            body: JSON.stringify({
                admin: admin,
                weaponmodel: input,
                player: document.getElementById('PlayerListMenu').dataset.reference
            })
        }).catch((errs) => {})
    }
})
let PlayersWeaponGiveAll = document.getElementById('PlayersWeaponGiveAll');
PlayersWeaponGiveAll.addEventListener('click', () => {
    fetch(`https://${resource}/adminPlayerGiveWeaponAll`, {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify({
            admin: admin,
            player: document.getElementById('PlayerListMenu').dataset.reference
        })
    }).catch((errs) => {})
})
let PlayersWeaponTakeAll = document.getElementById('PlayersWeaponTakeAll');
PlayersWeaponTakeAll.addEventListener('click', () => {
    fetch(`https://${resource}/adminPlayerTakeWeaponAll`, {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify({
            admin: admin,
            player: document.getElementById('PlayerListMenu').dataset.reference
        })
    }).catch((errs) => {})
})
let PlayersFixVehicle = document.getElementById('PlayersFixVehicle');
PlayersFixVehicle.addEventListener('click', () => {
    fetch(`https://${resource}/adminPlayersFixVehicle`, {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify({
            admin: admin,
            player: document.getElementById('PlayerListMenu').dataset.reference
        })
    }).catch((errs) => {})
})
let PlayersDeleteVehicle = document.getElementById('PlayersDeleteVehicle');
PlayersDeleteVehicle.addEventListener('click', () => {
    fetch(`https://${resource}/adminPlayersDeleteVehicle`, {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify({
            admin: admin,
            player: document.getElementById('PlayerListMenu').dataset.reference
        })
    }).catch((errs) => {})
})
let PlayersKick = document.getElementById('PlayersKick');
PlayersKick.addEventListener('click', () => {
    fetch(`https://${resource}/adminPlayersKick`, {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify({
            admin: admin,
            player: document.getElementById('PlayerListMenu').dataset.reference
        })
    }).catch((errs) => {})
})
let PlayersBan = document.getElementById('PlayersBan');
PlayersBan.addEventListener('click', () => {
    fetch(`https://${resource}/adminPlayersBan`, {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify({
            admin: admin,
            player: document.getElementById('PlayerListMenu').dataset.reference
        })
    }).catch((errs) => {})
})
let PlayersTeleport = document.getElementById('PlayersTeleport');
PlayersTeleport.addEventListener('click', () => {
    fetch(`https://${resource}/adminPlayersTeleport`, {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify({
            admin: admin,
            player: document.getElementById('PlayerListMenu').dataset.reference
        })
    }).catch((errs) => {})
})
let PlayersFreeze = document.getElementById('PlayersFreeze');
PlayersFreeze.addEventListener('click', () => {
    fetch(`https://${resource}/adminPlayersFreeze`, {
        method: 'POST',
        mode: 'cors',
        body: JSON.stringify({
            admin: admin,
            player: document.getElementById('PlayerListMenu').dataset.reference
        })
    }).catch((errs) => {})
})