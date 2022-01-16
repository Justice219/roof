roof = roof or {}
roof.server = roof.server or {}
roof.server.db = roof.server.db or {}
roof.server.errors = roof.server.errors or {}

adminsystem = adminsystem or {}
adminsystem.server = adminsystem.server or {}
adminsystem.server.net = adminsystem.server.net or {}
adminsystem.server.chat = adminsystem.server.chat or {}
adminsystem.server.data = adminsystem.server.data or {}
adminsystem.server.groups = adminsystem.server.groups or {}
adminsystem.server.data.groups = adminsystem.server.data.groups or {}

function adminsystem.server.modules.load()
    adminsystem.server.modules.create("kick", {
        name = "Kick",
        description = "Kick a player",
        usage = "/kick <player> <reason>",
        permission = "adminsystem.kick",
    })
    adminsystem.server.modules.create("ban", {
        name = "Ban",
        description = "Bans a player",
        usage = "/ban <player> <reason>",
        permission = "adminsystem.ban",
    })
    adminsystem.server.modules.create("kill", {
        name = "Kill",
        description = "Kills a player",
        usage = "/kill <player>",
        permission = "adminsystem.kill",
    })



end

adminsystem.server.modules.load()