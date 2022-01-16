adminsystem = adminsystem or {}
adminsystem.server = adminsystem.server or {}
adminsystem.server.net = adminsystem.server.net or {}
adminsystem.server.chat = adminsystem.server.chat or {}
adminsystem.server.player = adminsystem.server.player or {}
adminsystem.server.groups = adminsystem.server.groups or {}
local plyMeta = FindMetaTable("Player")

--[[
  ___                            _              _   
 |_ _|_ __ ___  _ __   ___  _ __| |_ __ _ _ __ | |_ 
  | || '_ ` _ \| '_ \ / _ \| '__| __/ _` | '_ \| __|
  | || | | | | | |_) | (_) | |  | || (_| | | | | |_ 
 |___|_| |_| |_| .__/ \___/|_|   \__\__,_|_| |_|\__|
               |_|                                  
DO NOT TRY TO CHANGE OR EDIT A PLAYERS GROUP
ON THE CLIENTSIDE!

PLEASE ACCESS DATA ONLY ON THE SERVERSIDE
]]--
roof.server.db.create("adminsystem_players", {
    [1] = {
        name = "'g'",
        type = "TEXT",
    },
    [2] = {
        name = "id",
        type = "TEXT",
    },
})

function adminsystem.server.player.changeGroup(ply, group)
    if !adminsystem.server.groups.find(group) then
        roof.server.errors.severe("The group: "..group.." does not exist!")    
    return end

    local id = ply:SteamID64()
    local data = roof.server.db.loadSpecific("adminsystem_players", "g", "id", id)

    print(data)
    if data then
        roof.server.db.updateSpecific("adminsystem_players", "g", "id", group, id)
        roof.server.errors.change(ply:Nick() .." has changed group to "..group)
    else
        roof.server.db.updateSpecific("adminsystem_players", "g", "id", group, id)
        roof.server.errors.change(ply:Nick() .." has changed group to "..group)
    end
end

function adminsystem.server.player.findGroup(ply)
    if !IsValid(ply) then return end

    local id = ply:SteamID64()
    local data = roof.server.db.loadSpecific("adminsystem_players", "g", "id", id)

    if data then return data else
       return false 
    end
end