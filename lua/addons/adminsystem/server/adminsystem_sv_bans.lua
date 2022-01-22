roof = roof or {}
roof.server = roof.server or {}
roof.server.player = roof.server.player or {}

adminsystem = adminsystem or {}
adminsystem.server = adminsystem.server or {}
adminsystem.server.net = adminsystem.server.net or {}
adminsystem.server.chat = adminsystem.server.chat or {}
adminsystem.server.data = adminsystem.server.data or {}
adminsystem.server.bans = adminsystem.server.bans or {}

roof.server.db.create("adminsystem_bans", {
    [1] = {
        name = "bans_tbl",
        type = "TEXT",
    },
})


function adminsystem.server.bans.add(steamid, reason)


end