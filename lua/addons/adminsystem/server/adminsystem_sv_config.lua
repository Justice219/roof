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
        args = {
            [1] = {
                name = "reason",
                description = "The reason for the kick",                
                type = "string",
                optional = false
            }
        },
        run = function(ply, a)
            if !a then
                ply:JLIBSendNotification("You need to specify a player to kick.")
                --ply:Kick("No reason given")
            else
                ply:JLIBSendNotification("You have kicked " .. a[1] .. ".")
                --ply:Kick(a[1])
            end
        end,
    })
    adminsystem.server.modules.create("ban", {
        name = "Ban",
        description = "Bans a player",
        usage = "/ban <player> <reason>",
        permission = "adminsystem.ban",
        args = {

        },
        run = function(ply, a)

        end,
    })
    adminsystem.server.modules.create("kill", {
        name = "Slay",
        description = "Kills a player",
        usage = "/Slay <player>",
        permission = "adminsystem.slay",
        run = function(ply, a)
            if !IsValid(ply) then return end
            ply:Kill()
        end,
    })



end

adminsystem.server.modules.load()