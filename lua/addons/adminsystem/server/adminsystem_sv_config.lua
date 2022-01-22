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

--[[
    .___                              __                 __   
    |   | _____ ______   ____________/  |______    _____/  |_ 
    |   |/     \\____ \ /  _ \_  __ \   __\__  \  /    \   __\
    |   |  Y Y  \  |_> >  <_> )  | \/|  |  / __ \|   |  \  |  
    |___|__|_|  /   __/ \____/|__|   |__| (____  /___|  /__|  
              \/|__|                           \/     \/      

    This file contains config variables for the adminsystem
    This includes both settings and modules, etc.

    Do not edit anything here unless you know what you are doing!
    Thank You!

]]--

roof.server.settings.create("adminsystem_debug", {
    default = true,
    desc = "Enable/Disable debugging for the Admin System",
    category = "debug" -- main, player, debug, world
})

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
                optional = true
            }
        },
        run = function(ply, a)
            if !a["reason"] then
                ply:JLIBSendNotification("Admin System", "You have kicked ".. ply:Nick() .." for no reason")
                ply:Kick("No reason given")
            else
                ply:JLIBSendNotification("Admin System", "You have kicked " .. ply:Nick() .. " for " .. a["reason"])
                ply:Kick(a["reason"])
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